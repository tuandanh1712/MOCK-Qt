#include "controlmusic.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include<QQmlContext>
int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    // qmlRegisterType<RadialBar>("CustomControls", 1, 0, "RadialBar");

    ManageSong first ;
    controlmusic control(&first) ;
    engine.rootContext()->setContextProperty("ControlMusic",&control);
    engine.rootContext()->setContextProperty("SongModel",&first);
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