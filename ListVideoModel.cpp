#include "ListVideoModel.h"



ListVideoModel::ListVideoModel(QVector<ModelMedia1*> &videoList, QObject *parent)
    : QAbstractListModel(parent)
{

    m_listVideo=videoList;


}

ListVideoModel::~ListVideoModel()
{
    for(int i=0;i<m_listVideo.size();i++)
    {
        delete m_listVideo[i];
    }

    m_listVideo.clear();


}

int ListVideoModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_listVideo.count();
}

QVariant ListVideoModel::data(const QModelIndex &index, int role) const
{
    if ( !index.isValid() )
        return QVariant();

    ModelMedia1* songs = m_listVideo.at(index.row());
    if ( role == TitleVideo ){
        return songs->m_title;
    }
    else if ( role == AlbumVideo )
        return songs->m_album;
    else if ( role == ArtistVideo )
        return songs->m_artist;
    else if(role==SourceVideo)
        return songs->m_source;
    else if(role==IndexVideo)
        return songs->m_index;
    else
        return QVariant();
}

QHash<int, QByteArray> ListVideoModel::roleNames() const
{
    static QHash<int, QByteArray> mapping {
        {TitleVideo, "TitleVideo"},
        {AlbumVideo, "ArtistVideo"},
        {ArtistVideo, "AlbumVideo"},
        {SourceVideo,"SourceVideo"},
        {IndexVideo,"IndexVideo"}
    };
    return mapping;
}
void ListVideoModel::deletelVideoModel(int index)
{
    beginRemoveRows(QModelIndex(),index,index);//notify the model that rows are about to be removed
    m_listVideo.removeAt(index);
    endRemoveRows();//is used to signal the model that rows have been successfully removed

}

void ListVideoModel::addVideoModel(ModelMedia1 *data)
{
    beginInsertRows (QModelIndex(),rowCount (QModelIndex()),rowCount (QModelIndex()));
    m_listVideo.append (data);
    endInsertRows ();
}









