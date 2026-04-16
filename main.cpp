#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDebug>

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    
    // Add import path for CloudMusic module
    engine.addImportPath("qrc:/");
    engine.addImportPath("qrc:/CloudMusic");
    
    // Debug: Print import paths
    qDebug() << "QML Import Paths:";
    for (const QString &path : engine.importPathList()) {
      //  qDebug() << "  " << path;
    }
    
    const QUrl url(QStringLiteral("qrc:/qt/qml/CloudMusic/resources/qml/src/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
