from importlib.resources import path
import os
def fix_digits(d):
    return f'0{d}' if d <= 9 else d
path = "."
names = os.listdir()
names = list(filter(lambda x: x.split(path)[-1] == "jpg", names))
for i in range(len(names)):
    os.rename(names[i], f"{path}/oscilatorio{fix_digits(i + 1)}.jpg")