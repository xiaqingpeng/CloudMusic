#include "Application.h"
#include "Version.h"
#include <QQmlContext>
#include <QDebug>

namespace CloudMusic {
namespace Core {

Application& Application::instance() {
    static Application instance;
    return instance;
}

bool Application::initialize(int argc, char *argv[]) {
    if (m_initialized) {
        qWarning() << "Application already initialized";
        return false;
    }
    
    qDebug() << "=== CloudMusic Initializing ===" << version();
    
    // 创建 QGuiApplication
    m_app = std::make_unique<QGuiApplication>(argc, argv);
    m_app->setApplicationName(PROJECT_NAME);
    m_app->setApplicationVersion(PROJECT_VERSION);
    m_app->setOrganizationName("CloudMusic");
    m_app->setOrganizationDomain("cloudmusic.com");
    
    qDebug() << "QGuiApplication created";
    
    // 加载配置
    if (!loadConfig()) {
        qWarning() << "Failed to load configuration, using defaults";
    }
    
    qDebug() << "Config loaded";
    
    // 设置 QML 引擎
    if (!setupQmlEngine()) {
        qCritical() << "Failed to setup QML engine";
        return false;
    }
    
    qDebug() << "QML engine setup complete";
    
    m_initialized = true;
    qDebug() << "=== Application initialized successfully ===";
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
    
    qDebug() << "=== Loading QML ===";
    
    // 加载主 QML 文件
    const QUrl url(QStringLiteral("qrc:/qt/qml/CloudMusic/src/ui/Main.qml"));
    
    qDebug() << "QML URL:" << url;
    
    QObject::connect(
        m_engine.get(), &QQmlApplicationEngine::objectCreated,
        m_app.get(),
        [url](QObject *obj, const QUrl &objUrl) {
            qDebug() << "Object created:" << obj << "URL:" << objUrl;
            if (!obj && url == objUrl) {
                qCritical() << "Failed to load main QML file:" << url;
                QCoreApplication::exit(-1);
            } else if (obj) {
                qDebug() << "QML loaded successfully!";
            }
        },
        Qt::QueuedConnection
    );
    
    m_engine->load(url);
    
    if (m_engine->rootObjects().isEmpty()) {
        qCritical() << "No root objects loaded";
        qDebug() << "Import paths:";
        for (const QString& path : m_engine->importPathList()) {
            qDebug() << "  " << path;
        }
        return -1;
    }
    
    qDebug() << "Root objects count:" << m_engine->rootObjects().size();
    qDebug() << "=== Starting event loop ===";
    return m_app->exec();
}

void Application::cleanup() {
    qDebug() << "Cleaning up application resources";
    
    if (m_engine) {
        m_engine.reset();
    }
    
    if (m_app) {
        m_app.reset();
    }
    
    m_initialized = false;
    qDebug() << "Cleanup completed";
}

QString Application::version() const {
    return QString(PROJECT_VERSION);
}

QString Application::name() const {
    return QString(PROJECT_NAME);
}

bool Application::loadConfig() {
    // TODO: 实现配置文件加载
    qDebug() << "Loading configuration...";
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
    qDebug() << "Registering QML types...";
}

} // namespace Core
} // namespace CloudMusic
