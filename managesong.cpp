#include "managesong.h"
#include <QDebug>
#include <taglib/fileref.h>

// #include <fileref.h>
ManageSong::ManageSong(QObject *parent)
{
    Q_UNUSED(parent)
}

ManageSong::~ManageSong()
{
    qDebug()<<"ManageSong Destructor";
    qDeleteAll(m_modelData);
}


void ManageSong::addModel( const QString &addfilePath)
{
    // beginInsertRows(QModelIndex(), rowCount(), rowCount());
    // qDebug() << "name:" << addname;
    qDebug()<<"folrr"<<addfilePath;

    // // Lấy chỉ số cuối cùng của dấu gạch ngang (-)
    // int dashIndex = addname.lastIndexOf("-");

    // // Nếu không tìm thấy dấu gạch ngang, sử dụng chuỗi ban đầu
    // QString resultString = dashIndex != -1 ? addname.left(dashIndex) : addname;

    // m_modelData.append(new List(resultString, addfilePath));
    // endInsertRows();



    beginInsertRows(QModelIndex(), rowCount(), rowCount());

    // Đọc thông tin metadata từ file âm nhạc sử dụng Taglib
    // Thêm dữ liệu mới từ folder mới
    TagLib::FileRef fileRef(addfilePath.toStdString().c_str());
    if (!fileRef.isNull() && fileRef.tag()) {
        TagLib::Tag *tag = fileRef.tag();
        QString title = QString::fromStdString(tag->title().toCString(true));
        QString artist = QString::fromStdString(tag->artist().toCString(true));
        QString titleArtist = title + " - " + artist;
        qDebug() << "asdasd" << titleArtist;

        // Tạo một đối tượng List mới và thêm vào m_modelData
        m_modelData.append(new List(titleArtist, addfilePath));
    } else {
        // Nếu không thể đọc metadata, sử dụng tên file làm tiêu đề
        qDebug() << "ERROR";
    }


    endInsertRows();
}


void ManageSong::delSongSelected()
{
    for(int i = rowCount() - 1; i >= 0; i--)
        if(m_modelData.at(i)->m_check) {
            removeSong(i);
        }
}

void ManageSong::removeSong(int index)
{

    beginRemoveRows(QModelIndex(), index, index);
    auto temp = m_modelData.at(index);
    m_modelData.removeAt(index);
    delete temp;
    endRemoveRows();
}


int ManageSong::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_modelData.count();
}

QVariant ManageSong::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_modelData.count()){
        return QVariant();
    }
    List *list = m_modelData.at(index.row());
    if (role == Role_name)
        return list->m_name;
    else if (role == Role_filePath)
        return list->m_filePath;
    else if (role == Role_Check)
        return list->m_check;
    else return QVariant();
}

// bool ManageSong::setData(const QModelIndex &index, const QVariant &value, int role)
// {
//     // auto item = m_modelData.at(index.row());
//     // qDebug() << "setData()";
//     // switch (role) {
//     // case Role_Check:
//     //     if(item->m_check == value.toBool()) {
//     //         return false;
//     //     }
//     //     item->m_check = value.toBool();
//     //     break;
//     // case Role_filePath:
//     //     if(item->m_filePath == value.toString()) {
//     //         return false;
//     //     }
//     //     item->m_filePath = value.toString();
//     //     break;
//     // case Role_name:
//     //     if(item->m_name == value.toString()) {
//     //         return false;
//     //     }
//     //     item->m_name = value.toString();
//     //     break;
//     // }emit dataChanged(index,index);
//     // return true;
// }

QHash<int, QByteArray> ManageSong::roleNames() const
{
    QHash<int , QByteArray> roles;
    roles[Role_name] = "name";
    roles[Role_filePath] = "filePath";
    roles[Role_Check] = "check";
    return roles;
}


