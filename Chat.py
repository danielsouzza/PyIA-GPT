import asyncio
from ChatController import ChatController
from Token import TokenOpenAI as Token


class Chat:
   def __init__(self, key, passord):
      self.controller = ChatController(key, passord)
      self.controller.set_header("Daniel")
   
   async def run(self):
      cond = True
      while cond:
         text = self.controller.chat_voz.recognizer_voz().lower()
         if "ok" in text:
            cond = False
         elif text != "":
            print(text)
            message = await self.controller.send_message(text.lower())
            self.controller.chat_voz.play_audio(message)
         else:
            self.controller.chat_voz.play_audio("Não conseguir entender")
         
         
chat = Chat(Token().getToken()["key"], "78275")
asyncio.run(chat.run())
