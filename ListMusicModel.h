#ifndef LISTMUSICMODEL_H
#define LISTMUSICMODEL_H

#include <taglib/taglib.h>
#include <QObject>
#include <QVector>
#include <QDir>
#include <taglib/id3v2tag.h>
#include <QByteArray>
#include <QStandardPaths>
#include <QDebug>
#include <QAbstractListModel>
#include <QBuffer>


#include <taglib/tag.h>


class ModelMedia
{
public:
    ModelMedia(const QString &m_source,  const QString &m_title,const QString &m_artist,const QString &m_album,const int m_index):
        m_source(m_source),m_title(m_title),m_artist(m_artist),m_album(m_album),m_index(m_index)
    {}
    QString m_source;
    QString m_title;
    QString m_artist;
    QString m_album;
    int m_index;
};


class ListMusicModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ListMusicModel(QVector<ModelMedia*> &songList,QObject *parent = nullptr);
    ListMusicModel();
    enum Songs {
        TitleSongs = Qt::UserRole+1,
        ArtistSongs,
        AlbumSongs,
        SourceSongs,
        IndexSongs,
    };
    ~ListMusicModel();

    virtual int rowCount(const QModelIndex& parent=QModelIndex()) const override;

    QVariant data( const QModelIndex& index, int role = Qt::DisplayRole ) const override;
    QHash<int, QByteArray> roleNames() const override;
    void deletelMusicModel(int index);

signals:


private:
    QVector<ModelMedia*> m_listSong;

};

#endif
