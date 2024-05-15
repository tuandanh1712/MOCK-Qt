import QtQuick 2.15
import QtQuick.Layouts 1.3


Rectangle {
    id: navBarID
    height:50
    width: 50
    color: colorMediaScreen
    Text {
        id:iconNavID
        font.family: rootID.fontAwesomeFontLoader.name
        font.pixelSize: 30
        text: "\uf03a"
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

