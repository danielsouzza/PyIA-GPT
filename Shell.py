import subprocess
from getpass import getpass

class Shell:
    def execute(comando):
        processo =\
            subprocess.Popen(comando,shell=True, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        saida, erro = processo.communicate()
        print(saida)
        print(erro)