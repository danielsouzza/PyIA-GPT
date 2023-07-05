from CodeController import CodeController

controller = CodeController("78275")
controller.set_corrent_code(["sudo apt install postgresql postgresql-contrib -y"])

output = controller.exec_justOneCode()

print(output.stderr)

