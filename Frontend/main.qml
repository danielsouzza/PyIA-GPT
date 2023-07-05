import QtQuick
import QtQuick.Window
import QtQuick.Controls
import "chat"
import "resource"

Window {
    id: mainWindow
    width: 1000
    height: 580
    visible: true
    color: "#ffffff"
    title: "PyIA"

    // flags: Qt.Window | Qt.FramelessWindowHint

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
                color: "#fff"
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
                    text: qsTr("Bárbara")
                    anchors.right: profilePic.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    font.pixelSize: 20
                    font.weight: Font.Bold
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
                radius: 40
                border.color: "#7E7E7E"
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
                        width: 650
                        height: if (hasScript){
                            Math.max(50, messageText.height + 15 + 60)
                        }else{
                            Math.max(50, messageText.height + 15)
                        }
                        anchors.right: isUserMessage ? parent.right : undefined
                        anchors.left: isUserMessage ? undefined : parent.left

                        Rectangle {
                            width: 650
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            border.color: "#7E7E7E"
                            radius: 30

                            Image {
                                id: image
                                width: 40
                                height: 40
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
                                // anchors.verticalCenter: parent.verticalCenter
                                anchors.top: parent.top
                                anchors.rightMargin: 10
                                anchors.leftMargin: 10
                                anchors.topMargin: 17.5
                               
                            }
                            RunBtn{
                                id: btnRun
                                anchors.topMargin:10
                                visible: hasScript
                                anchors.leftMargin: 50
                                anchors.left: parent.left
                                anchors.top: messageText.bottom
                        
                                onClicked: {
                                    backend.executar()
                                }
                            }
                        }
                        
                    }

                    Component.onCompleted: {
                        
                        listView.positionViewAtIndex(listView.count - 1, ListView.End)
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
                // color: "#e9e9e9"
                border.color: "#7E7E7E"
                radius: 50
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                anchors.bottomMargin: 20



                TextArea {
                    id: inputQuestionInput
                    anchors.left: parent.left
                    anchors.right: btnSend.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignJustify
                    verticalAlignment: Text.AlignVCenter
                    wrapMode: Text.WordWrap
                    font.pointSize: 11
                    anchors.rightMargin: 5
                    anchors.bottomMargin: 15
                    anchors.topMargin: 15
                    anchors.leftMargin: 15
                    color: "black"
                    placeholderText: qsTr("Qual a sua dúvida?")
                    implicitHeight: contentHeight 
                    onTextChanged: {
                        implicitHeight = contentHeight
                    }
                }


                CustomBtn{
                    id: btnSend
                    anchors.top: inputQuestionInput.top
                    anchors.bottom: inputQuestionInput.bottom
                    anchors.right: btnVoice.left
                    anchors.rightMargin: 15
                    btnIcon: "../assets/SendBtn.svg"
                    
                    onClicked: {
                        myListModel.append({
                                               userPictureSource: "images/dummyProfile.png",
                                               messageString: inputQuestionInput.text,
                                               isUserMessage: true,
                                               hasScript: false
                                              
                                            
                                            
                                           })
                        backend.getUserInput(inputQuestionInput.text)
                        inputQuestionInput.text = ""
                        listView.positionViewAtEnd()
                    }
                }

                CustomBtn{
                    id: btnVoice
                    anchors.top: inputQuestionInput.top
                    anchors.bottom: inputQuestionInput.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: 15
                    btnIcon: "../assets/icon _microphone.svg"

                    onClicked: {
                        backend.onModeVoice()
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
        function onChatResponse(message, hasScr){
            myListModel.append({
                userPictureSource: "images/pyiaprofilePic.png",
                messageString: message,
                isUserMessage: false,
                hasScript: hasScr
                                   
            })
            listView.positionViewAtEnd()
         }
        function onUserResponse(message){
            myListModel.append({
                userPictureSource: "images/dummyProfile.png",
                messageString: message,
                isUserMessage: true,
                hasScript: false
                
            })
            listView.positionViewAtEnd()
         }
    }
}
