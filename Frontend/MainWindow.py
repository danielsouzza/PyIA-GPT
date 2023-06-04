# This Python file uses the following encoding: utf-8

import sys
sys.path.append ("/home/dls/Repositories/PyIA-GPT/Backend")
from PySide6.QtCore import QObject, Slot, Signal
from ChatController import ChatController
from Token import TokenOpenAI as Token
from Callback import Callback


class Chat(Callback):
    def __init__(self, key, passord):
        self.controller = ChatController(key, passord, self)
        self.controller.set_header()
        

    def on_result(self, message, scripts):
        print(message)
        print(scripts)
        self.lastResponse = message

    def run_chat_voz(self):
        cond = True
        while cond:
            text = self.controller.chat_voz.recognizer_voz().lower()
            if "ok" in text:
                cond = False
            elif text != "":
                print(text)
                self.controller.send_message(text.lower())

            else:
                self.controller.chat_voz.play_audio("Não conseguir entender")

    def run_chat_text(self,message):
        return self.controller.send_message(message.lower())



class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)
        self.Chat = Chat(Token().getToken()["key"], "78275")

    lastResponse = Signal(str,float)

    @Slot(str)
    def getInput(self, message):
        content = self.Chat.run_chat_text(message)
        self.lastResponse.emit(content,self.calculatSize(content))

    def calculatSize(self,message):
        return 0,314 * len(message) + 20