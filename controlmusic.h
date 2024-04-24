#ifndef CONTROLMUSIC_H
#define CONTROLMUSIC_H

#include "managesong.h"
#include <QObject>
#include <QVariant>
#include <QDir>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QStringList>
#include <taglib/taglib.h>
#include <taglib/fileref.h>
#include <taglib/tag.h>
class controlmusic : public QObject
{
    Q_OBJECT
public:
    explicit controlmusic(QObject *parent = nullptr);
    controlmusic(ManageSong *m_manage);
    ~controlmusic();
    Q_INVOKABLE void setName(const QString& m_url);
    Q_INVOKABLE void setSource(int index);
    Q_INVOKABLE void playMusic();
    Q_INVOKABLE void pauseMusic();
    int curentIndex() const;
    Q_INVOKABLE void setcurentIndex(int newCurentIndex);
    Q_INVOKABLE void playNext();
    Q_INVOKABLE void playPrevious();
    Q_INVOKABLE void changeMusic();

    Q_PROPERTY(int  m_curentIndex READ m_curentIndex WRITE setM_curentIndex NOTIFY m_curentIndexChanged FINAL)
    Q_PROPERTY(QStringList m_name READ m_name WRITE setM_name NOTIFY m_nameChanged FINAL)
    Q_PROPERTY(QStringList mSource READ mSource WRITE setmSource NOTIFY mSourceChanged FINAL)
    Q_PROPERTY(float volume READ volume WRITE setvolume NOTIFY volumeChanged FINAL)
    Q_PROPERTY(qint64 position READ position WRITE setposition NOTIFY positionChanged FINAL)
    Q_PROPERTY(bool isSuff READ isSuff WRITE setIsSuff NOTIFY isSuffChanged FINAL)
    Q_PROPERTY(bool isRepeat READ isRepeat WRITE setIsRepeat NOTIFY isRepeatChanged FINAL)
    int m_curentIndex() const;
    void setM_curentIndex(int newM_curentIndex);

    QStringList m_name() const;
    void setM_name(const QStringList &newM_name);


    QStringList mSource() const;
    void setmSource(const QStringList &newMSource);

    float volume() const;
    Q_INVOKABLE void setvolume(float newVolume);
    Q_INVOKABLE qint64 getDuration();
    void checkVolume();

    qint64 position() const;
    void setposition(qint64 newPosition);

    bool isSuff() const;
    void setIsSuff(bool newIsSuff);
    void autoChange();

    bool isRepeat() const;
    void setIsRepeat(bool newIsRepeat);

private:
    // QStringList m_name;
    QStringList m_source;
    ManageSong *manage;
    QMediaPlayer *player ;
        // int m_curentIndex;


    int m_m_curentIndex;

    QStringList m_m_name;


    QStringList m_mSource;

    QAudioOutput *audio ;
    float m_volume;


    float m_position;

    bool m_isSuff=false;


    bool m_isRepeat=false;

signals:

    void curentIndexChanged();
    void m_curentIndexChanged();
    void m_nameChanged();
    void m_sourceChanged();
    void mSourceChanged();
    void volumeChanged();
    void positionChanged();
    void isSuffChanged();
    void isRepeatChanged();
};

#endif // CONTROLMUSIC_H
