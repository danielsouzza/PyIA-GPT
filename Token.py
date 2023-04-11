class TokenOpenAI:
    def getToken(self):
        return {
             "key": open("key.txt", 'r').read().strip("\n")
        }

