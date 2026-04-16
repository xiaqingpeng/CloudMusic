#include "core/Application.h"
#include "core/Config.h"
#include "core/Logger.h"
#include "Version.h"

#include <QDebug>

using namespace CloudMusic::Core;

int main(int argc, char *argv[])
{
    qDebug() << "=== CloudMusic Starting ===";
    qDebug() << "Version:" << PROJECT_VERSION;
    
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
    if (!app.initialize(argc, argv)) {
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
