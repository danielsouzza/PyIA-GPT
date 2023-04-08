# import openai
# from Token import TokenOpenAI
import gradio as gr
from Shell import Shell
from Gpt import GPT


# openai.api_key = TokenOpenAI.getToken()["key"]
#
# task = ""
# completion = openai.ChatCompletion.create(
#     model="gpt-3.5-turbo",
#     messages=[{"role":"user",
#                "content":"diminua volume pela linha de comando linux em 25%"}]
# )
#
# response = completion["choices"][0]["message"]["content"]
# #print(response)
# pattern = re.compile(r'```\n(.+?)\n```')
# scripts = pattern.findall(response)
#
# if scripts == []:
#     print(response)
# else:
#     Shell.execute(scripts[0])
#

class App:
    def __init__(self):
        self.gpt = GPT()

    def execute(self):
        resut = Shell.execute(self.gpt.scripts)
        print(resut)
        return resut

    def show_scripts(self,):
        comands = ""
        i = 1
        for sc in self.gpt.scripts:
            comands += f'{i} - {sc} \n'

        return comands
    
    def run(self):
        with gr.Blocks() as beta:
            with gr.Row():
                with gr.Column(scale=10):
                    chatbot = gr.Chatbot()
                    text = gr.Textbox(placeholder="Type your message here").style(container=False)
                    text.submit(self.gpt.predict, text, chatbot)
                    text.submit(lambda: "", None, text)
                with gr.Column(scale=2):
                    viewcode = gr.Textbox(label="Scripts")
                    outputcode = gr.Textbox(label="Output")
                    viewcode.submit(self.show_scripts)
                    exec_btn = gr.Button("Executar comandos")
                    exec_btn.click(fn=self.execute, outputs=outputcode)
        beta.launch()


App().run()
