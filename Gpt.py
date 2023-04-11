from Token import TokenOpenAI
from Shell import Shell
import openai
import re


class GPT:
    def __init__(self):
        # Salva o historico das mensgem
        self.message_history = [{"role": "user", "content": "Comandos para serem execultados no Teminal Linux"},
                                {"role": "assistant", "content": "ok"}]
        # Salva os códigos retornados
        self.scripts = []
        self.scriptsIt = iter([])
        # Defini a chave de acesso a API
        openai.api_key = TokenOpenAI().getToken()["key"]

    def hascode(self):
        return self.scripts == []

    def collectcode(self, content):
        pattern = re.compile(r'```\n(.+?)\n```')
        self.scripts = pattern.findall(content)

    def show_scripts(self):
        comands = ""
        i = 1
        for sc in self.scripts:
            comands += f'{i} - {sc} \n'
            i += 1

        print(comands)
        return comands

    def predict(self, message):
        # Adiciona um novo prompt no historico
        self.message_history.append({"role": "user", "content": message})
        # Realiza a request
        completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=self.message_history)
        # Pega o conteúdo da mensgem
        content = completion.choices[0].message.content
        self.collectcode(content)
        self.scriptsIt = iter(self.scripts)
        print(content)
        # Adiciona a resposta retornda pela API no historico
        self.message_history.append({"role": "assistant", "content": content})
        # Cria uma tupla com todos os prompt e predict

        return \
            [(self.message_history[i]["content"], self.message_history[i+1]["content"])
                for i in range(2, len(self.message_history)-1, 2)], self.show_scripts()
    