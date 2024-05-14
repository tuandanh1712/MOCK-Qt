import QtQuick 2.15
Rectangle{
    id:sliderBarID
    width: rootID.width-350
    height: 7
    radius: 23
    border.width: 1
    border.color: "#F4A460"
    color:"#3b5998"
    property alias  position: handleID.x
    property real ranger:sliderBarID.width - handleID.width
    property real positionMouse
    signal clicked()
    signal dragged()

    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("mouseX",mouseX)
            positionMouse=mouseX
            console.log("sliderBarID.width - handleID.width",sliderBarID.width - handleID.width)
            sliderBarID.clicked()
        }
    }
    Rectangle{
        id:handleID
        width: 20
        height: 20
        radius: 20
        color: "#3b5998"
        border.width: 5
        border.color: "#ffffff"
        z:1

        anchors.verticalCenter: sliderBarID.verticalCenter
        MouseArea{
            id:mouseArea1
            anchors.fill: parent
            drag.target: handleID
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: sliderBarID.width - handleID.width
            onPositionChanged: {
                console.log(": handleID.x", handleID.x)
                dragged()

            }
            onPressed: {
                handleID.scale=1.15
            }
            onReleased: {
                handleID.scale=1

            }

        }
    }
    Rectangle{
        width: sliderBarID.width-(sliderBarID.width-position-handleID.width/2)
        height:10
        radius: 20
        color: "green"
        anchors.verticalCenter: sliderBarID.verticalCenter
    }

}



