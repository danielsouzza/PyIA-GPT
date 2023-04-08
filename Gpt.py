from Token import TokenOpenAI
from Shell import Shell
import openai
import re


class GPT:
    def __init__(self):
        # Salva o historico das mensgem
        self.message_history = [{"role": "user", "content": "Teminal Linux"},
                                {"role": "assistant", "content": "ok"}]
        # Salva os códigos retornados
        self.scripts = []
        # Defini a chave de acesso a API
        openai.api_key = TokenOpenAI().getToken()["key"]

    def hascode(self):
        return self.scripts == []

    def collectcode(self, content):
        pattern = re.compile(r'```\n(.+?)\n```')
        self.scripts = pattern.findall(content)

    def predict(self, input):
        
        # Adiciona um novo prompt no historico
        self.message_history.append({"role": "user", "content": input})
        # Realiza a request
        completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=self.message_history)
        # Pega o conteúdo da mensgem
        content = completion.choices[0].message.content
        self.collectcode(content)
        print(content)
        # Adiciona a resposta retornda pela API no historico
        self.message_history.append({"role": "assistant", "content": content})
        # Cria uma tupla com todos os prompt e predict

        return \
            [(self.message_history[i]["content"],self.message_history[i+1]["content"])
                for i in range(2, len(self.message_history)-1, 2)]
    