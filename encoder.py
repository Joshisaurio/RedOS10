from unidecode import unidecode
import demoji

CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !\"#$%&'()*+,-./0123456789:;<=>?@[\\]^_`{|}~"

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
        elif index > len(CHARS):
            text += "?"
        else:
            text += CHARS[index-1]
        i += 2
    return values

def encode_text(text: str) -> str:
    code = ""
    for char in str(text):
        number = CHARS.find(char)+1
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

def encode_one_time_pad(text, one_time_pad: str):
    code = ""
    i = 0
    if isinstance(text, Number):
        code = ""
        for digit in text.value:
            code += str((int(digit) + CHARS.find(one_time_pad[i]))%10)
            i = (i + 1) % len(one_time_pad)
        return Number(code)
    text = unidecode(demoji.replace(str(text)))
    for char in text:
        code += CHARS[(CHARS.find(char) + CHARS.find(one_time_pad[i]))%len(CHARS)]
        i = (i + 1) % len(one_time_pad)
    return code
