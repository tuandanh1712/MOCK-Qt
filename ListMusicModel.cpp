#include "ListMusicModel.h"

ListMusicModel::ListMusicModel(QVector<ModelMedia*> &songList, QObject *parent)
    : QAbstractListModel(parent),m_listSong()
{

    m_listSong=songList;


}

ListMusicModel::ListMusicModel()
{

}

ListMusicModel::~ListMusicModel()
{
    for(int i=0;i<m_listSong.size();i++)
    {
        delete m_listSong[i];
    }

    m_listSong.clear();


}

int ListMusicModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return m_listSong.count();
}

QVariant ListMusicModel::data(const QModelIndex &index, int role) const
{
    qDebug()<<"role:"<<role;
    if ( !index.isValid() )
        return QVariant();

    ModelMedia* songs = m_listSong.at(index.row());
    if ( role == TitleSongs ){
        return songs->m_title;
    }
    else if ( role == AlbumSongs )
        return songs->m_album;
    else if ( role == ArtistSongs )
        return songs->m_artist;
    else if(role==SourceSongs)
        return songs->m_source;
    else if(role==IndexSongs)
        return songs->m_index;
    else
        return QVariant();
}

QHash<int, QByteArray> ListMusicModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {TitleSongs, "TitleSongs"},
        {ArtistSongs, "ArtistSongs"},
        {AlbumSongs, "AlbumSongs"},
        {SourceSongs,"SourceSongs"},
        {IndexSongs,"IndexSongs"}
    };
    return mapping;
}

void ListMusicModel::deletelMusicModel(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_listSong.removeAt(index);
    endRemoveRows();
}

void ListMusicModel::addMusicModel(ModelMedia *data)
{
    beginInsertRows (QModelIndex(),rowCount (QModelIndex()),rowCount (QModelIndex()));
    m_listSong.append (data);
    endInsertRows ();

}







