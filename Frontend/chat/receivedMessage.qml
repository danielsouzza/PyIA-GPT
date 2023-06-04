import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 657
    height: 62

    Rectangle {
        id: receivedMessage
        color: "#ffffff"
        radius: 10
        anchors.fill: parent

        Image {
            id: image
            width: 49
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "../../images/pyiaprofilePic.png"
            anchors.leftMargin: 5
            anchors.bottomMargin: 5
            anchors.topMargin: 5
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text1
            text: qsTr("Bem-vindo(a) à PyIA, sua assistente virtual pronta para ajudar com todas as suas dúvidas e necessidades relacionadas ao seu computador! Estou aqui para oferecer suporte e tornar sua experiência o mais tranquila possível. Vamos começar a explorar juntos!")
            anchors.left: image.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            anchors.rightMargin: 5
            anchors.bottomMargin: 0
            anchors.leftMargin: 5
            anchors.topMargin: 0
        }
    }

}
