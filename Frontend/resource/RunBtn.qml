import QtQuick 
// import QtGraphicalEffects
import QtQuick.Controls

Button {
    id: customBtn

    // Icons
    property url btnIcon: "Frontend/assets/icon _microphone.svg"

    // colors
    property color colorText1: "white"
    property color colorText2: "black"
    property color colorDefault: "#69066B"
    property color colorMouseOver: "#9D699E"
    property color colorPressed: "#BB9EDF"

    QtObject {
        id: internal

        property var dynamicColor: if (customBtn.down) {
            customBtn.down ? colorPressed : colorDefault
        } else {
            customBtn.hovered ? colorMouseOver : colorDefault
        }
        
    }
    text: qsTr("Executar comandos")
    width: 150
    height: 40

    background: Rectangle {
        width: 150
        height: 40
        radius: 100
        color: internal.dynamicColor

        Image {
            source: btnIcon
            width: 16
            height: 15
            anchors.left: parent.left
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
    }

    contentItem: Item{
        id: item1
        Text{
            id:textbtn
            text: customBtn.text
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: colorText1
        }
    }
}