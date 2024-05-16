import QtQuick 2.15
import QtQuick.Controls 2.15
import "ControlCustoms"


Rectangle{
    id:songIDScreen
    width: musicScreenID.width
    height: musicScreenID.height
    color: colorMediaScreen


    property alias content: content
    property bool softTitle: false
    property bool softAlbum: false
    property bool softArtist: false
    property string titleMusic: ""

    Column{
        Rectangle{
            id:titleArea
            width: songIDScreen.width
            height:100
            color: colorMediaScreen
            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 150
                color: colorMediaScreen
                Text{
                    id:textHome
                    text: qsTr("MUSIC")+Translator.updateText
                    font.pointSize: 25
                    anchors.centerIn: parent
                    color: colorText
                    font.bold: true

                }
            }
            Rectangle{
                id:folderArea
                height: titleArea.height
                width: titleArea.width-nameArea.width
                color: colorMediaScreen
                anchors.right: parent.right
                // Row{
                //     anchors.verticalCenter: parent.verticalCenter
                //     spacing: 10
                //     anchors.left: parent.left
                //     anchors.leftMargin: 10
                    TButton{
                        id:folderButton
                        sourceIC: "qrc:/assets/images/folder13.png"
                        anchors.verticalCenter: parent.verticalCenter
                        onPressed: {
                            mediaCtrl.getFolderMusic()
                        }
                    }
                    // TButton{
                    //     id:sortTitleMusicButton
                    //     width: 60
                    //     height: 35
                    //     color: "violet"
                    //     Text{
                    //         text: "Songs"
                    //         anchors.centerIn: parent
                    //         color: colorText

                    //     }
                    //     onPressed: {
                    //         softTitle=!softTitle
                    //         mediaCtrl.sortTitleMusic(softTitle)

                    //     }
                    // }
                    // TButton{
                    //     id:sortAlbumMusicButton
                    //     width: 60
                    //     height:35
                    //     color: "violet"
                    //     Text{
                    //         id:sortAlbumID
                    //         text:"Album"
                    //         anchors.centerIn: parent
                    //         color: colorText

                    //     }
                    //     onPressed: {
                    //         softAlbum=!softAlbum
                    //         mediaCtrl.sortAlbumMusic(softAlbum)

                    //     }
                    // }
                    // TButton{
                    //     id:sortArtitsMusicButton
                    //     width: 60
                    //     height: 35
                    //     color: "violet"
                    //     Text{
                    //         text: "Artist"
                    //         anchors.centerIn: parent
                    //         color: colorText
                    //     }
                    //     onPressed: {
                    //         softArtist=!softArtist
                    //         mediaCtrl.sortArtistMusic(softArtist)
                    //     }
                    // }
                // }

            }
        }

        Rectangle{
            id:content
            width: songIDScreen.width
            height:songIDScreen.height-titleArea.height
            color: colorMediaScreen
            clip: true
            ListView
            {
                id:listGlobal
                spacing: 5
                height: content.height
                width: content.width
                model:mediaCtrl.musicListModel
                delegate:Rectangle{
                    id:listRect
                    width: listGlobal.width
                    height: 100
                    radius: 10
                    color: colorListView
                    MouseArea{
                        anchors.fill:parent
                        hoverEnabled: true
                        onClicked: {
                            isPlaying=true
                            isVideo=false
                            // isShowCoverArt=false
                            mediaCtrl.setMusicPlay()
                            // mediaCtrl.setSource(SourceSongs)
                            mediaCtrl.playMusic(index)
                            mediaCtrl.setIndex(index)
                            controllerScreenID.textMusic=mediaCtrl.getMusicTitleArtist(mediaCtrl.index)

                        }
                    }
                    Column{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 5
                        Text{
                            text:  index+1+"."+ TitleSongs
                            font.pixelSize: 30
                            color:colorText
                            font.bold: true
                        }
                        Text{
                            text:"&nbsp;<b>Artist:</b>&nbsp;" + ArtistSongs+ "&nbsp;<b>Album:</b>&nbsp;" + AlbumSongs;
                            font.pixelSize: 20
                            color:  colorText
                        }
                    }

                    TButton{
                        id:deleteButton
                        sourceIC: !colorCheck? "qrc:/assets/images/trash.png":"qrc:/assets/images/garbage.png"
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        width: 30
                        height: 30
                        onPressed:{
                            mediaCtrl.deletelMusic(index)
                        }

                    }

                }

            }

        }


    }
}
