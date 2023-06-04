
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
      print(self.controller.message_history)
      # self.controller.chat_voz.play_audio(message)


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

   def run_chat_text(self):
      cond = True
      while(cond):
         message = input("Usuário => ")
         if message == "0": 
            cond = False
         else:
            self.controller.send_message(message.lower())

         
         
chat = Chat(Token().getToken()["key"], "78275")
chat.run_chat_text()
