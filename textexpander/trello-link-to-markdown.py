#!/usr/bin/python
import sys, re
selection = """%clipboard"""
m = re.search('incident-(\d+)-', selection)
output = "- [#"+ m.group(1) + "]("+ selection +")"
# sys.stdout.write(output)
print(output)
