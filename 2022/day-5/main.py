# # PART 1

import re

class Stacks:
    # parse the stacks & crates
    def __init__(self, crates):
        # create the stacks based on the last number of data
        self.crates = {}

        for i in range(int(crates[-2])):
            self.crates[i+1] = []

        # divide the crates by new line, remove the stack numbers & iterate throw it
        for i in crates.split('\n')[:-1]:
            # seprate each crate by four characters
            for index, k in enumerate(map(lambda j: i[j:j + 4], range(0, len(i), 4))):
                # check if the stack is not empty
                if k[1] != ' ':
                    # add to the corresponding stack based on the index
                    self.crates[index+1].append(k[1])

        # reverse each stack, for easier manipulation
        for index, i in enumerate(self.crates.values()):
            self.crates[index+1].reverse()

    # move n amount of crates from a stack to another one
    def move(self, inst):
        # first parse the instruction & turn them to numbers
        amout, _from, to = map(lambda i: int(i), re.findall('\d\d|\d', inst))

        # add crates to recieving stack
        self.crates[to] = self.crates[to] + list(reversed(self.crates[_from][-amout:]))
        
        # remove crates from sending stack
        self.crates[_from] = self.crates[_from][:-amout]
    
# # PART 2

    # move n amount of crates from a stack to another one
    # this time, just don't reverse them
    def new_move(self, inst):
        # first parse the instruction & turn them to numbers
        amout, _from, to = map(lambda i: int(i), re.findall('\d\d|\d', inst))

        # add crates to recieving stack
        self.crates[to] = self.crates[to] + self.crates[_from][-amout:]
        
        # remove crates from sending stack
        self.crates[_from] = self.crates[_from][:-amout]

# load the stacks
from input import data
seprated = data.split('\n\n')
stacks_1 = Stacks(seprated[0])
stacks_2 = Stacks(seprated[0])

# loop threw instructions, by a new line & do them
for i in seprated[1].split('\n'): stacks_1.move(i)
for i in seprated[1].split('\n'): stacks_2.new_move(i)

# print the stacks & the last crate of each stack
from pprint import PrettyPrinter
print('Stacks & instructions =', end='')
PrettyPrinter().pprint(stacks_1.crates)
print(seprated[1])

print('Modified stacks by Crate-Mover 9000 = ', end='')
for i in stacks_1.crates.values():
    print(i[-1], end='')
print()

print('Modified stacks by Crate-Mover 9001 = ', end='')
for i in stacks_2.crates.values():
    print(i[-1], end='')
print()
