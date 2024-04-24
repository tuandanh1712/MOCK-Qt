// import QtQuick 2.15
// import QtQuick.Layouts 1.3
// import Qt.labs.platform 1.0


// Item {
//     id:itemListSongID
//     height: parent.height
//     width: parent.width
//     signal loadList
//     property string nameSong: ""
//     // FileDialog {
//     //     id: fileDialog
//     //     fileMode:  FileDialog.OpenFiles
//     //     nameFilters: ["Music files (*.mp3 *.wav *.flac)", "All files (*)"]
//     //     onAccepted: {
//     //         ControlMusic.setName(fileDialog.folder)
//     //         console.log(fileDialog.folder)
//     //         itemListSongID.loadList()
//     //     }
//     // }
//     FolderDialog {
//         id: fileDialog
//         currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
//         folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]

//         onAccepted: {
//             ControlMusic.setName(fileDialog.folder)
//             console.log(fileDialog.folder)
//             itemListSongID.loadList()
//         }
//     }

//     TopNavBar{}
//     Rectangle
//     {
//         id:rectAddID
//         color: "white"
//         width: parent.width; height: 25;
//         anchors.horizontalCenter: parent.horizontalCenter
//         AppIcon
//         {
//             icon: "\uf067"; size: 15; color: mainQmlApp.darkThemeColor
//             anchors.horizontalCenter: parent.horizontalCenter
//             anchors.verticalCenter: parent.verticalCenter


//         }
//         MouseArea
//         {
//             anchors.fill: parent
//             onClicked: {
//                 console.log("add music")
//                 fileDialog.open()
//             }
//         }

//     }
//     ListView{
//         id:listViewID
//         anchors.fill: parent
//         anchors.top: parent.top
//         anchors.topMargin: 80
//         model: SongModel
//         delegate:Item {
//             width: itemListSongID.width
//             height: displaySongsID.implicitHeight+20
//             Rectangle {
//                 id: lineSongID
//                 anchors.left: parent.left
//                 width: parent.width
//                 height: 30
//                 color: darkThemeColor
//                 Text {
//                     id: displaySongsID
//                     anchors.left: parent.left
//                     wrapMode: Text.Wrap
//                     text: index+1 + ". "+ name
//                     color: "white"
//                     fontSizeMode: Text.Fit
//                 }
//             }
//             MouseArea {
//                 anchors.fill: parent
//                 hoverEnabled: true
//                 onEntered:  {
//                     console.log("entern")
//                     displaySongsID.color = "red"
//                     lineSongID.color="lightyellow"
//                 }
//                 onExited: {
//                     console.log("exit")
//                     displaySongsID.color = "white"
//                     lineSongID.color="darkThemeColor"
//                 }
//                 onClicked: {
//                     console.log("index",index)
//                     isChecked=true
//                     ControlMusic.setSource(index)
//                     ControlMusic.setcurentIndex(index)
//                     nameSong=displaySongsID.text

//                 }
//             }
//         }
//         focus: true
//     }

// }


import QtQuick 2.15
import QtQuick.Layouts 1.3
import Qt.labs.platform 1.0

Item {
    id: itemListSongID
    height: parent.height
    width: parent.width
    property string nameSong: ""
    property alias fileDialog: fileDialog.folder
    property int indexSong:0
    property string duration: ""

    function millisecondsToMinutesAndSeconds(milliseconds) {
        var minutes = Math.floor(milliseconds / 60000);
        var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }
    // FolderDialog {
    //     id: fileDialog
    //     currentFolder: StandardPaths.standardLocations(StandardPaths.HomeLocation)[0]
    //     folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]

    //     onAccepted: {
    //         ControlMusic.setName(fileDialog.folder)
    //         console.log(fileDialog.folder)

    //     }
    // }
    FileDialog {
        id: fileDialog
        fileMode:  FileDialog.OpenFiles
        nameFilters: ["Music files (*.mp3 *.mp4 *.flac)", "All files (*)"]
        // folder: StandardPaths.standardLocations(StandardPaths.MusicLocation)[0]

        onAccepted: {
            ControlMusic.setName(fileDialog.folder)
            console.log(fileDialog.folder)

        }
    }

    TopNavBar{}

    Rectangle {
        id: rectAddID
        color: "white"
        width: parent.width
        height: mainQmlApp.height*0.06
        anchors.horizontalCenter: parent.horizontalCenter

        AppIcon {
            icon: "\uf067"
            size: 15
            color: mainQmlApp.darkThemeColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("add music")
                fileDialog.open()
            }
        }
    }

    ListView {
        id: listViewID
        anchors.fill: parent
        anchors.top: parent.top
        anchors.topMargin: mainQmlApp.height*0.13
        model: SongModel
        delegate: Item {
            width: itemListSongID.width
            height: displaySongsID.implicitHeight + mainQmlApp.height*0.03

            Rectangle {
                id: lineSongID
                anchors.left: parent.left
                width: parent.width
                height: displaySongsID.height
                color: darkThemeColor

                Text {
                    id: displaySongsID
                    anchors.left: parent.left
                    width: parent.width
                    wrapMode: Text.Wrap
                    text:   name
                    color: "white"
                    fontSizeMode: Text.Fit

                    SequentialAnimation {
                        id: textAnimation
                        running: true
                        loops: Animation.Infinite

                        PauseAnimation { duration: 1000 }

                        NumberAnimation {
                            target: displaySongsID
                            property: "x"
                            from: 0
                            to: mainQmlApp.width
                            duration: 1000
                            easing.type: Easing.Linear
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    // console.log("entered")
                    displaySongsID.color = "red"
                    lineSongID.color = "lightyellow"
                }
                onExited: {
                    // console.log("exited")
                    displaySongsID.color = "white"
                    lineSongID.color = "darkThemeColor"
                }
                onClicked: {
                    console.log("index", index)
                    // duration=millisecondsToMinutesAndSeconds(ControlMusic.getDuration())
                    console.log('asdas',ControlMusic.getDuration())
                    console.log("duarationq121",duration)
                    duration=millisecondsToMinutesAndSeconds(ControlMusic.getDuration())
                    indexSong=index
                    ControlMusic.setSource(index)
                    ControlMusic.setcurentIndex(index)
                    nameSong = displaySongsID.text
                    mainQmlApp.isMusicPlaying=false
                    mainQmlApp.isMusicPlayingMp4=false
                    playingViewID.isNextSong=false
                    playingViewID.isPreviousSong=false
                }
            }
        }
        focus: true
    }
}

