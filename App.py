from Token import TokenOpenAI
from Shell import Shell
import gradio as gr
import openai

class App:
    def __init__(self):
        openai.api_key = TokenOpenAI.getToken()["key"]
        self.message_history = []
        
    def predict(input):
        self.message_history.append({"role":"user","content":input})
        completion = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=message_history)
        content = completion["choices"][0]["message"]["content"]
        self.message_history.append({"role":"assistant","content":content})
        response = [(message_history[i]["content"],message_history[i+1]["content"]) for i in range(0,len(message_history)-1,2)]
        
        return response
    
    def run(self):
        with gr.Block() as beta:
            chatbot = gr.Chatbog()
            with gr.Row():
                text = gr.TextBox(Show_label=False,placeholder="Type your message here").style(container=False)
                text.submit(predict, text, chatbot)
                
        