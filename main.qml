import QtQuick 2.15
import QtQuick.Window 2.15

Window{
    id: mainQmlApp
    visible: true
    width: 350
    height: 600

    property string darkThemeColor: "#00142f"
    property string foreColor: "#415673"
    property alias fontAwesomeFontLoader: fontAwesomeFontLoader

    property bool isMusicPlaying: false
    property bool isMusicPaused: false
    property bool isMusicPlayingMp4: false

    property int playerDuration: 0

    property real yCoordinate: 0

    property string musicTitle_ : ""
    property string artistName: "Unknown Artist"

    onIsMusicPlayingChanged: {
        if(mainQmlApp.isMusicPlaying){

            ControlMusic.playMusic()
            // playingViewID.videoID.play()
        }

        else{
            console.log("main pasue")
            ControlMusic.pauseMusic()

            // playingViewID .videoID.pause()
        }

    }
    onIsMusicPlayingMp4Changed: {
        if(mainQmlApp.isMusicPlayingMp4){
            console.log("main mp4")
            playingViewID.videoID.play()
        }else{
            playingViewID.videoID.pause()
        }
    }
    Rectangle
    {
        color: darkThemeColor
        anchors.fill: parent
        //page 1
        PlayingView
        {
            id: playingViewID
        }
    }

    Rectangle{
        id:diaLoglistViewID
        visible: false
        color: darkThemeColor
        height: mainQmlApp.height
        width: mainQmlApp.width *0.75
        anchors.right: parent.right

        PlaylistView{
            id:playlistViewID
        }
    }

    FontLoader
    {
        id: fontAwesomeFontLoader
        source: "qrc:/assets/fonts/fontawesome.otf"
    }

}
