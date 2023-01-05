#!/bin/env python3
import fileinput
print(*sorted([line.strip() for line in list(fileinput.input())]), sep="\n")
