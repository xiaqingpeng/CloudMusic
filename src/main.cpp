#include "core/Application.h"
#include "core/Config.h"
#include "core/Logger.h"
#include "Version.h"

#include <QGuiApplication>
#include <QDebug>

using namespace CloudMusic::Core;

int main(int argc, char *argv[])
{
    // 设置平台插件（在创建 QGuiApplication 之前）
    if (qEnvironmentVariableIsEmpty("QT_QPA_PLATFORM")) {
        #ifdef Q_OS_LINUX
            // Linux 上检测显示环境
            if (qEnvironmentVariableIsEmpty("DISPLAY") && qEnvironmentVariableIsEmpty("WAYLAND_DISPLAY")) {
                qputenv("QT_QPA_PLATFORM", "offscreen");
            }
        #endif
    }
    
    // 创建 QGuiApplication（必须在栈上）
    QGuiApplication guiApp(argc, argv);
    
    qDebug() << "=== CloudMusic Starting ===";
    qDebug() << "Version:" << PROJECT_VERSION;
    qDebug() << "Platform:" << QGuiApplication::platformName();
    
    // 初始化日志系统
    qDebug() << "Initializing logger...";
    Logger::instance().initialize();
    qDebug() << "Logger initialized";

    // 加载配置
    qDebug() << "Loading configuration...";
    Config::instance().load();
    qDebug() << "Configuration loaded";

    // 初始化应用程序
    qDebug() << "Initializing application...";
    Application& app = Application::instance();
    if (!app.initialize(guiApp)) {
        qCritical() << "Failed to initialize application";
        return -1;
    }
    qDebug() << "Application initialized";

    // 运行应用程序
    qDebug() << "Running application...";
    int exitCode = app.run();

    // 清理资源
    qDebug() << "Cleaning up...";
    app.cleanup();
    Logger::instance().shutdown();

    qDebug() << "Application exited with code:" << exitCode;
    return exitCode;
}
