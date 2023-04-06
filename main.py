import openai
import re
from Token import TokenOpenAI
from Shell import Shell


openai.api_key = TokenOpenAI.getToken()["key"]

task = ""
completion = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[{"role":"user",
               "content":"diminua volume pela linha de comando linux em 25%"}]
)

response = completion["choices"][0]["message"]["content"]
#print(response)
pattern = re.compile(r'```\n(.+?)\n```')
scripts = pattern.findall(response)

if scripts == []:
    print(response)
else:
    Shell.execute(scripts[0])
    


