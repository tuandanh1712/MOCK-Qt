#ifndef MANAGESONG_H
#define MANAGESONG_H

#include <QObject>
#include <QAbstractListModel>
#include <QVariant>
#include <QDir>
#include <QFileInfoList>
#include <QDebug>


class List
{
public:
    List(const QString &name, const QString &filePath, bool check = false):
        m_name(name), m_filePath(filePath),m_check(check)
    {}
    QString m_name;
    QString m_filePath;
    bool m_check;
};

class ManageSong : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit ManageSong(QObject *parent = nullptr);
    ~ManageSong();
    enum ManageRoles {
        Role_name = Qt::UserRole +1,
        Role_filePath,
        Role_Check
    };

    // QAbstractItemModel interface

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    // bool setData(const QModelIndex &index, const QVariant &value, int role) override;
    virtual QHash<int, QByteArray> roleNames() const override;
    void addModel( const QString& filePath);
    void delSongSelected();
    void removeSong(int index);
    QList<List*> m_modelData;
private:




};

#endif // MANAGESONG_H
