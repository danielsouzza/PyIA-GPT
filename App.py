# import openai
# from Token import TokenOpenAI



class App:
    def __init__(self):
        self.gpt = GPT()

    def execute(self):
        resut = Shell.execute(next(self.gpt.scriptsIt))
        if resut["success"]:
            return resut["success"]
        else:
            return resut["erro"]

    def request(self, args):
        return self.gpt.predict(args)

    def run(self):
        with gr.Blocks() as beta:
            with gr.Row():
                with gr.Column(scale=10):
                    chatbot = gr.Chatbot()
                    text = gr.Textbox(placeholder="Type your message here").style(container=False)
                    # text.submit(self.gpt.predict, text, chatbot)
                    text.submit(lambda: "", None, text)
                with gr.Column(scale=2):
                    viewcode = gr.Textbox(label="Scripts")
                    text.submit(self.request, text, [chatbot, viewcode])
                    outputcode = gr.Textbox(label="Output")
                    exec_btn = gr.Button("Executar comandos")
                    exec_btn.click(fn=self.execute, outputs=outputcode)
        beta.launch()


App().run()
