#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSurfaceFormat>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QSurfaceFormat fmt;
#if 0
    fmt.setRenderableType(QSurfaceFormat::RenderableType::OpenGLES);
    fmt.setVersion(3, 0);
#else
    fmt.setRenderableType(QSurfaceFormat::RenderableType::OpenGL);
    fmt.setVersion(3, 3);
#endif
    QSurfaceFormat::setDefaultFormat(fmt);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
