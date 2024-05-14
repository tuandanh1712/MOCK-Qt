import QtQuick 2.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.15

Rectangle{
    id:mediaScreen
    anchors.right: parent.right
    color: colorMediaScreen
    clip: true
    Image {
        id: imgHomeID
        source: "qrc:/assets/images/logoApp.ico"
        fillMode: Image.PreserveAspectFit
        anchors.fill:parent

    }
    VideoOutput{
        id:videoID
        source: mediaCtrl
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectFit
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            menuScreenID.visible=false
        }
    }


}
