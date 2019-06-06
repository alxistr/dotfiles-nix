#!@python3@/bin/python

import subprocess
from os import makedirs
from os.path import expanduser

if __name__ == '__main__':
    output = subprocess.check_output(['mbsync', '-al'])
    output = output.decode('utf-8').splitlines()

    mailboxes = {}
    last = None

    for line in output:
        if not line.endswith(':'):
            mailboxes[last].append(line)
            continue
        last = line.rstrip(':')
        mailboxes[last] = []

    lines = ['mailboxes']
    for key, items in mailboxes.items():
        for item in items:
            lines.append(f'"+{key}/{item}"')

    makedirs(expanduser('~/.neomutt/'), exist_ok=True)
    with open(expanduser('~/.neomutt/mailboxes'), 'w') as output:
        output.write(' '.join(lines))
