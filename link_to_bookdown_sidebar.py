import fileinput
import glob
import os
import sys

filenames = glob.glob('*.html')

# Confirm that the user wants to process the files:
print("\n\n\n\n\n\nThis is a python app that adds a language link to the sidebar of all the HTML files in your working folder.")
print("\nYour working folder is:")
print(os.getcwd())
print("\nThe following HTML files will be immediately processed:", filenames)
confirming = input('\nDo you want to continue? Press "y" or "Y" to continue or press any other key to cancel\n')

if confirming == "y" or confirming == "Y":
    print("Processing.")
    pass
else:
    print("Process canceled.")
    sys.exit()

# One line of code (that creates the language link) will be added after the following line in the HTML file(s):
old = '<ul class="summary">'

# The line that will be added to the HTML file(s):
new = '<li> <a href="https://vldesign.kapsi.fi/r-guide-in-english/"><i class="fa fa-language fa-fw"></i> English version<span></span></a></li>'

# Add the new line to all the HTML files in the working folder with the following loop:
for f in filenames:
    for line in fileinput.FileInput(files=f, inplace=True):
        if old in line:
            line += new + os.linesep
        print(line, end="")
