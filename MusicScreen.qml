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
        source: "qrc:/assets/images/Spotify-Emblema.png"
        fillMode: Image.PreserveAspectFit
        anchors.fill:parent

    }
    RotationAnimation{
        id: rollanimationid
        target: imgHomeID
        from: 0
        to:360
        loops: Animation.Infinite
        duration: 10000
        running:true
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
