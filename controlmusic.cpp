#include "controlmusic.h"
#include <QtDebug>
#include <QRandomGenerator>
controlmusic::controlmusic(QObject *parent)
    : QObject{parent}
{}

controlmusic::controlmusic(ManageSong *m_manage)
{
    player = new QMediaPlayer();
    audio = new QAudioOutput();
    manage = m_manage;
    m_position=0;
    connect(player,&QMediaPlayer::mediaStatusChanged,this,&controlmusic::autoChange);

}

controlmusic::~controlmusic()
{
    qDebug()<<"ControlMusic Destructor";
    delete player;
    // player=nullptr;
    // delete manage;
    // manage=nullptr;tôi
}

void controlmusic::setName(const QString &m_url)
{
    qDebug() << "ok";
    QString tmp = m_url;
    QString sourceFolder = tmp.remove(0,7); // Sửa số lượng ký tự cần bỏ qua tùy thuộc vào cấu trúc đường dẫn trên Ubuntu
    qDebug() << "nameFolder:"<<sourceFolder;
    QDir dir(sourceFolder);
    QStringList y=dir.entryList(QStringList() << "*.mp3"<<"*.mp4");
    setM_name(y);
    for (int i = 0 ; i < m_m_name.count(); i++)
    {
        qDebug() << "nameFile:"<<m_m_name[i];
        m_source.append(sourceFolder + "/" + m_m_name[i]); //  name file
        qDebug()<<"sourceFolder"<<sourceFolder;
        qDebug() <<"source:"<< m_source[i];
        // QString tmp_Name = m_m_name[i].remove(m_m_name[i].length() - 4, m_m_name[i].length() - 1);//name song
        // qDebug()<<"tmp_Name"<<tmp_Name;
        manage->addModel( sourceFolder+"/"+m_m_name[i]);
    }
    setmSource(m_source);
}




void controlmusic::setSource(int index)
{
    // if (index >= 0 && index < m_source.size()) {
    QString filePath =  m_source[index]; // Đường dẫn đến tập tin âm thanh
    player->setMedia(QUrl::fromLocalFile(filePath));
    qDebug()<<"sourceeee"<< m_source[index];
    // }
}

void controlmusic::playMusic()
{
    player->play();
    qDebug()<<"play cpp";
}

void controlmusic::pauseMusic()
{
    player->pause();
}

void controlmusic::setcurentIndex(int newCurentIndex)
{
    qDebug() <<"newCurrnetIndex"<< newCurentIndex;
    if (m_curentIndex() == newCurentIndex)
        return;
    setM_curentIndex( newCurentIndex);
    emit curentIndexChanged();
}

void controlmusic::playNext()
{
    if(m_curentIndex() < m_source.count()-1) {
        setM_curentIndex(m_m_curentIndex+1) ;
    }
    // if(m_isSuff){
    //     setM_curentIndex(m_m_curentIndex);
    // }
    changeMusic();
    qDebug() <<"next bai"<< m_curentIndex();

}
void controlmusic::playPrevious()
{
    if(m_curentIndex() >0) {
        setM_curentIndex(m_m_curentIndex-1) ;
    }
    changeMusic();

}
void controlmusic::changeMusic()
{
    qDebug()<<"changMusic"<<m_m_curentIndex;
    this->setSource(m_m_curentIndex);
    if(m_isSuff){

        player->play();
    }
}


int controlmusic::m_curentIndex() const
{
    return m_m_curentIndex;
}

void controlmusic::setM_curentIndex(int newM_curentIndex)
{
    if (m_m_curentIndex == newM_curentIndex)
        return;
    m_m_curentIndex = newM_curentIndex;
    emit m_curentIndexChanged();
}

QStringList controlmusic::m_name() const
{
    return m_m_name;
}

void controlmusic::setM_name(const QStringList &newM_name)
{
    if (m_m_name == newM_name)
        return;
    m_m_name = newM_name;
    emit m_nameChanged();
}




QStringList controlmusic::mSource() const
{
    return m_mSource;
}

void controlmusic::setmSource(const QStringList &newMSource)
{
    if (m_mSource == newMSource)
        return;
    m_mSource = newMSource;
    emit mSourceChanged();
}

float controlmusic::volume() const
{
    return m_volume;
}

void controlmusic::setvolume(float newVolume)
{

    float sVolumne=newVolume*100;
    // qDebug()<<"Volumeee"<<sVolumne;
    if (player->volume() == sVolumne)
        return;
    // audio->setVolume(newVolume);
    player->setVolume(sVolumne*100);
    emit volumeChanged();
}

qint64 controlmusic::getDuration()
{
    return player->duration();

}


qint64 controlmusic::position() const
{
    return player->position();
}

void controlmusic::setposition(qint64 newPosition)
{
    // qDebug()<<newPosition;
    if (player->position()==newPosition)
        return;
    m_position = newPosition;
    player->setPosition(m_position);
    emit positionChanged();
}

bool controlmusic::isSuff() const
{
    return m_isSuff;
}

void controlmusic::setIsSuff(bool newIsSuff)
{
    if (m_isSuff == newIsSuff)
        return;
    m_isSuff = newIsSuff;
    qDebug() << m_isSuff;
    emit isSuffChanged();
}

void controlmusic::autoChange()
{
    if (player->mediaStatus()==2 )
    {
        if(m_isRepeat && !m_isSuff) {
            player->play();
        }
        else if (m_isSuff && !m_isRepeat) {
            qDebug() << "suff:" << m_isSuff;
            int randomInt = QRandomGenerator::global()->bounded(0, m_mSource.count()-1);
            m_m_curentIndex=randomInt;
            qDebug() << "index suffe"<<randomInt;
            setM_curentIndex(randomInt);
            changeMusic();
        }
        // else
        // {
        //     addIndex();
        // }
    }
}

bool controlmusic::isRepeat() const
{
    return m_isRepeat;
}

void controlmusic::setIsRepeat(bool newIsRepeat)
{
    if (m_isRepeat == newIsRepeat)
        return;
    m_isRepeat = newIsRepeat;
    emit isRepeatChanged();
}
