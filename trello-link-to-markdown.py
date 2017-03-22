!/usr/bin/python

import sys, re

selection = """%clipboard"""
# https://trello.com/c/hyegZQRM/2359-incident-4054-2017-02-20t17-37-47z



m = re.search('incident-(\d+)-', selection)
print m.group(0)

# []()

# sys.stdout.write()
