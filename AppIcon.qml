import QtQuick 2.0

Text {
    property real size
    property string icon

    font.family: rootID.fontAwesomeFontLoader.name
    font.pixelSize: size
    text: icon
}
