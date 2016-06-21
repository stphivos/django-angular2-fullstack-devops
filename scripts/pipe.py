#!/usr/bin/env python

from __future__ import print_function

from argparse import ArgumentParser
from json import dumps
from re import sub
from sys import stdin


def tfvars(lines):
    data = []
    for line in lines:
        data.append(sub('= ', '= "', line) + '"')
    return '\n'.join(data) + '\n'


def json(lines):
    data = {}
    for line in lines:
        pair = [x.strip() for x in line.split('=')]
        data[pair[0]] = pair[1]
    return dumps(data, indent=4) + '\n'


def output(data, filename):
    if filename:
        with open(filename, 'w') as f:
            f.write(data)
    else:
        print(data)


def run(options):
    lines = [line.strip() for line in stdin]

    func = {
        'tfvars': lambda: tfvars(lines),
        'json': lambda: json(lines)
    }[options.transform]

    data = func()
    output(data, options.output)


def main():
    parser = ArgumentParser()
    parser.add_argument('transform', help='type of vars transformation', default='tfvars', choices=['tfvars', 'json'])
    parser.add_argument('-o', '--output', help='output file name')

    options = parser.parse_args()
    run(options)


if __name__ == '__main__':
    main()
