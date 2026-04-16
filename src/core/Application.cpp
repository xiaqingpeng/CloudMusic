#include "Application.h"
#include "Version.h"
#include <QQmlContext>
#include <QFile>
#include <QDebug>

namespace CloudMusic {
namespace Core {

Application& Application::instance() {
    static Application instance;
    return instance;
}

bool Application::initialize(QGuiApplication& app) {
    if (m_initialized) {
        qWarning() << "Application already initialized";
        return false;
    }
    
    // 保存 QGuiApplication 引用
    m_app = &app;
    m_app->setApplicationName(PROJECT_NAME);
    m_app->setApplicationVersion(PROJECT_VERSION);
    m_app->setOrganizationName("CloudMusic");
    m_app->setOrganizationDomain("cloudmusic.com");
    
    // 加载配置
    if (!loadConfig()) {
        qWarning() << "Failed to load configuration, using defaults";
    }
    
    // 设置 QML 引擎
    if (!setupQmlEngine()) {
        qCritical() << "Failed to setup QML engine";
        return false;
    }
    
    m_initialized = true;
    return true;
}

int Application::run() {
    if (!m_initialized) {
        qCritical() << "Application not initialized";
        return -1;
    }
    
    if (!m_engine) {
        qCritical() << "QML engine not available";
        return -1;
    }
    
    // 尝试多个可能的 QML 路径（跨平台兼容）
    QStringList possiblePaths = {
        "qrc:/qt/qml/CloudMusic/src/ui/Main.qml",  // macOS Qt 6.10
        "qrc:/CloudMusic/src/ui/Main.qml",         // Linux Qt 6.4
        "qrc:///CloudMusic/src/ui/Main.qml"        // 备用路径
    };
    
    QUrl url;
    for (const QString& path : possiblePaths) {
        QUrl testUrl(path);
        
        // 检查资源是否存在
        if (QFile::exists(testUrl.toString().replace("qrc:", ":"))) {
            url = testUrl;
            break;
        }
    }
    
    if (url.isEmpty()) {
        qCritical() << "Could not find Main.qml in any known location";
        return -1;
    }
    
    QObject::connect(
        m_engine.get(), &QQmlApplicationEngine::objectCreated,
        m_app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl) {
                qCritical() << "Failed to load main QML file:" << url;
                QCoreApplication::exit(-1);
            }
        },
        Qt::QueuedConnection
    );
    
    m_engine->load(url);
    
    if (m_engine->rootObjects().isEmpty()) {
        qCritical() << "No root objects loaded";
        return -1;
    }
    
    return m_app->exec();
}

void Application::cleanup() {
    if (m_engine) {
        m_engine.reset();
    }
    
    m_app = nullptr;
    m_initialized = false;
}

QString Application::version() const {
    return QString(PROJECT_VERSION);
}

QString Application::name() const {
    return QString(PROJECT_NAME);
}

bool Application::loadConfig() {
    // TODO: 实现配置文件加载
    return true;
}

bool Application::setupQmlEngine() {
    m_engine = std::make_unique<QQmlApplicationEngine>();
    
    if (!m_engine) {
        return false;
    }
    
    // 注册 QML 类型
    registerQmlTypes();
    
    // 设置上下文属性
    QQmlContext* rootContext = m_engine->rootContext();
    rootContext->setContextProperty("appVersion", version());
    rootContext->setContextProperty("appName", name());
    
    return true;
}

void Application::registerQmlTypes() {
    // TODO: 注册自定义 QML 类型
}

} // namespace Core
} // namespace CloudMusic
