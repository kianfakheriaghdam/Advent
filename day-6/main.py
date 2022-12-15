# # PART 1

# checks if a string contains duplicate characters
is_duplicate = lambda x: (
    # remove duplicates & check if it matches the full string
    # also sorts it, due to sets being un-ordered
    sorted(''.join(set(x))) == sorted(x)
)

# wanted to do this recursively, but python doesn't have lazy evalution
# gets the index of the first marker
def get_marker(x, n):
    # an accumulator for storing four characters, starts with the first n characters
    accumulator = list(x)[:n]

    # loop threw buffer characters
    for index, i in enumerate(x[n:]):
        # check if there are no duplicate characters, aka there's a marker
        # we need to off-set it with n characters
        if is_duplicate(accumulator): return index+n

        # add the character to accumulator & remove the last one
        accumulator = accumulator[1:] + [i]
    
    # we don't need to return anything on fail, due to the output always containing a number

# # PART 2
# made the part 1 function better

from input import data
print('Signal Buffer =', data)

print('The first packet marker index =', get_marker(data, 4))
print('The first message marker index =', get_marker(data, 14))
