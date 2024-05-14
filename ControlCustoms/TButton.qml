import QtQuick 2.15

Rectangle{
    width: 40
    height: 40
    radius: 10
    color: "transparent"
    property string sourceIC: ""
    signal pressed
    signal released
    signal enter
    signal exit
    Image {
        anchors.fill: parent
        anchors.centerIn: parent
        id: icon
        source: sourceIC
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPressed: parent.pressed()
        onReleased: parent.released()
        onEntered: parent.enter()
        onExited: parent.exit()
    }
}

