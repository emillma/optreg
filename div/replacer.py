import re


def format_text(text):
    text = re.sub(r'^( *)[\d>]+ ', r'\g<1>', text, flags=re.MULTILINE)
    text = re.sub(r'(?<![ \d]) (?![ \d])', '', text, flags=re.MULTILINE)
    text = re.sub(r'=', ' = ', text, flags=re.MULTILINE)
    text = re.sub(r',', ', ', text, flags=re.MULTILINE)
    text = re.sub('∗', ' * ', text, flags=re.MULTILINE)
    text = re.sub('−', '-', text, flags=re.MULTILINE)
    text = re.sub('ˆ', '^', text, flags=re.MULTILINE)
    text = re.sub('’', "'", text, flags=re.MULTILINE)
    return text


def format_file(filename):
    with open(filename, 'r', encoding="utf-8") as file:
        text = format_text(file.read())
        print(text.format('ascii'))
    with open(filename, 'w', encoding="utf-8") as file:
        file.write(text)
