import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "chat"

Window {
    id: mainWindow
    width: 1000
    height: 580
    visible: true
    color: "#ffffff"
    title: "PyIA"

    Rectangle {
        id: bg
        color: "#ffffff"
        radius: 20
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: appContainer
            color: "#ffffff"
            anchors.fill: parent
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Rectangle {
                id: topBar
                height: 60
                color: "#e9e9e9"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                z: 1
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.topMargin: 20

                Image {
                    id: pyiaLogoPic
                    width: 168
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "images/pyiaLogo.png"
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 1
                    anchors.topMargin: 1
                    fillMode: Image.PreserveAspectFit
                }

                Image {
                    id: profilePic
                    x: 760
                    width: 64
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: "images/dummyProfile.png"
                    anchors.topMargin: 5
                    anchors.bottomMargin: 5
                    anchors.rightMargin: 5
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    id: profileNameLabel
                    x: 710
                    text: qsTr("dummyNameText")
                    anchors.right: profilePic.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.rightMargin: 10
                }
            }


            Rectangle {
                id: rectangle1
                color: "#ffffff"
                anchors.left: topBar.left
                anchors.right: topBar.right
                anchors.top: topBar.bottom
                anchors.bottom: rectangle.top
                z: 3
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
            }

            Rectangle {
                id: rectangle
                color: "#c5ffffff"
                radius: 10
                border.color: "#e9e9e9"
                border.width: 3
                anchors.left: topBar.left
                anchors.right: topBar.right
                anchors.top: topBar.bottom
                anchors.bottom: inputContainer.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 10
                anchors.topMargin: 10
            }

            ScrollView {
                id: chatContainer
                anchors.left: topBar.left
                anchors.right: topBar.right
                anchors.top: topBar.bottom
                anchors.bottom: inputContainer.top
                focus: false
                spacing: 0
                wheelEnabled: true
                focusPolicy: Qt.NoFocus
                contentHeight: 500
                anchors.rightMargin: 10
                anchors.leftMargin: 15
                anchors.bottomMargin: 20
                anchors.topMargin: 25
                ScrollBar.vertical: ScrollBar {
                    visible: false
                }
                ScrollBar.horizontal: ScrollBar {
                    visible: false
                }

                ListView {
                    id: listView
                    anchors.fill: parent
                    spacing: 10
                    model: ListModel {

                        id: myListModel


                    }
                    delegate: Item {
                        x: 5
                        width: 657
                        height: 100
                        anchors.right: isUserMessage ? parent.right : undefined
                        anchors.left: isUserMessage ? undefined : parent.left

                        Rectangle {
                            width: 657
                            height: heigt_box
                            anchors.top: parent.top
                            color: "#e9e9e9"
                            radius: 10


                            Image {
                                id: image
                                width: 49
                                anchors.left: isUserMessage ? undefined : parent.left
                                anchors.right: isUserMessage ? parent.right : undefined
                                anchors.top: parent.top
                                //anchors.bottom: parent.bottom
                                source: userPictureSource
                                anchors.leftMargin: isUserMessage ? undefined : 5
                                anchors.rightMargin: isUserMessage ? 5 : undefined
                                anchors.bottomMargin: 5
                                anchors.topMargin: 5
                                fillMode: Image.PreserveAspectFit
                            }

                            Text {
                                id: messageText
                                anchors.left: isUserMessage ? parent.left : image.right
                                anchors.right: isUserMessage ? image.left : parent.right
                                horizontalAlignment: Text.AlignJustify
                                wrapMode: Text.WordWrap
                                text: messageString
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.rightMargin: 10
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 10
                                anchors.topMargin: 0
                            }
                        }

                    }
                }



            }
            Rectangle {
                id: rectangle2
                color: "#ffffff"
                anchors.left: inputContainer.left
                anchors.right: inputContainer.right
                anchors.top: rectangle.bottom
                anchors.bottom: inputContainer.top
                z: 3
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
            }

            Rectangle {
                id: inputContainer
                y: 384
                height: 86
                color: "#e9e9e9"
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.bottomMargin: 20

                TextArea {
                    id: inputQuestionInput
                    anchors.left: parent.left
                    anchors.right: sendButton.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignJustify
                    wrapMode: Text.WordWrap
                    font.pointSize: 11
                    anchors.rightMargin: 5
                    anchors.bottomMargin: 15
                    anchors.topMargin: 15
                    anchors.leftMargin: 15
                    placeholderText: qsTr("Qual a sua duvida?")

                }

                Button {
                    id: sendButton
                    x: -43
                    y: 25
                    width: 55
                    text: qsTr("dummyButton")
                    anchors.right: parent.right
                    anchors.top: inputQuestionInput.top
                    anchors.bottom: inputQuestionInput.bottom
                    anchors.rightMargin: 15
                    icon.color: "#00000000"
                    display: AbstractButton.IconOnly
                    icon.source: "images/sendButtonPic.png"
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    onClicked: {
                        myListModel.append({
                                               userPictureSource: "images/dummyProfile.png",
                                               messageString: inputQuestionInput.text,
                                               isUserMessage: true,
                                               heigt_box: 100
                                           })
                        backend.getInput(inputQuestionInput.text)
                        inputQuestionInput.text = ""
                        listView.positionViewAtEnd()
                    }
                }


            }

            Rectangle {
                id: rectangle3
                color: "#ffffff"
                anchors.left: topBar.left
                anchors.right: topBar.right
                anchors.top: parent.top
                anchors.bottom: topBar.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
            }



        }
    }
    Connections{
        target: backend
        function onLastResponse(message, heigt){
            myListModel.append({
                                   userPictureSource: "images/pyiaprofilePic.png",
                                   messageString: message,
                                   isUserMessage: false,
                                   heigt_box: height
                               })
            listView.positionViewAtEnd()
         }
    }
}
