import QtQuick 2.15
import QtQuick.Controls 2.15

import "ControlCustoms"
Rectangle{
    id:videoScreen
    width: musicScreenID.width
    height: musicScreenID.height
    color: colorMediaScreen

    property alias contentArea: content
    property bool softTitle: false
    property bool softAlbum: false
    property bool softArtist: false


    Column{
        Rectangle{
            id:titleArea
            width: videoScreen.width
            height:100
            color: colorMediaScreen
            Rectangle{
                id:nameArea
                height: titleArea.height
                width: 150
                color: colorMediaScreen
                Text{
                    id:sectionName
                    text: qsTr("VIDEO")
                    font.pointSize: 25
                    anchors.centerIn: parent
                    font.bold: true
                    color: colorText

                }
            }
            Rectangle{
                id:folderArea
                height: titleArea.height
                width: titleArea.width-nameArea.width
                color: colorMediaScreen
                anchors.right: parent.right
                Row{
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    TButton{
                        id:folderButton
                        sourceIC: "qrc:/assets/images/folder13.png"
                        onPressed: {
                            mediaCtrl.getFolderVideo()
                        }
                    }


                    TButton{
                        id:sortTitleButton
                        width: 65
                        height: 35
                        color: "violet"
                        Text{
                            text: "Video"
                            anchors.centerIn: parent
                            color: colorText
                        }
                        onPressed: {
                            softTitle=!softTitle
                            mediaCtrl.sortTitleVideo(softTitle)
                        }
                    }
                    TButton{
                        id:sortAlbumButton
                        width: 65
                        height: 35
                        color: "violet"
                        Text{
                            text:"Album"
                            anchors.centerIn: parent
                            color: colorText
                        }
                        onPressed: {
                            softAlbum=!softAlbum
                            mediaCtrl.sortAlbumVideo(softAlbum)
                        }
                    }
                    TButton{
                        id:sortArtitsButton
                        width: 65
                        height: 35
                        color: "violet"
                        Text{
                            text: "Artist"
                            anchors.centerIn: parent
                            color: colorText
                        }
                        onPressed: {
                            softArtist=!softArtist
                            mediaCtrl.sortArtistVideo(softArtist)
                        }
                    }


                }

            }
        }

        Rectangle{
            id:content
            width: videoScreen.width
            height:videoScreen.height-titleArea.height
            color: colorMediaScreen
            clip: true
            ListView
            {
                spacing: 5
                id:listGlobalVideo
                height: content.height
                width: content.width
                model:mediaCtrl.videoListModel
                delegate:
                    Rectangle{
                    id:listRect
                    width: listGlobalVideo.width
                    height: 100
                    radius: 10
                    color: colorCheck?"#333333":"#ffffff"
                    MouseArea{
                        anchors.fill:parent
                        onClicked: {
                            listGlobalVideo.currentIndex = index
                            isPlaying=true
                            isVideo=true
                            // isShowCoverArt=true
                            console.log("click video")
                            mediaCtrl.setVideoPlay()
                            mediaCtrl.playVideo(index);
                            mediaCtrl.setIndexVideo(index);
                            loader.active=false
                            controllerScreenID.textVideo=mediaCtrl.getVideoTitleArtist(mediaCtrl.indexVideo)
                        }
                    }
                    Column{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        spacing: 5
                        Text{
                            text:  index+1+"."+ TitleVideo
                            font.pixelSize: 30
                            color:colorText
                            font.bold: true
                        }
                        Text{
                            text:"&nbsp;<b>Artist:</b>&nbsp;" + ArtistVideo+ "&nbsp;<b>Album:</b>&nbsp;" + AlbumVideo;
                            font.pixelSize: 20
                            color:  "black"

                        }

                    }
                    TButton{
                        id:deleteButton
                        sourceIC: colorCheck? "qrc:/assets/images/archive-remove-outline.svg":"qrc:/assets/images/archive-remove.svg"
                        anchors.right: parent.right
                        anchors.rightMargin: 15
                        width: 30
                        height: 30
                        onPressed:{
                            mediaCtrl.deletelVideo(index)
                        }

                    }

                }

            }

        }


    }
}
