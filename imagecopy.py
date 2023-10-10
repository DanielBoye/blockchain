import pyperclip
import re

while True: 
    input_str = input("Link: ")

    match = re.search(r'\bhttps?://\S+\b', input_str)   
    
    if match:
        link = match.group()
        width = int(input("Width: "))

        done = f'<img src="{link}" width="{width}">'

        pyperclip.copy(done)
        print(done, "\n")
    else:
        print("No valid URL found in the input.")
