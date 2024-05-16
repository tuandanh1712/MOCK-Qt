#ifndef TRANSLATOR_H
#define TRANSLATOR_H

#include "qguiapplication.h"
#include "qtranslator.h"
#include <QObject>

class Translator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString updateText READ updateText NOTIFY languageChanged )
public:
    explicit Translator(QObject *parent = nullptr);
    Q_INVOKABLE void transVietNamese(bool isEnglish);

    QString updateText() const;

signals:
    void languageChanged();
private:
    QTranslator m_translator;
    QGuiApplication *m_App;
    QString m_updateText;
};

#endif // TRANSLATOR_H
