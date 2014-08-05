#include <QtQml/QQmlExtensionPlugin>
#include <QImage>
#include <QQuickView>
#include <QQuickItem>
#include <qdebug.h>
#include <qcoreapplication.h>

class FrameGrabber : public QQuickItem
{
    Q_OBJECT
public:
    FrameGrabber(QQuickItem* parent=0) : QQuickItem(parent)
    {
    }
    Q_INVOKABLE void capture(QString const &path, int x, int y, int w, int h) const
    {
        QImage img = window()->grabWindow();
        img.copy(QRect(x, y, w, h)).save(path);
    }
};

class FrameGrabberPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.tokor.TorQML.FrameGrabber")
public:
    void registerTypes(const char *uri)
    {
        Q_ASSERT(uri == QLatin1String("TorQML.FrameGrabber"));
        qmlRegisterType<FrameGrabber>(uri, 0, 1, "FrameGrabber"); // QML: FrameGrabber
    }
};

#include "framegrabber.moc"

// vim:set ts=4 sw=4 et:
