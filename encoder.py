chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !\"#$%&'()*+,-./0123456789:;<=>?@[\\]^_`{|}~"

class Number:
    length: int
    value: str

    def __init__(self, value: str):
        self.value = value
        self.length = len(value)

def decode(code: str) -> list[str]:
    text = ""
    values = []
    i = 0
    while i < len(code):
        index = int(code[i:i+2])
        if (index == 0):
            values.append(text)
            text = ""
        else:
            text += chars[index-1]
        i += 2
    return values

def encode_text(text) -> str:
    text = str(text)
    code = ""
    for char in text:
        number = chars.find(char)+1
        if (number > 0):
            if (number < 10):
                code += "0"
            code += str(number)
    return code

def encode(values: list) -> str:
    code = ""
    for text in values:
        if isinstance(text, Number):
            code += "99"
            code += encode_text(text.length)
            code += "00"
            code += text.value
        else:
            code += encode_text(text)
            
        code += "00"
    return code
