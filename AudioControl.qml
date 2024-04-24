// import QtQuick 2.15
// import QtQuick.Window 2.15
// import QtQuick.Layouts 1.0

// import QtQuick.Controls 2.15
// import "ControlCustoms"
// RowLayout{
//     id : volumeRow
//     property real value: 0.5
//     Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
//     width: mainQmlApp.width*0.9
//     TButton {
//         id : volumeButton
//         width: 50
//         sourceIC : "qrc:/assets/images/audio.png"
//         Text {
//             id: subAudio
//             text: qsTr("Unmute")
//             visible: false
//             anchors.bottom: parent.top
//         }
//         isAudio: true
//         scale: 0.5
//         onPressed:{
//             if (isAudio == true) {
//                 volumeButton.sourceIC = "qrc:/assets/images/mute.png"
//                 isAudio = false

//                 subAudio.text = qsTr("Unmute")
//             } else {
//                 volumeButton.sourceIC = "qrc:/assets/images/audio.png"
//                 subAudio.text = qsTr("Mute")
//             }
//         }
//         onEnter:{
//             volumeButton.scale = 0.8
//             if (isAudio == true) {
//                 subAudio.text = qsTr("Mute")
//                 subAudio.visible = true
//             } else {
//                 subAudio.text = qsTr("Unmute")
//                 subAudio.visible = true
//             }
//         }
//         onExit: {
//             subAudio.visible = false
//             volumeButton.scale = 0.5
//         }
//     }
//     Rectangle {
//         id:recID
//         // anchors.centerIn: parent
//         width: 200
//         height:  mainQmlApp.height*0.006
//         color: "lightblue"
//         border.color: "blue"
//         radius: 5
//         // x:100

//         Rectangle {
//             id: slider
//             width: 10
//             height: 5
//             color: "darkblue"
//             radius: 5
//             x: Math.min(Math.max(0, mouseArea.mouseX - width / 2), parent.width - width)
//             // Binding for slider position
//             onXChanged: {
//                 // Calculate the value based on the position of the rectangle's center
//                 var relativeX = (x + width / 2) / recID.width;
//                 value = Math.min(Math.max(relativeX, 0), 1); // Specify the context explicitly
//                 console.log("Slider Value at Position:", value);
//                 recID.valueChanged1(value)
//             }
//         }

//         MouseArea {
//             id: mouseArea
//             anchors.fill: parent
//             drag.target: slider
//             drag.axis: Drag.XAxis
//         }

//         signal valueChanged1(real newValue)

//         onValueChanged1: {
//             value=newValue

//             console.log("Slider Value Changed:", newValue)
//         }
//     }


// }

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.0

import QtQuick.Controls 2.15
import "ControlCustoms"

Row {
    id: volumeRow
    property real value: 0.5
    property bool isAudio: true
    Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
    width: mainQmlApp.width * 0.7
    Layout.fillWidth: true // Ensure that RowLayout takes up all available width
    spacing: 4 // Set the spacing between items

    TButton {
        id: volumeButton
        width: 50
        sourceIC : "qrc:/assets/images/audio.png"
        Text {
            id: subAudio
            text: qsTr("Unmute")
            visible: false
            anchors.bottom: parent.top
        }
        isAudio: true
        scale: 0.5
        // onPressed:{
        //     console.log("press")
        //     if (isAudio == true) {
        //         volumeButton.sourceIC = "qrc:/assets/images/mute.png"
        //         isAudio = false
        //         subAudio.text = qsTr("Unmute")
        //     } else {
        //         volumeButton.sourceIC = "qrc:/assets/images/audio.png"
        //         subAudio.text = qsTr("Mute")
        //     }
        // }
        // onEnter:{
        //     volumeButton.scale = 0.8
        //     console.log("entern")
        //     if (isAudio == true) {
        //         subAudio.text = qsTr("Mute")
        //         subAudio.visible = true
        //     } else {
        //         subAudio.text = qsTr("Unmute")
        //         subAudio.visible = true
        //     }
        // }
        // onExit: {
        //     subAudio.visible = false
        //     volumeButton.scale = 0.5
        // }
    }

    Rectangle {
        id:recID
        width: volumeRow.width - volumeButton.width - volumeRow.spacing -40// Adjusted width calculation
        height:  mainQmlApp.height * 0.009
        radius: 5
        anchors.verticalCenter: volumeButton.verticalCenter // Ensure vertical alignment with TButton
        Rectangle {
            id: slider
            Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
            width: 14
            height: 14
            color: "white"

            radius: width/2
            y:-3
            x: Math.min(Math.max(0, mouseArea.mouseX - width / 2), parent.width - width)
            // Binding for slider position
            onXChanged: {
                // Calculate the value based on the position of the rectangle's center
                var relativeX = (x + width / 2) / recID.width;
                value = Math.min(Math.max(relativeX, 0), 1); // Specify the context explicitly
                recID.valueChanged1(value)


            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag.target: slider
            drag.axis: Drag.XAxis
        }

        signal valueChanged1(real newValue)

        onValueChanged1: {
            value = newValue-0.02734375
            console.log("Slider Value Changed:", newValue)
            ControlMusic.setvolume(value )

            playingViewID.videoID.volume=value
            if(value<0.1){
                console.log("tat")
                subAudio.text = qsTr("Mute")
                volumeButton.sourceIC = "qrc:/assets/images/mute.png"
                subAudio.visible = true

            }else{
                console.log("bat")
                // isAudio=false
                subAudio.text = qsTr("UnMute")
                subAudio.visible = true
                volumeButton.sourceIC = "qrc:/assets/images/audio.png"


            }

        }
    }
}
