// import QtQuick 2.15
// import QtQuick.Window 2.15
// import QtQuick.Layouts 1.0
// import QtQuick.Controls 2.15

// Item {
//     id: durationItemID
//     property real value: 0
//     property alias texDurationID: texDurationID.text
//     property string durationChange: ""

//     function millisecondsToMinutesAndSeconds(milliseconds) {
//         var minutes = Math.floor(milliseconds / 60000);
//         var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
//         return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
//     }
//     Column {
//         spacing:5
//         Rectangle {
//             id:recID
//             width: durationItemID.width   // Adjusted width calculation
//             height:  mainQmlApp.height * 0.009
//             color: "lightblue"
//             border.color: "blue"
//             radius: 5

//             Rectangle {
//                 id: slider
//                 Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
//                 width: 14
//                 height: 14
//                 color: "white"

//                 radius: width/2
//                 y:-3
//                 x: Math.min(Math.max(0, mouseArea.mouseX - width / 2), parent.width - width)
//                 // Binding for slider position
//                 onXChanged: {
//                     durationChange=millisecondsToMinutesAndSeconds(ControlMusic.position);
//                     console.log("duarationChange",ControlMusic.position);
//                     // Calculate the value based on the position of the rectangle's center
//                     var relativeX =( (x + width / 2) / recID.width);
//                     value = Math.min(Math.max(relativeX, 0), 1); // Specify the context explicitly
//                     console.log("Slider Value at Position:", value);
//                     recID.valueChanged1(value)
//                 }

//                 Timer{
//                     interval: 1000
//                     running: true
//                     repeat: true
//                     onTriggered:{
//                         if(mainQmlApp.isMusicPlaying){
//                             contro






//                         }

//                     }

//                 }
//             }

//             MouseArea {
//                 id: mouseArea
//                 anchors.fill: parent
//                 drag.target: slider
//                 drag.axis: Drag.XAxis
//             }

//             signal valueChanged1(real newValue)

//             onValueChanged1: {
//                 value = newValue
//                 console.log("Slider Value Changed:", newValue)

//                 ControlMusic.position=value*230424
//             }
//         }
//         Rectangle{
//             id:rectDuraID1
//             width: texDurationID1.implicitWidth
//             anchors.left: parent.left

//             Text{
//                 id:texDurationID1
//                 anchors.bottom: parent.bottom
//                 text:durationChange
//                 color: "white"
//             }
//         }
//         Rectangle{
//             id:rectDuraID
//             width: texDurationID.implicitWidth
//             anchors.right: parent.right

//             Text{
//                 id:texDurationID
//                 anchors.bottom: parent.bottom
//                 // text:duration
//                 color: "white"
//             }
//         }
//     }

// }
// import QtQuick 2.15
// import QtQuick.Window 2.15
// import QtQuick.Layouts 1.0
// import QtQuick.Controls 2.15

// Item {
//     id: durationItemID
//     property real value: 0
//     property alias texDurationID: texDurationID.text
//     property string durationChange: ""

//     function millisecondsToMinutesAndSeconds(milliseconds) {
//         var minutes = Math.floor(milliseconds / 60000);
//         var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
//         return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
//     }

//     Column {
//         spacing: 15

//         Rectangle {
//             id: recID
//             width: durationItemID.width   // Adjusted width calculation
//             height:  mainQmlApp.height * 0.009
//             color: "lightblue"
//             border.color: "blue"
//             radius: 5

//             Rectangle {
//                 id: slider
//                 Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
//                 width: 14
//                 height: 14
//                 color: "white"
//                 radius: width / 2
//                 y: -3
//                 x: Math.min(Math.max(0, mouseArea.mouseX - width / 2), parent.width - width)

//                 // Binding for slider position
//                 onXChanged: {
//                     var relativeX = (x + width / 2) / recID.width;
//                     value = Math.min(Math.max(relativeX, 0), 1); // Specify the context explicitly
//                     console.log("Slider Value at Position:", value);
//                     recID.valueChanged1(value);
//                 }
//             }

//             MouseArea {
//                 id: mouseArea
//                 anchors.fill: parent
//                 drag.target: slider
//                 drag.axis: Drag.XAxis
//             }

//             signal valueChanged1(real newValue)

//             onValueChanged1: {
//                 value = newValue;
//                 console.log("Slider Value Changed:", newValue);
//                 ControlMusic.position = value * ControlMusic.getDuration(); // Set position based on slider value
//                 durationChange=millisecondsToMinutesAndSeconds( ControlMusic.position)
//                 playingViewID.videoID.seek(ControlMusic.position)

//             }
//         }
//         Row{
//             spacing: mainQmlApp.width-rectDuraID.width-rectDuraID1.width
//             Rectangle {
//                 id: rectDuraID1
//                 width: texDurationID1.implicitWidth
//                 // anchors.left: parent.left
//                 height: texDurationID1.implicitHeight
//                 color: darkThemeColor

//                 Text {
//                     id: texDurationID1
//                     // anchors.top: parent.bottom
//                     text: durationChange
//                     color: "white"
//                 }
//             }

//             Rectangle {
//                 id: rectDuraID
//                 width: texDurationID.implicitWidth
//                 // anchors.right: parent.right
//                 height: texDurationID1.implicitHeight
//                 color: darkThemeColor

//                 Text {
//                     id: texDurationID
//                     // anchors.top: parent.bottom
//                     text:"23:32"
//                     color: "white"
//                 }
//             }
//         }

//     }

//     Timer {
//         id: timer
//         interval: 1000
//         running: false
//         repeat: true
//         onTriggered: {
//             if (mainQmlApp.isMusicPlaying) {
//                 slider.x = (ControlMusic.position / ControlMusic.getDuration()) * recID.width - slider.width / 2;
//             }
//         }
//     }

//     Component.onCompleted: {
//         timer.start(); // Start the timer when the component is completed
//     }

//     // Stop the timer when the component is destroyed
//     // Component.onDestruction: {
//     //     timer.stop();
//     // }
// }
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import QtMultimedia 5.15

Item {
    id: durationItemID
    property real value: 0
    property alias texDurationID: texDurationID.text
    property string durationChange: ""

    function millisecondsToMinutesAndSeconds(milliseconds) {
        var minutes = Math.floor(milliseconds / 60000);
        var seconds = ((milliseconds % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }

    Column {
        spacing: 10

        Rectangle {
            id: recID
            width: durationItemID.width   // Adjusted width calculation
            height:  mainQmlApp.height * 0.009
            color: "lightblue"
            border.color: "blue"
            radius: 5

            Rectangle {
                id: slider
                Layout.alignment: Qt.AlignVCenter|Qt.AlignHCenter
                width: 14
                height: 14
                color: "white"
                radius: width / 2
                y: -3
                x: Math.min(Math.max(0, mouseArea.mouseX - width / 2), parent.width - width)

                // Binding for slider position
                onXChanged: {
                    var relativeX = (x + width / 2) / recID.width;
                    value = Math.min(Math.max(relativeX, 0), 1); // Specify the context explicitly
                    // console.log("Slider Value at Position:", value);
                    recID.valueChanged1(value);
                }
            }
            //             MouseArea {
            //                 id: mouseArea
            //                 anchors.fill: parent
            //                 drag.target: slider
            //                 drag.axis: Drag.XAxis
            //             }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                drag.target: slider
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: parent.width-slider.width
                onClicked: {
                    var mouseX = mouse.x; // Vị trí X của con trỏ chuột trong MouseArea
                    var relativeX = mouseX / parent.width; // Tính toán vị trí tương đối trên thanh trượt
                    slider.x = mouseX - slider.width / 2; // Di chuyển thanh trượt tới vị trí click
                    value = Math.min(Math.max(relativeX, 0), 1); // Cập nhật giá trị của thanh trượt
                    recID.valueChanged1(value); // Gửi sự kiện khi giá trị thay đổi
                    ControlMusic.position = value * ControlMusic.getDuration(); // Thiết lập vị trí của video
                    durationChange = millisecondsToMinutesAndSeconds(ControlMusic.position); // Cập nhật thời lượng hiển thị
                    playingViewID.videoID.seek(ControlMusic.position); // Đặt vị trí của video
                }
            }

            signal valueChanged1(real newValue)

            onValueChanged1: {
                value = newValue;
                // console.log("Slider Value Changed:", newValue);
                ControlMusic.position = value * ControlMusic.getDuration(); // Set position based on slider value
                durationChange = millisecondsToMinutesAndSeconds(ControlMusic.position);
                // console.log("ControlMusic.position",ControlMusic.position)
                playingViewID.videoID.seek(ControlMusic.position);
            }
        }
        Row {
            spacing: mainQmlApp.width-rectDuraID.width-rectDuraID1.width

            Rectangle {
                id: rectDuraID1
                width: texDurationID1.implicitWidth
                height: texDurationID1.implicitHeight
                color: darkThemeColor

                Text {
                    id: texDurationID1
                    text: durationChange
                    color: "white"
                }
            }

            Rectangle {
                id: rectDuraID
                width: texDurationID.implicitWidth
                height: texDurationID.implicitHeight
                color: darkThemeColor

                Text {
                    id: texDurationID
                    text: playlistViewID.duration
                    color: "white"
                }
            }
        }

    }


    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            if (mainQmlApp.isMusicPlaying) {
                slider.x = (ControlMusic.position / ControlMusic.getDuration()) * recID.width - slider.width / 2;
            }
        }
    }

    Component.onCompleted: {
        timer.start(); // Start the timer when the component is completed
    }

    // // Stop the timer when the component is destroyed
    // Component.onDestruction: {
    //     timer.stop();
    // }
}


