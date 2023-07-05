# This Python file uses the following encoding: utf-8

import sys
import threading
sys.path.append ("/home/dls/Repositories/PyIA-GPT/Backend")
from PySide6.QtCore import QObject, Slot, Signal
from ChatController import ChatController
from Token import TokenOpenAI as Token
from Callback import Callback


class Chat(Callback):
    def __init__(self, key, passord,nameChat, view):
        self.commands = ["amixer -D pulse sset Master *", "sudo apt update", "sudo apt upgrade", "libera memoria"]
        self.nameChat = nameChat
        self.voiceMod = False
        self.chatMode = False
        self.view = view
        self.controller = ChatController(key, passord, self)
        self.controller.set_header()
        

    def on_result(self, message, hasScripts):
        message = message.replace("```", "")
        print(message)
        print(self.controller.code_controller.corrent_codes)
        self.view.onChatResponse(message, hasScripts)
        if self.voiceMod:
            self.controller.chat_voz.play_audio(message)
            if hasScripts:
                self.executeScript()
            

    def executeScript(self):
        self.controller.chat_voz.play_audio("Deseja executar o primeiro comando?")
        time = 0
        while True:
            response = self.controller.chat_voz.recognizer_voz().lower()
            if "sim" in response:
                self.controller.chat_voz.play_audio("Um momento")
                result = self.controller.code_controller.exec_justOneCode()
                print(result.stdout)
                if result and result.stderr == "":
                    self.controller.chat_voz.play_audio("Pronto")
                    

                
                break
            elif time > 2 or "não" in response:
                break
            elif response == "":
                self.controller.chat_voz.play_audio("Você deseja executar o primeiro comando?")

            time +=1 

    def idleMode(self):
        while True:
            activation = self.controller.chat_voz.recognizer_voz().lower()
            print(activation)
            if activation != "" and self.nameChat in activation:
                self.voiceMod = True
                self.controller.chat_voz.play_audio("Olá, estou ouvindo")
                self.run_chat_voz()
            

    def run_chat_voz(self):
        count = 0
        while True:
            comand = self.controller.chat_voz.recognizer_voz().lower()
            print(comand)
            if comand == "":
                count += 1
            elif "mode chat" in comand:
                self.chatMode = True
            else:
                if "dispensar" in comand:
                    self.controller.chat_voz.play_audio("Ok, até logo")
                    self.voiceMod = True
                    break
                count = 0
                self.view.onUserResponse(comand)

            if count == 2:
                self.controller.chat_voz.play_audio("Vocẽ falou alguma coisa?")
            elif count > 4:
                self.controller.chat_voz.play_audio("Acho que você não está mais ai")
                break

    def run_chat_text(self,message):
        self.controller.send_message(message.lower())



class MainWindow(QObject):
    chatResponse = Signal(str, bool)
    userResponse = Signal(str)
    outPutCode = Signal(str)

    def __init__(self):
        self.Chat = Chat(Token().getToken()["key"], "78275", "paia",self)
        threading.Thread(target=self.Chat.idleMode).start()
        QObject.__init__(self)

    def onChatResponse(self,content, hasScript):
        print(f"Tem scripts: {hasScript}")
        self.chatResponse.emit(content,hasScript)
    
    def requestChatResponse(self, content):
        threading.Thread(target=self.Chat.run_chat_text, args=(content,)).start()

    @Slot(str)
    def getUserInput(self, content):
        self.requestChatResponse(content)
    

    @Slot()
    def onUserResponse(self,content):
        self.userResponse.emit(content)
        self.Chat.run_chat_text(content)

       
    @Slot()
    def executar(self):
        self.Chat.controller.code_controller.exec_justOneCode()
    