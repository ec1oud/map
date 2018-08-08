#include <QDebug>
#include <QFile>
#include <QGuiApplication>
#include <QJsonDocument>
#include <QQmlApplicationEngine>
#include <QVariantMap>
#include <QQmlContext>
#include <QtLocation/private/qgeojson_p.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    if (argc < 2) {
        printf("Usage: %s file.json", argv[0]);
        return -1;
    }

    QFile loadFile(argv[1]);
    if (!loadFile.open(QIODevice::ReadOnly)) {
        qWarning() << "Couldn't open" << argv[1];
        return -2;
    }

    QJsonDocument loadDoc(QJsonDocument::fromJson(loadFile.readAll()));
    QVariantMap model = QGeoJson::importGeoJson(loadDoc);
    qDebug() << "got" << model;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("annotations", model);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
