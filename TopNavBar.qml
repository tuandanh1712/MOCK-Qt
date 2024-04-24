import QtQuick 2.15
import QtQuick.Layouts 1.3


Item {
    id: root
    height: mainQmlApp.height*0.06
    Layout.fillWidth: true

    Item{
        height: root.height; width: iconNavID.implicitWidth
        anchors.right: parent.right
        // anchors.verticalCenter: parent.verticalCenter

        AppIcon
        {
            id:iconNavID

            // anchors.centerIn: parent
            icon: "\uf03a"
            color: "white"
            size: 30
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: {
                // console.log("icon")
                if(diaLoglistViewID.visible){
                    diaLoglistViewID.visible=false
                    playingViewID.opacity=1
                }
                else{
                    diaLoglistViewID.visible=true
                    playingViewID.opacity=0.1
                }

            }
        }
    }

}
