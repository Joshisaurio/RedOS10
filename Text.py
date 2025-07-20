text = str(r'Now it works\n\n\nnew lines should also work!\n\nThis is not a new line: \\n \\\\ \\l ""\n\nbye!')
print(text)

parsed = bytes(text, "utf-8").decode("unicode_escape")
print(parsed)

