import os

path = os.path.dirname(os.path.realpath(__file__))
names = os.listdir(path)

apps_list = ""

for name in names:
    if not name.endswith(".app"): continue
    with open(os.path.join(path,name), "r") as file:
        text = file.read()
        text = text.replace("\n", "\\n")
    
    if len(apps_list) > 0:
        apps_list += "\n"
    apps_list += f"{name[:-4]}\n{text}"

with open(os.path.join(path,"apps.preinstalled.txt"), "w") as file:
    file.write(apps_list)
