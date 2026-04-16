#include "Logger.h"
#include <QStandardPaths>
#include <QDir>
#include <QDateTime>
#include <QFileInfo>
#include <QDebug>
#include <iostream>

namespace CloudMusic {
namespace Core {

Logger& Logger::instance() {
    static Logger instance;
    return instance;
}

Logger::~Logger() {
    shutdown();
}

bool Logger::initialize(const QString& logDir, LogLevel logLevel) {
    if (m_initialized) {
        return true;
    }
    
    m_logLevel = logLevel;
    m_initialized = true;
    
    return true;
}

void Logger::log(LogLevel level, const QString& message, 
                const char* file, int line) {
    if (!m_initialized && level < LogLevel::Warning) {
        return;
    }
    
    if (level < m_logLevel) {
        return;
    }
    
    QMutexLocker locker(&m_mutex);
    
    QString timestamp = getCurrentTimestamp();
    QString levelStr = levelToString(level);
    QString logMessage = QString("[%1] [%2] %3")
        .arg(timestamp)
        .arg(levelStr)
        .arg(message);
    
    if (file && line > 0) {
        QString fileName = QFileInfo(file).fileName();
        logMessage += QString(" (%1:%2)").arg(fileName).arg(line);
    }
    
    // 控制台输出
    if (m_consoleOutput) {
        if (level >= LogLevel::Error) {
            std::cerr << logMessage.toStdString() << std::endl;
        } else {
            std::cout << logMessage.toStdString() << std::endl;
        }
    }
    
    // 文件输出
    if (m_fileOutput && m_logStream) {
        *m_logStream << logMessage << "\n";
        m_logStream->flush();
        
        // 检查文件大小，必要时轮转
        if (m_logFile->size() > 10 * 1024 * 1024) { // 10MB
            rotateLogFile();
        }
    }
}

void Logger::flush() {
    QMutexLocker locker(&m_mutex);
    
    if (m_logStream) {
        m_logStream->flush();
    }
}

void Logger::shutdown() {
    QMutexLocker locker(&m_mutex);
    
    if (!m_initialized) {
        return;
    }
    
    log(LogLevel::Info, "Logger shutting down");
    
    if (m_logStream) {
        m_logStream->flush();
        m_logStream.reset();
    }
    
    if (m_logFile) {
        m_logFile->close();
        m_logFile.reset();
    }
    
    m_initialized = false;
}

QString Logger::levelToString(LogLevel level) const {
    switch (level) {
        case LogLevel::Debug:    return "DEBUG";
        case LogLevel::Info:     return "INFO ";
        case LogLevel::Warning:  return "WARN ";
        case LogLevel::Error:    return "ERROR";
        case LogLevel::Critical: return "CRIT ";
        default:                 return "UNKNOWN";
    }
}

QString Logger::getCurrentTimestamp() const {
    return QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss.zzz");
}

QString Logger::getLogFilePath() const {
    QString date = QDate::currentDate().toString("yyyy-MM-dd");
    return QString("%1/cloudmusic_%2.log").arg(m_logDir).arg(date);
}

void Logger::rotateLogFile() {
    if (!m_logFile) {
        return;
    }
    
    QString currentPath = m_logFile->fileName();
    m_logFile->close();
    
    // 重命名当前文件
    QString timestamp = QDateTime::currentDateTime().toString("yyyyMMdd_hhmmss");
    QString backupPath = QString("%1.%2").arg(currentPath).arg(timestamp);
    QFile::rename(currentPath, backupPath);
    
    // 打开新文件
    m_logFile->setFileName(currentPath);
    if (!m_logFile->open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text)) {
        qCritical() << "Failed to open rotated log file:" << currentPath;
        return;
    }
    
    log(LogLevel::Info, QString("Log file rotated to: %1").arg(backupPath));
}

} // namespace Core
} // namespace CloudMusic
