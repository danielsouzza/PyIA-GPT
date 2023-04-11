import subprocess


class Shell:
    @staticmethod
    def execute(script):
        saida = []
        erro = []
        processo = \
            subprocess.Popen(script, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        saida.append(processo.communicate()[0])
        erro.append(processo.communicate()[1])

        return {
            "success": saida[0],
            "erro": erro[0]
        }
