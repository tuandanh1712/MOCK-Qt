import QtQuick 2.0

Text {
    property real size
    property string icon

    font.family: mainQmlApp.fontAwesomeFontLoader.name
    font.pixelSize: size
    text: icon
}
