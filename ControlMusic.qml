import QtQuick 2.15

import "ControlCustoms"
Rectangle{
    id:controllerScreenID
    color:colorMenuScreen
    border.width: 1
    border.color: "#F4A460"
    property alias sliderBarID: sliderBarID
    property alias volumeSliderID: volumeSlider
    property int repeatIndex: 0
    property alias textMusic: textMusic.text
    property alias textVideo: textVideo.text

    function formatTime(milliseconds) {
        var totalSeconds = Math.floor(milliseconds / 1000);
        var minutes = Math.floor(totalSeconds / 60);
        var seconds = totalSeconds % 60;
        return minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0');
    }
    Column{
        Rectangle{
            id:textAreaID
            width: controllerScreenID.width
            height: 35
            color:colorMenuScreen
            Rectangle{
                id:textRunArea
                width: 400
                height: textAreaID.height
                color:colorMenuScreen
                anchors.centerIn:parent
                radius: 50
                clip: true
                Text{
                    id:textMusic

                    visible: false
                }
                Text{
                    id:textVideo

                    visible: false
                }
                Text{
                    id: textMediaID
                    width: parent.width
                    text:isVideo?textVideo.text: textMusic.text
                    color:colorText
                    font.pixelSize: 14
                    anchors.verticalCenter: parent.verticalCenter
                    NumberAnimation {
                        target: textMediaID
                        property: "x"
                        loops: Animation.Infinite
                        from: textRunArea.width
                        to: -textRunArea.width
                        duration: 5000
                        running: true
                    }
                }

            }

        }
        Rectangle{
            id:sliderArea
            width: controllerScreenID.width
            height: 40
            color:colorMenuScreen
            Row{
                anchors.centerIn: parent
                spacing: 10
                Text{
                    id:timePlayingVideoID
                    text:formatTime(mediaCtrl.position)
                    color: colorText
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                }
                SliderBar{
                    id:sliderBarID
                    anchors.verticalCenter: parent.verticalCenter
                    position:  (mediaCtrl.position/mediaCtrl.duration)*(ranger)//get postion of media in width of slider,
                    onClicked: {
                        if(positionMouse<ranger)
                        {

                            mediaCtrl.position= (mediaCtrl.duration)*(positionMouse/ranger)// ranger =sliderBarID.width - handleID.width
                        }
                        else
                        {

                            mediaCtrl.position=mediaCtrl.duration
                        }

                    }
                    onDragged: {

                        mediaCtrl.position= (mediaCtrl.duration)*(position/ranger)
                    }
                }
                Text{
                    id:timeVideoID
                    text: formatTime(mediaCtrl.duration)
                    color: colorText
                    font.pixelSize: 15
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
        Rectangle{
            id:controllerArea
            width: controllerScreenID.width
            height: controllerScreenID.height-sliderArea.height-textAreaID.height
            anchors.horizontalCenter: parent.horizontalCenter
            color:colorMenuScreen
            Row{
                anchors.centerIn: parent
                spacing:25
                TButton{
                    id:shufferButton
                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: isShuffle?"qrc:/assets/images/Shuffle_Active.svg":"qrc:/assets/images/shuffle_FILL0_wght300_GRAD200_opsz48.png"
                    onPressed: {
                        mediaCtrl.shuffleMedia()
                        isShuffle=!isShuffle
                    }
                }
                TButton{
                    id:speedButton
                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: "qrc:/assets/images/speed.png"
                    property real rate: 1.0
                    Text {
                        anchors.bottom: speedButton.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        id: speed
                        text: speedButton.rate.toString()+"x"
                    }

                    onPressed: {
                        if(rate<2.0)
                        {
                            rate+=0.25
                        }
                        else{
                            rate=0.25;
                        }
                        mediaCtrl.speedMedia(rate)

                    }

                }
                TButton{
                    id:seekBacKButton
                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: "qrc:/assets/images/fast-backward13.png"
                    onPressed: {
                        mediaCtrl.seekBack()
                    }
                }
                TButton{
                    id:previousButton
                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: "qrc:/assets/images/previous13.png"
                    onPressed: {
                        mediaCtrl.previousMedia()
                        if(isVideo){
                            controllerScreenID.textVideo=mediaCtrl.getVideoTitleArtist(mediaCtrl.indexVideo)

                        }else{
                            controllerScreenID.textMusic=mediaCtrl.getMusicTitleArtist(mediaCtrl.index)

                        }
                    }
                }
                TButton{
                    id:playButton
                    width:50
                    height: 50
                    radius: 50
                    sourceIC: isPlaying==true?"qrc:/assets/images/pause13.png":"qrc:/assets/images/play13.png"
                    anchors.verticalCenter: parent.verticalCenter
                    onPressed: {
                        !isPlaying?mediaCtrl.resumeMedia(): mediaCtrl.pauseMedia()
                        isPlaying =!isPlaying
                    }
                }
                TButton{
                    id:nextButton

                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: "qrc:/assets/images/next13.png"
                    onPressed: {
                        mediaCtrl.nextMedia()
                        if(isVideo){
                            controllerScreenID.textVideo=mediaCtrl.getVideoTitleArtist(mediaCtrl.indexVideo)

                        }else{
                            controllerScreenID.textMusic=mediaCtrl.getMusicTitleArtist(mediaCtrl.index)

                        }
                    }

                }
                TButton{
                    id:seekForwardButton
                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: "qrc:/assets/images/fast-forward.13png"
                    onPressed: {
                        mediaCtrl.seekForward()
                    }

                }
                TButton {
                    id: repeatButton
                    anchors.verticalCenter: parent.verticalCenter
                    sourceIC: "qrc:/assets/images/Loop_Icon.svg"
                    onPressed:  {
                        repeatIndex += 1
                        mediaCtrl.repeatMedia(repeatIndex)
                        if (repeatIndex === 3)
                            repeatIndex = 0
                        updateButtonText()
                    }

                    function updateButtonText() {// to update status text of repeatButton
                        if (repeatIndex == 1){
                            repeatButton.sourceIC="qrc:/assets/images/Single_Loop.svg"
                        }
                        else if (repeatIndex == 2){

                            repeatButton.sourceIC="qrc:/assets/images/Loop_Playlist.svg"
                        }
                        else{
                            repeatButton.sourceIC="qrc:/assets/images/Loop_Icon.svg"

                        }

                    }
                }


                Row{
                    spacing: 2
                    anchors.verticalCenter: parent.verticalCenter
                    TButton{
                        id:volumeButton
                        anchors.verticalCenter: parent.verticalCenter
                        sourceIC:statusVolume==true?"qrc:/assets/images/mute.png": "qrc:/assets/images/audio.png"
                    }
                    SliderBar{
                        id:volumeSlider
                        width: 70
                        height: 10
                        anchors.verticalCenter: parent.verticalCenter
                        position: mediaCtrl.volume*ranger/100
                        onClicked: {
                            console.log("click volume",position)
                            mediaCtrl.volume=positionMouse/ranger*100
                        }
                        onDragged: {
                            mediaCtrl.volume=position/ranger*100
                            position/ranger===0?statusVolume=true:statusVolume=false
                        }
                    }
                }
            }

        }
    }
}
