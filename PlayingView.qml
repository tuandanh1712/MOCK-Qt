import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtMultimedia 5.15

//Pages 1
Item {
    id: root
    anchors.fill: parent
    property bool isCPlay
    property string  songTitle: " "
    property bool isNextSong: false
    property bool isPreviousSong: false
    property string urlMp4: ""
    property alias videoID: videoID
    property alias durationMusicID: durationMusicID
    property bool isShuffleEnabled: false
    property bool isRepeated1: false
    property bool isRepeated2: false
    function millisecondsToMinutesAndSeconds(milliseconds) {
        var minutes = Math.floor(milliseconds / 60000);
        var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }
    Text {
        text: qsTr("page1")
        color: "white"
    }
    // Tạo một hàm JavaScript để tách tên bài hát và tên ca sĩ từ đường dẫn
    function getSongInfo(filePath) {
        // Tách tên file từ đường dẫn bằng cách sử dụng split('/')
        var parts = filePath.split('/');
        // Lấy phần cuối cùng (tên file)
        var fileName = parts[parts.length - 1];
        // Tách phần tên bài hát và tên ca sĩ bằng cách sử dụng split('-')
        var songInfoParts = fileName.split('-');
        // Lấy tên bài hát từ phần đầu tiên
        var songName = songInfoParts[0];
        // Lấy tên ca sĩ từ phần thứ hai
        var artistName = songInfoParts[1];
        // Gộp tên bài hát và tên ca sĩ thành một chuỗi
        var songInfo = songName.trim() + " - " + artistName.trim();
        return songInfo;
    }

    // RotationAnimator {
    //     loops: Animation.Infinite
    //     target: rotatingIcon;
    //     from: 0;
    //     to: 360;
    //     duration: 3000
    //     running: mainQmlApp.isMusicPlaying
    // }

    ColumnLayout
    {
        anchors.fill: parent


        TopNavBar
        {

        }

        Item{
            Layout.fillWidth: true
            Layout.preferredHeight: mainQmlApp.height*0.5

            // Rectangle
            // {
            //     id: musicIcon
            //     width: rotatingIcon.width; height: width; radius: width/2; color: "#3f5471";
            //     anchors.horizontalCenter: parent.horizontalCenter
            //     anchors.verticalCenter: parent.verticalCenter

            //     AppIcon
            //     {
            //         id: rotatingIcon;
            //         anchors.centerIn: parent
            //         icon: "\uf51f"; color: "#516b8e"
            //         size: mainQmlApp.height*0.5
            //     }
            // }

            Video {
                id: videoID
                width :parent.width
                height : parent.height
                // source: urlMp4
                // visible: false
                MouseArea
                {
                    anchors.fill: parent
                    onClicked: {
                        console.log("playMp4")
                        mainQmlApp.isMusicPlayingMp4=!mainQmlApp.isMusicPlayingMp4

                    }
                }

                focus: true
                Keys.onSpacePressed: videoID.playbackState == MediaPlayer.PlayingState ? videoID.pause() : videoID.play()
                Keys.onLeftPressed: videoID.seek(video.position - 5000)
                Keys.onRightPressed: videoID.seek(video.position + 5000)
            }

        }

        Text
        {
            Layout.fillWidth: true
            Layout.preferredHeight: mainQmlApp.height*0.025
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: mainQmlApp.foreColor; font.pixelSize: 14
            wrapMode: Text.Wrap
            fontSizeMode: Text.Fit
            text: isNextSong ? songTitle : playlistViewID.nameSong
        }


        DurationMusic{
            id : durationMusicID
            Layout.fillWidth: true
            Layout.preferredHeight: mainQmlApp.height*0.006
            // anchors.bottom: parent.bottom
            anchors.bottomMargin: 40
        }



        Item
        {
            Layout.fillWidth: true
            Layout.preferredHeight: mainQmlApp.height*0.1
            RowLayout
            {
                anchors.fill: parent
                anchors.topMargin: mainQmlApp.height*0.05
                spacing: mainQmlApp.width*0.028
                Item{

                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    // anchors.right: seekSongID1.left
                    // anchors.rightMargin: mainQmlApp.width*0.04
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: "\uf04a"
                        color: "#5d7ec3"
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            console.log("Previous SOng")
                            ControlMusic.playPrevious()
                            mainQmlApp.isMusicPlayingMp4=false
                            if(playlistViewID.indexSong>0){


                                playlistViewID.indexSong--
                            }
                            isPreviousSong=true
                            mainQmlApp.isMusicPlaying=false
                            console.log("Previous bai",ControlMusic.m_curentIndex)
                            console.log("ten song:",ControlMusic.m_name[ControlMusic.m_curentIndex])
                            songTitle= getSongInfo(ControlMusic.mSource[playlistViewID.indexSong])
                            console.log("Previous bai",songTitle)


                        }
                    }
                }
                Item{
                    id:seekSongID1
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    // anchors.right: playpausebtn.left
                    // anchors.rightMargin: mainQmlApp.width*0.04
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: "\uf060"
                        color: "#5d7ec3"
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            console.log("seek lui")
                            if(mainQmlApp.isMusicPlaying){

                                console.log( " ControlMusic.position truoc",ControlMusic.position)
                                ControlMusic.position=ControlMusic.position-10000
                                console.log( " ControlMusic.position sau",ControlMusic.position)
                            }
                        }
                    }
                }


                Item{
                    id: playpausebtn
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
                    // anchors.rightMargin: mainQmlApp.width*0.04

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: mainQmlApp.isMusicPlaying? "\uf04c":"\uf04b"
                        color: "#5d7ec3"
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            if(mainQmlApp.isMusicPlaying){
                                console.log("pause")
                                mainQmlApp.isMusicPlaying=false

                                mainQmlApp.isMusicPlayingMp4=false
                            }else{
                                console.log("play")
                                mainQmlApp.isMusicPlaying=true
                                console.log("sss",ControlMusic.mSource[playlistViewID.indexSong])
                                var filePath= ControlMusic.mSource[playlistViewID.indexSong].substring(ControlMusic.mSource[playlistViewID.indexSong].lastIndexOf(".") + 1, ControlMusic.mSource[playlistViewID.indexSong].length);
                                console.log("Duoi file",filePath)
                                if(filePath==="mp4"){
                                    console.log("Oke mp4")

                                    urlMp4= "file:"+ControlMusic.mSource[playlistViewID.indexSong]
                                    console.log("4444",urlMp4)
                                    videoID.source=urlMp4

                                    mainQmlApp.isMusicPlayingMp4=true
                                }else{
                                    videoID.source=""
                                }

                            }
                        }
                    }
                }

                Item{
                    id:seekSongID2
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    // anchors.left: playpausebtn.right
                    // anchors.rightMargin: mainQmlApp.width*0.04
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: "\uf061"
                        color: "#5d7ec3"
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            console.log("seek tien")
                            if(mainQmlApp.isMusicPlaying){

                                console.log( " ControlMusic.position truoc",ControlMusic.position)
                                ControlMusic.position=ControlMusic.position+10000
                                console.log( " ControlMusic.position sau",ControlMusic.position)
                            }

                        }
                    }
                }
                Item{
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    // anchors.left: seekSongID2.right
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: "\uf04e"
                        color: "#5d7ec3"
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {

                            ControlMusic.playNext()
                            mainQmlApp.isMusicPlayingMp4=false
                            console.log(ControlMusic.mSource.length)
                            if(playlistViewID.indexSong <ControlMusic.mSource.length-1){

                                playlistViewID.indexSong++
                            }else{

                            }

                            isNextSong=true
                            mainQmlApp.isMusicPlaying=false
                            console.log("next bai",playlistViewID.indexSong)
                            // console.log("m-name",ControlMusic.mSource)
                            console.log("ten song:",ControlMusic.mSource[playlistViewID.indexSong])
                            songTitle= getSongInfo(ControlMusic.mSource[playlistViewID.indexSong])
                            console.log("duration nex bai",millisecondsToMinutesAndSeconds(ControlMusic.getDuration()))

                        }
                    }
                }
            }
        }
        AudioControl{
            id:audioID
            Layout.preferredHeight: mainQmlApp.height *0.06
        }
        Item
        {
            Layout.fillWidth: true
            Layout.preferredHeight: mainQmlApp.height *0.1

            RowLayout
            {
                anchors.fill: parent
                anchors.bottomMargin: mainQmlApp.height*0.05
                // spacing: mainQmlApp.width*0.028

                Item{
                    // Shuffle
                    id:shuffID
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: "\uf074"
                        color: isShuffleEnabled? "white":foreColor
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {
                            isShuffleEnabled=!isShuffleEnabled
                            if(isShuffleEnabled){
                                console.log("Tron bai")
                                ControlMusic.isSuff=true
                            }else{
                                console.log("Huy tron bai")
                            }
                            // mainQmlApp.isMusicPlaying=false
                        }
                    }
                }

                Item{
                    // delete
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: "\uf1f8"
                        color: foreColor
                        size: 25
                        //visible: false
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {console.log("delete")}
                    }
                }


                Item{
                    // Repeat
                    height: mainQmlApp.height*0.07; width: mainQmlApp.width*0.12
                    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter

                    AppIcon
                    {
                        anchors.centerIn: parent
                        icon: mainQmlApp.repeatIndex === 1? "\uf366":"\uf364"
                        color:foreColor
                        size: 25
                    }

                    MouseArea
                    {
                        anchors.fill: parent
                        onClicked: {

                            isRepeated1=!isRepeated1

                            if(isRepeated1){
                                console.log("Lap bai1")
                                // isRepeated1=false
                            }else{
                                isRepeated2=!isRepeated2
                                if(isRepeated2){
                                    console.log("Lap bai2")
                                }
                            }
                            if(!isRepeated1 && !isRepeated2){
                                console.log("Huy bai1")
                            }


                        }
                    }
                }
            }
        }
    }
}
