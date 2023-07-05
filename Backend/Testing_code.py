from CodeController import CodeController

controller = CodeController("78275")
controller.set_corrent_code(["sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches"])

output = controller.exec_justOneCode()

print(output.stderr)