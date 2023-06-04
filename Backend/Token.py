class TokenOpenAI:
    def getToken(self):
        return {
             "key": open("Backend/key.txt", 'r').read().strip("\n")
        }

