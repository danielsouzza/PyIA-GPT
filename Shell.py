import subprocess
class Shell:
    @staticmethod
    def execute(scripts):
        saida = []
        erro = []
        print(scripts)
        for script in scripts:
            processo =\
                subprocess.Popen(script, shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
            saida.append(processo.communicate()[0])
            erro.append(processo.communicate()[1])

        return {
            "success": saida,
            "erro": erro
        }
