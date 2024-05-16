import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtMultimedia 5.15
import "ControlCustoms"

Rectangle{
    id:menuScreenID
    property bool isEnglish: false
    Column{
        spacing:50
        anchors.top: parent.top
        // anchors.topMargin: 50
        TButton{
            id:themesDarkButtonID
            width: 50
            height: 50
            Text{
                text: qsTr("Dark/Light")+Translator.updateText
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                color: colorText
            }
            sourceIC: colorCheck==false?"qrc:/assets/images/toggle_on_FILL0_wght400_GRAD200_opsz48.png":"qrc:/assets/images/toggle_off_FILL0_wght400_GRAD200_opsz48.png"
            onPressed: {
                colorCheck=!colorCheck

            }
        }

        Rectangle{
            id:rectHomeID
            height: homeID.implicitHeight
            width: menuScreenID.width
            color: colorMenuScreen
            border.color: colorText
            border.width: 2
            radius: 2
            Text{
                id:homeID
                font.pixelSize: 30
                color: colorText
                text: qsTr("Home")+Translator.updateText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        loader.active=false

                    }
                }
            }
        }
        Rectangle{
            id:rectMusicID
            height: musicID.implicitHeight
            width: menuScreenID.width
            color: colorMenuScreen
            border.color: colorText
            border.width: 2
            radius: 2
            Text{
                id:musicID
                font.pixelSize: 30
                color:colorText
                text: qsTr("Music")+Translator.updateText
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("playSong")
                        loader.active=true
                        loader.source="qrc:/ListMp3.qml"
                    }
                }
            }
        }
        Rectangle{
            id:rectMp4ID
            height: mp4ID.implicitHeight
            width: menuScreenID.width
            color: colorMenuScreen
            border.color: colorText
            border.width: 2
            radius: 2
            Text{
                id:mp4ID
                font.pixelSize: 30
                color: colorText
                text: qsTr("Video")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        console.log("playSong")
                        loader.active=true
                        loader.source="qrc:/ListMp4.qml"
                    }
                }
            }
        }
        TButton{
            id:langueButtonID
            width: 30
            height: 30
            Text{
                text: "Vi/En"
                anchors.left: parent.left
                anchors.leftMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                color: colorText
            }
            sourceIC: isEnglish==false?"qrc:/assets/images/toggle_on_FILL0_wght400_GRAD200_opsz48.png":"qrc:/assets/images/toggle_off_FILL0_wght400_GRAD200_opsz48.png"
            onPressed: {
                isEnglish=!isEnglish
                Translator.transVietNamese(isEnglish)
            }
        }

    }
}
