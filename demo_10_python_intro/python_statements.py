# -*- coding: utf-8 -*-
"""
##################################################
#
# GEB 6895: Tools for Business Intelligence
#
# Conditional Statements and Functions in Python
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# September 24, 2019
#
##################################################
"""



##################################################
# Import Modules.
##################################################


import math
import numpy as np


##################################################
# Conditional Statements.
##################################################



#--------------------------------------------------
# if statements
#--------------------------------------------------

age = 17

if age > 17:
   print("can see a rated R movie")
elif age <= 17 and age > 12:
   print("can see a rated PG-13 movie")
else:
   print("can only see rated PG movies")


if 7 < 4:
    print 'not true'


age = 1

if age > 17:
    print("can see a rated R movie")
elif age <= 17 and age > 12:
    print("can see a rated PG-13 movie")

# Else, no action.


# Determine whether a number is odd or even.
def OddOrEven(number):
    if number % 2 == 0:
        print('even')
    else:
        print('odd')



OddOrEven(7)

OddOrEven(100)

# Try this:
OddOrEven(math.pi)
# What's going on?

math.pi % 2

46 % 5


def OddOrEven_2(number):
    if type(number) == int:
        r = number % 2
        if r == 0:
            print('even')
        else:
            print('odd')
    else:
        print('Input number not an int')



OddOrEven_2(math.pi)

OddOrEven_2('math.pi')

#--------------------------------------------------
# for loops
#--------------------------------------------------


words = ['cat', 'window', 'defenestrate']
for w in words:
    print w, len(w)



def SmallerNumbers(list_in, number):
    for i in list_in:
        if i < number:
            print(i)



list_in = [1,5,10,89,102]

list_in[0:2]
list_in[0:8]
list_in[0:100]



SmallerNumbers(list_in, 27)


SmallerNumbers(list_in, -27)



SmallerNumbers(list_in, 10*math.pi)



# Use functions to determine conditions for statements:

7/0
math.e**710

raw_data = [56.2, float('NaN'), 51.7, 55.3, 52.5, float('NaN'), 47.8]
filtered_data = []
for value in raw_data:
    if not math.isnan(value):
        filtered_data.append(value)

filtered_data


#--------------------------------------------------
# while loops
#--------------------------------------------------

i = 5
while i > 0:
  i -= 1
  print('i = %d' % i)
  print("Inside the loop")




i = 5
while i > 0:
  i -= 1
  print('i = %d' % i)
  if i == 3:
      break
  print("Inside the loop")



while True:
  usr_command = input("Enter your command: ")
  if usr_command == "quit":
    break
  else:
    print("You typed " + usr_command)



##################################################
# Experimenting with boolean variables.
##################################################

list_in <= 7

[8,2,3,4,5] < 7


[8,2,3,4,5] < 10


range(5, 10) < range(5, 10)


[1,2,3] < [5,5,5]


[1,6,3] < [5,5,5]
# What's happening here?




# Try a number of conditions.
(1, 2, 3)              < (1, 2, 4)
[1, 2, 3]              < [1, 2, 4]
'ABC' < 'C' < 'Pascal' < 'Python'
'ABC' < 'C' < 'PAscal' < 'Python'
'ABC' < 'C' < 'Pascal' < 'PYthon'

(1, 2, 3, 4)           < (1, 2, 4)
(1, 2)                 < (1, 2, -1)
(1, 2, 3)             == (1.0, 2.0, 3.0)
(1, 2, ('aa', 'ab'))   < (1, 2, ('abc', 'a'), 4)


[1 , 1] < 10
(1 , 1) < 10
(1 , 1) < (10)

[1 , 1] < [10]

[1 , 1] < (10)



# Booleans can be chained:
a = 1
b = 2
c = 2

a < b == c
a < b < c

# the operators and and or has an order of operations,
# with not taking priority and or calculated last.

A = True
B = True
C = True

A and not B or C
(A and (not B)) or C


# Try to break it:
C = float('NAN')

C
2*C

A and not B or C
(A and (not B)) or C


# Consider another set of conditions:
B = False

A and not B or C
(A and (not B)) or C

# The and and or operators are called 'short circuit' operators.
# They stop evaluating once the condition value is determined.




# Try to make it more efficient.
def SmallerNumbers(list_in, number):
    number_vec = np.repeat(number, len(list_in))

    for i in list_in:
        if i < number:
            print(i)



np.repeat(5, 3)



# Using this module:
# import numpy as np

np.repeat(5, 3)


print(list_in)


def CommonElements(list_1, list_2):
    new_list = []
    for i in list_1:
        for k in list_2:
            if i == k: # & (i not in new_list):
                new_list.append(i)
    return new_list

a = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
b = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

CommonElements(a, b)


!(2 == 7)

3 not in [2,3,5]
3 in [2,3,5]



# Maybe it would help to sort the elements first.


for i in reversed(xrange(1,10,2)):
    print i


# Write a simple, working version first,
# then speed it up and test each version.
# "First you get good, then you get fast."




##################################################
# End
##################################################
