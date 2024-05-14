import QtQuick 2.15
import QtQuick.Layouts 1.3


Rectangle {
    id: navBarID
    height:20
    width: 30
    color: colorMediaScreen
    AppIcon
    {
        id:iconNavID
        icon: "\uf03a"
        color: "black"
        size: 30
    }

    MouseArea
    {
        anchors.fill: parent
        onClicked: {
            console.log("navbar")
            menuScreenID.visible=!menuScreenID.visible
        }
    }
}

