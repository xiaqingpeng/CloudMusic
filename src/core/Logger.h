#ifndef LOGGER_H
#define LOGGER_H

#include <QString>
#include <QFile>
#include <QTextStream>
#include <QMutex>
#include <memory>

namespace CloudMusic {
namespace Core {

/**
 * @brief 日志级别
 */
enum class LogLevel {
    Debug,
    Info,
    Warning,
    Error,
    Critical
};

/**
 * @brief 日志管理类
 * 
 * 提供日志记录功能，支持文件输出和控制台输出
 */
class Logger {
public:
    /**
     * @brief 获取单例实例
     */
    static Logger& instance();
    
    /**
     * @brief 初始化日志系统
     * @param logDir 日志目录
     * @param logLevel 日志级别
     * @return 是否初始化成功
     */
    bool initialize(const QString& logDir = QString(), 
                   LogLevel logLevel = LogLevel::Info);
    
    /**
     * @brief 记录日志
     * @param level 日志级别
     * @param message 日志消息
     * @param file 源文件名
     * @param line 行号
     */
    void log(LogLevel level, const QString& message, 
            const char* file = nullptr, int line = 0);
    
    /**
     * @brief 设置日志级别
     */
    void setLogLevel(LogLevel level) { m_logLevel = level; }
    
    /**
     * @brief 获取日志级别
     */
    LogLevel logLevel() const { return m_logLevel; }
    
    /**
     * @brief 启用/禁用控制台输出
     */
    void setConsoleOutput(bool enabled) { m_consoleOutput = enabled; }
    
    /**
     * @brief 启用/禁用文件输出
     */
    void setFileOutput(bool enabled) { m_fileOutput = enabled; }
    
    /**
     * @brief 刷新日志缓冲区
     */
    void flush();
    
    /**
     * @brief 关闭日志系统
     */
    void shutdown();

private:
    Logger() = default;
    ~Logger();
    
    Logger(const Logger&) = delete;
    Logger& operator=(const Logger&) = delete;
    
    QString levelToString(LogLevel level) const;
    QString getCurrentTimestamp() const;
    QString getLogFilePath() const;
    void rotateLogFile();
    
    std::unique_ptr<QFile> m_logFile;
    std::unique_ptr<QTextStream> m_logStream;
    QMutex m_mutex;
    
    LogLevel m_logLevel = LogLevel::Info;
    QString m_logDir;
    bool m_consoleOutput = true;
    bool m_fileOutput = true;
    bool m_initialized = false;
};

// 便捷宏
#ifdef ENABLE_LOGGING
    #define LOG_DEBUG(msg) \
        CloudMusic::Core::Logger::instance().log( \
            CloudMusic::Core::LogLevel::Debug, msg, __FILE__, __LINE__)
    
    #define LOG_INFO(msg) \
        CloudMusic::Core::Logger::instance().log( \
            CloudMusic::Core::LogLevel::Info, msg, __FILE__, __LINE__)
    
    #define LOG_WARNING(msg) \
        CloudMusic::Core::Logger::instance().log( \
            CloudMusic::Core::LogLevel::Warning, msg, __FILE__, __LINE__)
    
    #define LOG_ERROR(msg) \
        CloudMusic::Core::Logger::instance().log( \
            CloudMusic::Core::LogLevel::Error, msg, __FILE__, __LINE__)
    
    #define LOG_CRITICAL(msg) \
        CloudMusic::Core::Logger::instance().log( \
            CloudMusic::Core::LogLevel::Critical, msg, __FILE__, __LINE__)
#else
    #define LOG_DEBUG(msg)
    #define LOG_INFO(msg)
    #define LOG_WARNING(msg)
    #define LOG_ERROR(msg)
    #define LOG_CRITICAL(msg)
#endif

} // namespace Core
} // namespace CloudMusic

#endif // LOGGER_H
