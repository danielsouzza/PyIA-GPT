import QtQuick 
// import QtGraphicalEffects
import QtQuick.Controls

Button {
    id: customBtn

    // Icons
    property url btnIcon: "../assets/icon_microphone.svg"

    // colors
    property color colorDefault: "#fff"
    property color colorMouseOver: "#CACACA"
    property color colorPressed: "#BB9EDF"

    QtObject {
        id: internal

        property var dynamicColor: if (customBtn.down) {
            customBtn.down ? colorPressed : colorDefault
        } else {
            customBtn.hovered ? colorMouseOver : colorDefault
        }
    }

    width: 55
    height: 55

    background: Rectangle {
        width: 55
        height: 55
        border.color: "#7E7E7E"
        radius: 50
        color: internal.dynamicColor

        Image {
            source: btnIcon
            width: 16
            height: 15
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }

        // layer.enabled: true
        // layer.effect: DropShadow {
        //     color: "#000000"
        //     radius: 5
        //     samples: 10
        //     source: parent
        // }
    }
}
