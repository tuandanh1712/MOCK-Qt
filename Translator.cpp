#include "Translator.h"
#include "qdebug.h"

Translator::Translator(QObject *parent)
    : QObject{parent}
{
    m_translator.load(":/assets/language/transen.qm");
    m_App->installTranslator(&m_translator);

}

void Translator::transVietNamese(bool isEnglish)
{
    qDebug()<<"is"<<isEnglish;
    if(isEnglish){

        m_translator.load(":/assets/language/transen.qm");
    }else {
        m_translator.load(":/assets/language/transvn.qm");
    }
    m_App->installTranslator(&m_translator);
    emit languageChanged();
}


QString Translator::updateText() const
{
    return "";
}
