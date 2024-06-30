#!/bin/python
import os, argparse, sys, pathlib
parser = argparse.ArgumentParser("Patcher")
parser.add_argument("file", help="filename of file to apply patches to.", type=pathlib.Path)
args = parser.parse_args()

with args.file.open('r+') as file:
    filedata = file.read()
    search_term = os.environ["PRE"]
    replacement = os.environ["POST"]
    if (filedata.find(search_term) == -1):
        print("ERROR: couldn't find PRE!")
        print("missing piece:")
        print(search_term)
        sys.exit(1)
    else:
        filedata = filedata.replace(search_term, replacement, 1)
        file.seek(0)
        file.write(filedata)
        file.truncate()
        sys.exit(0)