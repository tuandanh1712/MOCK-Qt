#include "MediaModel.h"

MediaModel::MediaModel()
{

}

QString MediaModel::getSource()
{
    return media.m_source;

}

void MediaModel::setSource(QString source)
{
    media.m_source=source;

}

QString MediaModel::getFileName()
{
    return media.m_fileName;

}

void MediaModel::setFileName(QString fileName)
{
    media.m_fileName=fileName;

}

QString MediaModel::getTitle()
{
    if(media.m_title.toStdString()=="")
    {
        return "Unknow";
    }
    return media.m_title;

}

void MediaModel::setTitle(QString title)
{
    media.m_title=title;

}

QString MediaModel::getArtist()
{
    if(media.m_artist.toStdString()=="")
    {
        return "Unknow";
    }

    return media.m_artist;

}

void MediaModel::setArtist(QString artist)
{
    media.m_artist=artist;

}

QString MediaModel::getAlbum()
{
    if(media.m_album.toStdString()=="")
    {
        return "Unknow";
    }
    return media.m_album;

}

void MediaModel::setAlbum(QString album)
{
    media.m_album=album;
}

int MediaModel::getIndex()
{
    return media.m_index;

}

void MediaModel::setIndex(int index)
{
    media.m_index=index;

}


