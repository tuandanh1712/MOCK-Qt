import QtQuick 2.15
import QtQuick.Window 2.15

Window{
    id: rootID
    visible: true
    width: 860
    height: 600
    // minimumHeight: 390
    // minimumWidth: 680
    color: colorMediaScreen
    property alias fontAwesomeFontLoader: fontAwesomeFontLoader
    property bool  isPlaying: false
    // property bool isShowCoverArt: false
    property bool statusVolume: false
    property bool isVideo: false
    property bool isShuffle: false
    property bool colorCheck: false
    property string colorMenuScreen: colorCheck?"#333333":"#dfe3ee"
    property string colorMediaScreen: colorCheck?"#111111":"#f7f7f7"
    property string colorText: colorCheck?"#f7f7f7":"#111111"
    property string colorListView: colorCheck?"#333333":"#ffffff"
    NavBar{
        id:navBarID
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 7
        anchors.topMargin: 4
    }
    MenuNavBar{
        id:menuScreenID
        visible: false
        width: 150
        height: rootID.height-150
        color: colorMenuScreen
        anchors.left: parent.left
    }
    ControlMusic{
        id:controllerScreenID
        width: rootID.width
        height: rootID.height-menuScreenID.height
        anchors.bottom: parent.bottom
    }
    MusicScreen{
        id:musicScreenID
        width:menuScreenID.visible==true?  rootID.width-menuScreenID.width:rootID.width-navBarID.width
        height: rootID.height-controllerScreenID.height
        color: colorMediaScreen
        Loader{
            id:loader
            active: false
            anchors.fill: musicScreenID
        }
    }
    FontLoader
    {
        id: fontAwesomeFontLoader
        source: "qrc:/assets/fonts/fontawesome.otf"
    }



}
