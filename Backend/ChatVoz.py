import speech_recognition as sr
from gtts import gTTS
import os


class ChatVoz:
    def __init__(self):
        self.recognizer = sr.Recognizer()
        
    def recognizer_voz(self):
        with sr.Microphone() as source:
            print("Fale algo:")
            self.recognizer.adjust_for_ambient_noise(source)
            audio = self.recognizer.listen(source)
            try:
                text = self.recognizer.recognize_google(audio, language='pt-BR')
                return text
            except sr.UnknownValueError or sr.RequestError :
                return ""

    def play_audio(self, text):
        try:
            tts = gTTS(text=text, lang='pt-br', slow=False)
            tts.save("output.mp3")
            os.system("mpg321 output.mp3")
        except AssertionError as e:
            print(e)
            return 
