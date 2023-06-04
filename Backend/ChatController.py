import platform
import openai
from ChatVoz import ChatVoz
from CodeController import CodeController
from Callback import Callback
import re


class ChatController:
    def __init__(self, key, password, callback):
        openai.api_key = key
        self.system = self.verify_system()
        self.code_controller = CodeController(password)
        self.chat_voz = ChatVoz()
        self.message_history = []
        self.callback = callback
        
    def update_messages(self, content):
        self.message_history.append({"role": "user", "content": content})
        
    def set_header(self):
        message_init = f"""Assistente Virtual {self.system} - Superusuário

Assistente: Olá! Sou uma assistente virtual especializada em Linux. Como posso ajudar?

Usuário:"""
        self.update_messages(message_init)

    def verify_system(self):
        return platform.system()
    
    def extract_commands(self, content):
        pattern = re.compile(r'[`]{1,3}\n?(.+?)\n?[`]{1,3}')
        scripts = pattern.findall(content)
        self.code_controller.set_corrent_code(scripts)
        
    def send_message(self, message):
        self.update_messages(message)
        completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=self.message_history)
        content = completion.choices[0].message.content
        self.extract_commands(content)
        self.update_messages(content)
        return content
        # self.callback.on_result(content, self.code_controller.corrent_codes)
    
    def get_messages(self):
        return [(self.message_history[i]["content"], self.message_history[i+1]["content"])
                for i in range(2, len(self.message_history)-1, 2)]
        
    