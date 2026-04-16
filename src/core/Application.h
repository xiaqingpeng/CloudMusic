#ifndef APPLICATION_H
#define APPLICATION_H

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QString>
#include <memory>

namespace CloudMusic {
namespace Core {

/**
 * @brief 应用程序主类
 * 
 * 管理应用程序的生命周期、初始化和清理
 */
class Application {
public:
    /**
     * @brief 获取单例实例
     */
    static Application& instance();
    
    /**
     * @brief 初始化应用程序
     * @param argc 命令行参数数量
     * @param argv 命令行参数数组
     * @return 初始化是否成功
     */
    bool initialize(int argc, char *argv[]);
    
    /**
     * @brief 运行应用程序
     * @return 应用程序退出码
     */
    int run();
    
    /**
     * @brief 清理资源
     */
    void cleanup();
    
    /**
     * @brief 获取 QML 引擎
     */
    QQmlApplicationEngine* engine() const { return m_engine.get(); }
    
    /**
     * @brief 获取应用程序版本
     */
    QString version() const;
    
    /**
     * @brief 获取应用程序名称
     */
    QString name() const;

private:
    Application() = default;
    ~Application() = default;
    
    // 禁止拷贝和赋值
    Application(const Application&) = delete;
    Application& operator=(const Application&) = delete;
    
    bool loadConfig();
    bool setupQmlEngine();
    void registerQmlTypes();
    
    std::unique_ptr<QGuiApplication> m_app;
    std::unique_ptr<QQmlApplicationEngine> m_engine;
    bool m_initialized = false;
};

} // namespace Core
} // namespace CloudMusic

#endif // APPLICATION_H
