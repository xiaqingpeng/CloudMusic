#ifndef CONFIG_H
#define CONFIG_H

#include <QString>
#include <QSettings>
#include <memory>

namespace CloudMusic {
namespace Core {

/**
 * @brief 配置管理类
 * 
 * 负责读取和管理应用程序配置
 */
class Config {
public:
    /**
     * @brief 获取单例实例
     */
    static Config& instance();
    
    /**
     * @brief 加载配置文件
     * @param configPath 配置文件路径（可选）
     * @return 是否加载成功
     */
    bool load(const QString& configPath = QString());
    
    /**
     * @brief 保存配置
     * @return 是否保存成功
     */
    bool save() const;
    
    /**
     * @brief 获取配置值
     * @param key 配置键（支持 section/key 格式）
     * @param defaultValue 默认值
     * @return 配置值
     */
    QVariant get(const QString& key, const QVariant& defaultValue = QVariant()) const;
    
    /**
     * @brief 设置配置值
     * @param key 配置键
     * @param value 配置值
     */
    void set(const QString& key, const QVariant& value) const;
    
    /**
     * @brief 获取字符串配置
     */
    QString getString(const QString& key, const QString& defaultValue = QString()) const;
    
    /**
     * @brief 获取整数配置
     */
    int getInt(const QString& key, int defaultValue = 0) const;
    
    /**
     * @brief 获取布尔配置
     */
    bool getBool(const QString& key, bool defaultValue = false) const;
    
    /**
     * @brief 获取配置文件路径
     */
    QString configPath() const { return m_configPath; }

private:
    Config() = default;
    ~Config() = default;
    
    Config(const Config&) = delete;
    Config& operator=(const Config&) = delete;

    static QString getDefaultConfigPath();
    
    std::unique_ptr<QSettings> m_settings;
    QString m_configPath;
};

} // namespace Core
} // namespace CloudMusic

#endif // CONFIG_H
