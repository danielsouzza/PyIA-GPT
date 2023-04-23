import subprocess


class CodeController:
    def __init__(self, password):
        self.iter_code = iter([])
        self.codes = []
        self.corrent_codes = []
        self.password = password
        
    def set_corrent_code(self, codes):
        self.codes += self.corrent_codes
        self.corrent_codes = codes
        self.iter_code = iter(codes)
        
    def exec_code(self, code):
        if "sudo" in code:
            code = f'echo "{self.password}" | sudo -S {code.replace("sudo","",1)} -y'
        
        result = subprocess.run(code, shell=True, capture_output=True, text=True)
        
        return result.stdout
    
    def get_next_code(self):
        try:
            return next(self.iter_code)
        except StopIteration:
            return None
    
    def exec_all_codes(self):
        output = []
        for code in self.iter_code:
            output.append(self.exec_code(code))
        return output
    