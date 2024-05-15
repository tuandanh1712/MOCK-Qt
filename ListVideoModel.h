#ifndef LISTVIDEOMODEL_H
#define LISTVIDEOMODEL_H
#include <QObject>
#include <QVector>
#include <QDir>
#include <QByteArray>
#include <QStandardPaths>
#include <QDebug>
#include <QAbstractListModel>
#include <QBuffer>
#include <taglib/tag.h>
#include <taglib/fileref.h>

class ModelMedia1
{
public:
    ModelMedia1(const QString &m_source,  const QString &m_title,const QString &m_artist,const QString &m_album,const int m_index):
        m_source(m_source),m_title(m_title),m_artist(m_artist),m_album(m_album),m_index(m_index)
    {}
    QString m_source;
    QString m_title;
    QString m_artist;
    QString m_album;
    int m_index;
};


class ListVideoModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ListVideoModel(QVector<ModelMedia1*> &videoList,QObject *parent = nullptr);
    enum Songs {
        TitleVideo = Qt::UserRole+1,
        ArtistVideo,
        AlbumVideo,
        SourceVideo,
        IndexVideo,
    };
    ~ListVideoModel();

    int rowCount(const QModelIndex& parent) const override;

    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;
    void deletelVideoModel(int index);

signals:


private:
    QVector<ModelMedia1*> m_listVideo;

};

#endif
