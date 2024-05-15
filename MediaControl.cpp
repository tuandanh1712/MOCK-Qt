#include "MediaControl.h"
#include "qfiledialog.h"
#include <QMediaPlayer>
#include <QMediaPlaylist>
MediaController::MediaController( QObject *parent)
    : QObject(parent)
{

    player=new QMediaPlayer;
    playMusicList = new QMediaPlaylist;
    playVideoList= new QMediaPlaylist;
    m_proxyMusic= new QSortFilterProxyModel;
    m_proxyVideo=new QSortFilterProxyModel;
    player->setVolume(0);
    m_musicListModel=new ListMusicModel;
    connect(player, &QMediaPlayer::volumeChanged, this, &MediaController::volumeChanged);
    connect(player, &QMediaPlayer::positionChanged, this, &MediaController::positionChanged);
    connect(player,&QMediaPlayer::durationChanged, this, &MediaController::durationChanged);
    connect(playMusicList,&QMediaPlaylist::currentIndexChanged,this,&MediaController::setIndexMediaChanged);
    connect(playVideoList,&QMediaPlaylist::currentIndexChanged,this,&MediaController::setIndexMediaChanged);
    getMusicLocal();
    getVideoLocal();
}



MediaController::~MediaController()
{
    delete player;
    delete  playMusicList;
    delete m_proxyMusic;

    delete  playVideoList;
    delete m_proxyVideo;


}


void MediaController::getFolderMusic()
{
    QFileDialog dialog;
    dialog.setFileMode(QFileDialog::Directory);
    QString folderPath=dialog.getExistingDirectory(nullptr,"Open Folder","/home");
    qDebug()<<"folderPath"<<folderPath;
    QDir folder(folderPath);
    QStringList filter;
    filter<<"*.mp3";
    QStringList filePath = folder.entryList(filter, QDir::Files);
    qDebug()<<"filePath"<<filePath;
    QList<QMediaContent> content;
    for (int i = 0; i < filePath.size(); i++){

        const QString& fileName=filePath[i];
        QString fullPath = folder.filePath(fileName);
        qDebug()<<"fullPath"<<fullPath;
        //get metadata of media
        TagLib::FileRef f(fullPath.toLocal8Bit().data());
        TagLib::Tag* tag = f.tag();
        if (!tag)
        {
            continue;
        }
        QString m_source=fullPath.toStdString().c_str();
        QString m_title=QString::fromStdString(tag->title().to8Bit(true));
        QString m_artist=QString::fromStdString(tag->artist().to8Bit(true));
        QString m_album=QString::fromStdString(tag->album().to8Bit(true));
        int m_index=i;
        ModelMedia* song = new ModelMedia(m_source,m_title,m_artist,m_album,m_index);
        // musicModel.push_back(song);
        m_musicListModel->addMusicModel (song);
        content.push_back(QMediaContent(QUrl::fromLocalFile(fullPath)));
    }
    // m_musicListModel=new ListMusicModel(musicModel);?
    // m_proxyMusic->setSourceModel(m_musicListModel);
    playMusicList->addMedia(content);

}
QVariantList MediaController::getMusicLocal()
{

    QDir m_musicPath;
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0));// set path in music location
    QDir directory(m_musicPath);
    m_listSongPath = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files);// find files has format mp3, MP3
    QList<QMediaContent> content;
    for (int i = 0; i < m_listSongPath.size(); ++i)
    {
        const QString& f = m_listSongPath[i];
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        musicList.push_back(QVariant::fromValue(f));
        TagLib::FileRef r((directory.path()+"/" + f).toLocal8Bit().data());
        TagLib::Tag* tag = r.tag();
        if (!tag)
        {
            continue;
        }
        QString m_source=(directory.path()+"/" + f).toLocal8Bit().data();
        QString m_title=QString::fromStdString(tag->title().to8Bit(true));
        QString m_artist=QString::fromStdString(tag->artist().to8Bit(true));
        QString m_album=QString::fromStdString(tag->album().to8Bit(true));
        int m_index=i;
        ModelMedia* song = new ModelMedia(m_source,m_title,m_artist,m_album,m_index);
        musicModel.push_back(song);
    }
    m_musicListModel=new ListMusicModel(musicModel);
    m_proxyMusic->setSourceModel(m_musicListModel);
    playMusicList->addMedia(content);
    return musicList;

}



QSortFilterProxyModel *MediaController::proxyMusic() const
{
    return m_proxyMusic;
}

void MediaController::setProxyMusic(QSortFilterProxyModel *newProxyMusic)
{
    if (m_proxyMusic == newProxyMusic)
        return;
    m_proxyMusic = newProxyMusic;
    emit proxyMusicChanged();
}

void MediaController::getFolderVideo()
{
    {
        QFileDialog dialog;
        dialog.setFileMode(QFileDialog::Directory);
        QString folderPath=dialog.getExistingDirectory(nullptr,"Open Folder","/home");
        qDebug()<<"folderPath"<<folderPath;
        QDir folder(folderPath);
        QStringList filter;
        filter<<"*.mp4";
        QStringList filePath = folder.entryList(filter, QDir::Files);
        qDebug()<<"filePath"<<filePath;
        QList<QMediaContent> content;
        for (int i = 0; i < filePath.size(); i++){

            const QString& fileName=filePath[i];
            QString fullPath = folder.filePath(fileName);
            qDebug()<<"fullPath"<<fullPath;
            //get metadata of media
            TagLib::FileRef f(fullPath.toLocal8Bit().data());
            TagLib::Tag* tag = f.tag();
            if (!tag)
            {
                continue;
            }
            QString m_source=fullPath.toStdString().c_str();
            QString m_title=QString::fromStdString(tag->title().to8Bit(true));
            QString m_artist=QString::fromStdString(tag->artist().to8Bit(true));
            QString m_album=QString::fromStdString(tag->album().to8Bit(true));
            int m_index=i;
            ModelMedia1* video = new ModelMedia1(m_source,m_title,m_artist,m_album,m_index);
            videoModel .push_back(video);
            content.push_back(QMediaContent(QUrl::fromLocalFile(fullPath)));
        }
        m_videoListModel=new ListVideoModel(videoModel);
        m_proxyVideo->setSourceModel(m_videoListModel);
        playVideoList->addMedia(content);
    }
}

QVariantList MediaController::getVideoLocal()
{

    QDir m_videoPath;
    m_videoPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MoviesLocation).at(0));// set path in movie location
    QDir directory(m_videoPath);
    m_listVideoPath = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files);// find files has format mp4, MP4

    QList<QMediaContent> content;
    for(int i=0;i<m_listVideoPath.size();++i)
    {
        const QString& f=m_listVideoPath[i];

        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        videoList.push_back(QVariant::fromValue(f));

        TagLib::FileRef r((directory.path()+"/" + f).toLocal8Bit().data());
        TagLib::Tag* tag = r.tag();
        if (!tag)
        {
            continue;
        }
        QString m_source=(directory.path()+"/" + f).toLocal8Bit().data();
        QString m_title=QString::fromStdString(tag->title().to8Bit(true));
        QString m_artist=QString::fromStdString(tag->artist().to8Bit(true));
        QString m_album=QString::fromStdString(tag->album().to8Bit(true));
        int m_index=i;
        ModelMedia1* video = new ModelMedia1(m_source,m_title,m_artist,m_album,m_index);
        videoModel .push_back(video);
    }
    m_videoListModel=new ListVideoModel(videoModel);
    m_proxyVideo->setSourceModel(m_videoListModel);
    playVideoList->addMedia(content);
    return videoList;

}

ListMusicModel *MediaController::musicListModel() const
{
    return m_musicListModel;
}

void MediaController::setMusicListModel(ListMusicModel *newMusicListModel)
{
    if (m_musicListModel == newMusicListModel)
        return;
    m_musicListModel = newMusicListModel;
    emit musicListModelChanged();
}


QSortFilterProxyModel *MediaController::proxyVideo() const
{
    return m_proxyVideo;
}

void MediaController::setProxyVideo( QSortFilterProxyModel *newProxyVideo)
{
    if (m_proxyVideo == newProxyVideo)
        return;
    m_proxyVideo = newProxyVideo;
    emit proxyMusicChanged();
}
void MediaController::setMusicPlay()
{
    player->setPlaylist(playMusicList);

}

// void MediaController::setSource(QString source)
// {
//     // m_currentCoverArt=m_musicListModel->imageForTag(source);
// }

void MediaController::playMusic(int index)
{
    playMusicList->setCurrentIndex(index);
    player->play();
}

int MediaController::index() const
{
    return m_index;
}

void MediaController::setIndex(int newIndex)
{
    qDebug()<<newIndex;
    if (m_index == newIndex)
        return;
    if(newIndex>playMusicList->mediaCount()-1)
    {

        m_index=newIndex-playMusicList->mediaCount();

    }
    else if(newIndex<0)
    {
        m_index=newIndex-playMusicList->mediaCount()-1;

    }
    else{
        m_index = newIndex;
    }

    emit indexChanged();
}

void MediaController::setVideoPlay()
{
    player->setPlaylist(playVideoList);

}

void MediaController::playVideo(int index)
{
    playVideoList->setCurrentIndex(index);
    player->play();
}



int MediaController::indexVideo() const
{
    return m_indexVideo;
}

void MediaController::setIndexVideo(int newIndexVideo)
{
    if (m_indexVideo == newIndexVideo)
        return;
    if(newIndexVideo>playVideoList->mediaCount()-1)
    {

        m_indexVideo=newIndexVideo-playVideoList->mediaCount();

    }
    else if(newIndexVideo<0)
    {
        m_indexVideo=newIndexVideo-playVideoList->mediaCount()-1;

    }
    else{
        m_indexVideo = newIndexVideo;
    }

    emit indexVideoChanged();
}
void MediaController::resumeMedia()
{
    player->play();


}
void MediaController::pauseMedia()
{
    player->pause();

}
void MediaController::seekBack()
{
    player->setPosition(player->position()-5000);
}
void MediaController::previousMedia()
{
    playMusicList->previous();
    playVideoList->previous();

}
void MediaController::nextMedia()
{
    playMusicList->next();
    playVideoList->next();

}
void MediaController::seekForward()
{
    player->setPosition(player->position()+5000);
}

int MediaController::volume() const
{
    return player->volume();
}

void MediaController::setVolume(int newVolume)
{
    if (m_volume == newVolume)
        return;
    m_volume = newVolume;
    player->setVolume(newVolume);
    emit volumeChanged();
}



qint64 MediaController::position() const
{
    return player->position();
}

void MediaController::setPosition(qint64 newPosition)
{
    if (m_position == newPosition)
        return;
    m_position = newPosition;
    player->setPosition(newPosition);
    emit positionChanged();
}

qint64 MediaController::duration() const
{
    return player->duration();
}

void MediaController::setDuration(qint64 newDuration)
{
    if (m_duration == newDuration)
        return;
    m_duration = newDuration;
    emit durationChanged();
}

QAbstractVideoSurface *MediaController::videoSurface() const
{
    return m_videoSurface;
}

void MediaController::setVideoSurface(QAbstractVideoSurface *newVideoSurface)
{
    if (m_videoSurface == newVideoSurface)
        return;
    m_videoSurface = newVideoSurface;
    player->setVideoOutput(m_videoSurface);
    emit videoSurfaceChanged();
}

void MediaController::deletelMusic(int index)
{
    m_musicListModel->deletelMusicModel(index);
    playMusicList->removeMedia(index);
    if(playMusicList->currentIndex()==index)
    {
        player->stop();

    }
    else
    {
        player->play();
    }
}

void MediaController::deletelVideo(int index)
{
    m_videoListModel->deletelVideoModel(index);
    playVideoList->removeMedia(index);
}

void MediaController::setIndexMediaChanged()
{
    setIndex(playMusicList->currentIndex());
    setIndexVideo(playVideoList->currentIndex());
    QModelIndex index = m_proxyMusic->index(m_index,0);
    QVariant data = m_proxyMusic->data(index,m_musicListModel->ListMusicModel::Songs::SourceSongs);
    // QString source= data.toString();
    // setSource(source);
}

QString MediaController::getMusicTitleArtist(int indexSong)
{
    qDebug()<<indexSong;
    QModelIndex index= m_musicListModel->index(indexSong,0);
    QVariant data= m_musicListModel->data(index,m_musicListModel->Songs::TitleSongs);
    QVariant data2= m_musicListModel->data(index,m_musicListModel->Songs::ArtistSongs);
    QString tilteSong= data.toString();
    QString artist= data2.toString();
    qDebug()<<tilteSong+"-"+artist;
    return tilteSong+"-"+artist;


}

QString MediaController::getVideoTitleArtist(int indexSong)
{
    qDebug()<<"indexVideo"<<indexSong;
    QModelIndex index= m_videoListModel->index(indexSong,0);
    QVariant data= m_videoListModel->data(index,m_videoListModel->Songs::TitleVideo);
    QVariant data2= m_videoListModel->data(index,m_videoListModel->Songs::ArtistVideo);
    QString tilteSong= data.toString();
    QString artist= data2.toString();
    qDebug()<<tilteSong+"-"+artist;
    return tilteSong+"-"+artist;
}
void MediaController::shuffleMedia()
{
    if (playMusicList->isEmpty())
        return;
    playMusicList->setPlaybackMode(QMediaPlaylist::Random);
    playVideoList->setPlaybackMode(QMediaPlaylist::Random);


}
void MediaController::repeatMedia(int repeatIndex)
{

    if(repeatIndex==0)
    {

        playMusicList->setPlaybackMode(QMediaPlaylist::Sequential);
        playVideoList->setPlaybackMode(QMediaPlaylist::Sequential);
    }
    else if(repeatIndex==1)
    {
        playMusicList->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
        playVideoList->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    }
    else if(repeatIndex==2){
        playMusicList->setPlaybackMode(QMediaPlaylist::Loop);
        playVideoList->setPlaybackMode(QMediaPlaylist::Loop);

    }

}
void MediaController::speedMedia(qreal rate)
{
    player->setPlaybackRate(rate);

}

void MediaController::sortTitleMusic(bool type)
{
    m_proxyMusic->setSortRole(ListMusicModel::Songs::TitleSongs);



    if (type) {
        m_proxyMusic->sort(0, Qt::AscendingOrder);
    } else {
        m_proxyMusic->sort(0, Qt::DescendingOrder);
    }
}

void MediaController::sortAlbumMusic(bool type)
{
    m_proxyMusic->setSortRole(ListMusicModel::Songs::AlbumSongs);


    if (type) {
        m_proxyMusic->sort(0, Qt::AscendingOrder);
    } else {
        m_proxyMusic->sort(0, Qt::DescendingOrder);
    }
}

void MediaController::sortArtistMusic(bool type)
{
    m_proxyMusic->setSortRole(ListMusicModel::Songs::ArtistSongs);

    if (type) {
        m_proxyMusic->sort(0, Qt::AscendingOrder);
    } else {
        m_proxyMusic->sort(0, Qt::DescendingOrder);
    }
}
void MediaController::sortTitleVideo(bool type)
{
    m_proxyVideo->setSortRole(ListVideoModel::Songs::TitleVideo);



    if (type) {
        m_proxyVideo->sort(0, Qt::AscendingOrder);

    } else {
        m_proxyVideo->sort(0, Qt::DescendingOrder);

    }

}

void MediaController::sortAlbumVideo(bool type)
{
    m_proxyVideo->setSortRole(ListVideoModel::Songs::AlbumVideo);



    if (type) {
        m_proxyVideo->sort(0, Qt::AscendingOrder);

    } else {
        m_proxyVideo->sort(0, Qt::DescendingOrder);

    }

}

void MediaController::sortArtistVideo(bool type)
{
    m_proxyVideo->setSortRole(ListVideoModel::Songs::ArtistVideo);



    if (type) {
        m_proxyVideo->sort(0, Qt::AscendingOrder);

    } else {
        m_proxyVideo->sort(0, Qt::DescendingOrder);

    }

}



QStringList MediaController::listSongPath() const
{
    return m_listSongPath;
}

void MediaController::setListSongPath(const QStringList &newListSongPath)
{
    if (m_listSongPath == newListSongPath)
        return;
    m_listSongPath = newListSongPath;
    emit listSongPathChanged();
}

QStringList MediaController::listVideoPath() const
{
    return m_listVideoPath;
}

void MediaController::setListVideoPath(const QStringList &newListVideoPath)
{
    if (m_listVideoPath == newListVideoPath)
        return;
    m_listVideoPath = newListVideoPath;
    emit listVideoPathChanged();
}
