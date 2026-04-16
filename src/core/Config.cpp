#include "Config.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QDebug>

namespace CloudMusic {
namespace Core {

Config& Config::instance() {
    static Config instance;
    return instance;
}

bool Config::load(const QString& configPath) {
    if (m_settings) {
        return true; // Already loaded
    }
    
    m_configPath = configPath.isEmpty() ? getDefaultConfigPath() : configPath;
    
    // 简单创建 QSettings，不做任何文件操作
    m_settings = std::make_unique<QSettings>(
        m_configPath, 
        QSettings::IniFormat
    );
    
    return true;
}

bool Config::save() {
    if (!m_settings) {
        qWarning() << "Config: Settings not initialized";
        return false;
    }
    
    m_settings->sync();
    
    QSettings::Status status = m_settings->status();
    if (status != QSettings::NoError) {
        qCritical() << "Config: Failed to save, status:" << status;
        return false;
    }
    
    return true;
}

QVariant Config::get(const QString& key, const QVariant& defaultValue) const {
    if (!m_settings) {
        return defaultValue;
    }
    
    return m_settings->value(key, defaultValue);
}

void Config::set(const QString& key, const QVariant& value) {
    if (!m_settings) {
        qWarning() << "Settings not initialized";
        return;
    }
    
    m_settings->setValue(key, value);
}

QString Config::getString(const QString& key, const QString& defaultValue) const {
    return get(key, defaultValue).toString();
}

int Config::getInt(const QString& key, int defaultValue) const {
    return get(key, defaultValue).toInt();
}

bool Config::getBool(const QString& key, bool defaultValue) const {
    return get(key, defaultValue).toBool();
}

QString Config::getDefaultConfigPath() const {
    QString configDir = QStandardPaths::writableLocation(
        QStandardPaths::AppConfigLocation
    );
    
    QDir dir(configDir);
    if (!dir.exists()) {
        dir.mkpath(".");
    }
    
    return dir.filePath("app.config");
}

} // namespace Core
} // namespace CloudMusic
