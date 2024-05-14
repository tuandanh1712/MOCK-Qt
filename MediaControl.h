#ifndef MEDIACONTROL_H
#define MEDIACONTROL_H

#include "ListMusicModel.h"
#include "ListVideoModel.h"
#include "qimage.h"
#include "qmediaplayer.h"
#include <QObject>
#include <QDebug>
#include <QQmlApplicationEngine>
#include <QAbstractListModel>
#include <QSortFilterProxyModel>
#include <QQmlApplicationEngine>
#include <QCoreApplication>


class MediaController : public QObject
{
    Q_OBJECT


public:
    explicit MediaController(QObject *parent = nullptr);
    ~MediaController();

    Q_PROPERTY(QSortFilterProxyModel* proxyMusic READ proxyMusic WRITE setProxyMusic NOTIFY proxyMusicChanged)
    Q_PROPERTY(QSortFilterProxyModel* proxyVideo READ proxyVideo WRITE setProxyVideo NOTIFY proxyVideoChanged FINAL)
    Q_PROPERTY(ListMusicModel* musicListModel READ musicListModel WRITE setMusicListModel NOTIFY musicListModelChanged FINAL)
    Q_PROPERTY(int index READ index WRITE setIndex NOTIFY indexChanged FINAL)
    Q_PROPERTY(int indexVideo READ indexVideo WRITE setIndexVideo NOTIFY indexVideoChanged FINAL)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged FINAL)
    Q_PROPERTY(qint64 duration READ duration WRITE setDuration NOTIFY durationChanged FINAL)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged FINAL)
    Q_PROPERTY(QStringList listSongPath READ listSongPath WRITE setListSongPath NOTIFY listSongPathChanged FINAL)
    Q_PROPERTY(QStringList listVideoPath READ listVideoPath WRITE setListVideoPath NOTIFY listVideoPathChanged FINAL)
    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged FINAL)


    QSortFilterProxyModel *proxyMusic() const;
    QSortFilterProxyModel* proxyVideo() const;
    QAbstractVideoSurface *videoSurface() const;
    Q_INVOKABLE  void setIndex(int newIndex);
    Q_INVOKABLE void getFolderMusic();
    Q_INVOKABLE void setIndexVideo(int newIndexVideo);
    Q_INVOKABLE void resumeMedia();
    Q_INVOKABLE void pauseMedia();
    Q_INVOKABLE void seekBack();
    Q_INVOKABLE void previousMedia();
    Q_INVOKABLE void nextMedia();
    Q_INVOKABLE void seekForward();
    Q_INVOKABLE QString getMusicTitleArtist(int indexSong);
    Q_INVOKABLE QString getVideoTitleArtist(int indexSong);
    Q_INVOKABLE void shuffleMedia();
    Q_INVOKABLE void repeatMedia(int repeatIndex);
    Q_INVOKABLE void speedMedia(qreal repeatIndex);
    Q_INVOKABLE void sortTitleMusic(bool type);
    Q_INVOKABLE void sortAlbumMusic(bool type);
    Q_INVOKABLE void sortArtistMusic(bool type);
    Q_INVOKABLE void sortTitleVideo(bool type);
    Q_INVOKABLE void sortAlbumVideo(bool type);
    Q_INVOKABLE void sortArtistVideo(bool type);
    Q_INVOKABLE QVariantList getMusicLocal();
    Q_INVOKABLE QVariantList getVideoLocal();
    Q_INVOKABLE void setMusicPlay();
    // Q_INVOKABLE void setSource(QString source);
    Q_INVOKABLE void playMusic(int index);
    Q_INVOKABLE void getFolderVideo();
    Q_INVOKABLE void setVideoPlay();
    Q_INVOKABLE void playVideo(int index);
    Q_INVOKABLE void deletelMusic(int index);
    Q_INVOKABLE void deletelVideo(int index);
    QStringList listSongPath() const;
    QStringList listVideoPath() const;
    ListMusicModel *musicListModel() const;



    void setProxyVideo( QSortFilterProxyModel *newProxyVideo);
    void setMusicListModel(ListMusicModel *newMusicListModel);
    void setProxyMusic(QSortFilterProxyModel *newProxyMusic);
    void setListVideoPath(const QStringList &newListVideoPath);
    void setListSongPath(const QStringList &newListSongPath);
    void setVolume(int newVolume);
    void setDuartion(qint64 newDuartion);
    void setPosition(qint64 newPosition);
    void setDuration(qint64 newDuration);
    void setVideoSurface(QAbstractVideoSurface *newVideoSurface);

    int volume() const;
    int indexVideo() const;
    int index() const;
    qint64 duartion() const;
    qint64 position() const;
    qint64 duration() const;

public slots:

    void setIndexMediaChanged();
signals:

    void proxyMusicChanged();

    void musicListModelChanged();

    void proxyVideoChanged();

    void indexChanged();

    void indexVideoChanged();

    void volumeChanged();

    void positionChanged();

    void durationChanged();

    void videoSurfaceChanged();

    void listSongPathChanged();

    void listVideoPathChanged();

private:
    QMediaPlayer* player ;

    QVector<ModelMedia*> musicModel;
    QSortFilterProxyModel *m_proxyMusic ;
    ListMusicModel *m_musicListModel = nullptr;
    QMediaPlaylist *playMusicList;


    QVector<ModelMedia1*> videoModel;
    QSortFilterProxyModel* m_proxyVideo;
    ListVideoModel *m_videoListModel = nullptr;
    QMediaPlaylist *playVideoList;
    int m_index;
    int m_indexVideo;

    // QImage m_currentCoverArt;
    int m_volume;

    qint64 m_position;
    qint64 m_duration;
    QAbstractVideoSurface *m_videoSurface = nullptr;
    QStringList m_listSongPath;
    QVariantList musicList;
    QVariantList videoList;
    QStringList m_listVideoPath;
};

#endif
