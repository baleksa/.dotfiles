#!/bin/env python3

import fileinput


def main():
    refs = sorted(line.strip() for line in fileinput.input())
    print(*refs, sep="\n")


if __name__ == "__main__":
    main()
