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
    
    // 初始化日志系统
    Logger::instance().initialize();

    // 加载配置
    Config::instance().load();

    // 初始化应用程序
    Application& app = Application::instance();
    if (!app.initialize(guiApp)) {
        qCritical() << "Failed to initialize application";
        return -1;
    }

    // 运行应用程序
    int exitCode = app.run();

    // 清理资源
    app.cleanup();
    Logger::instance().shutdown();

    return exitCode;
}
