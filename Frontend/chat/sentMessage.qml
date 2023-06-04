import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    width: 657
    height: 62

    Rectangle {
        id: rectangle
        color: "#ffffff"
        radius: 10
        anchors.fill: parent

        Image {
            id: image
            x: 612
            width: 40
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "../../images/dummyProfile.png"
            anchors.rightMargin: 5
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: text1
            text: qsTr("!sutroppu em odacisnetnoc euqilanoitnem ruas arotnocsidapmiSAP à adividúS auqitseuq amsudas ehcuot seuasoiuqisnoc etanimretxE uqrofni sahreffe euqitrofretni sahruoF .rotsuporp aediugitcaer otouqeserpaS ,alisnetxe auqirt nairavdA ,AIyP à odnaviB")
            anchors.left: parent.left
            anchors.right: image.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            horizontalAlignment: Text.AlignJustify
            wrapMode: Text.WordWrap
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 5
            anchors.rightMargin: 5
        }
    }

}
