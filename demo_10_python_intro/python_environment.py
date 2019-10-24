# -*- coding: utf-8 -*-
"""
##################################################
#
# GEB 6895: Tools for Business Intelligence
#
# Introduction to the Python Environment
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


'''
This is a comment.
Be a good citizen and inform your users.
'''

# This is another comment.


##################################################
# The python environment
##################################################

# Start from the basics

2+2

x = 2

x**2



x = 3

x = 'string'

print x

print X



x[2]

x[0]

x[-3]
x[-1]



x[2] = 'x'



x = x[0:2] + 'x' + x[3:7]
print x



x[3:20]



x = 3


y = x


x**2


y**2



x = 4

x**2


y**2



# Logical variables

boolean_ind = x == 5



other_boolean_ind = x != 5

yet_another_boolean_ind = not x == 5


z = 3/5

type(x)

type(z)

z

type(3)

type(3.0)


type(2) == int


z2 = 3.0/5

type(z2)



# Arrays

a = [[1, 2, 3], [4, 5, 6]]
# a = [[1, 2, 3], [4, 5, 'a']]

print a

print(a[0])
print(a[1])
print(a[0][1])
print(a[1][2])


a[1][2] = float('nan')

10 in a

10 in [10, 3, 5]

6 in a


[1,2,3] in a

6 in a[1]


# Modular arithmetic

3 % 5

7 % 5

207 % 50



##################################################
# Using modules.
##################################################


import math

math.e


math.pi




math.log(math.e)

math.e(math.log(0))


math.e**math.log(7)


must_be_true = math.e**math.log(7) == 7



must_be_true = (math.e**math.log(7) - 7) < 0.0000001


# You can choose your own abbreviations for modules

import math as m1

m1.e


m1.e == math.e



# Some packages are a mouthful.

import super_long_package_name as s

s.function(whatever)

# There is such a thing as being too concise.

# But there is also such a thing as being too verbose.

import math as super_long_package_name

super_long_package_name.e


import math as x

x.e

# Try to make your abbreviations informative.

# Some modules have standard abbreviations; go with convention.

import numpy as np

import pandas as pd

# ... and for a real script (not a demo) declare your modules
# at the top of the script.




# Working with strings


greeting = 'Hello World'


print greeting


type(greeting)


australian_greeting = greeting.replace('Hello', 'Gday')

print australian_greeting


# Special characters and escape sequences.


'g'day'


"G'day"

'He said:"Gday"'

'g\'day'


australian_greeting = greeting.replace('Hello', "G'day")

print australian_greeting





print "G\'\nday"

print "This is line 1.\nThis is line 2."


print "These\tare\ttabs."


##################################################
# Creating functions.
##################################################

# First attempt:

# Defining a function.
def FeetToMetres(feet):
centi = 2.54
inches = 12
return feet*inches*centi/100

# Defining a function.
def FeetToMetres(feet):
    centi = 2.54
    inches = 12
    return feet*inches*centi/100



def FeetToMetres(feet):
    centi = 2.54
    inches = 12
    return feet*inches*centi/100
    print "Calculation complete"


FeetToMetres(9.5)



def FeetToMetres2(feet):
    centi = 2.54
    inches = 12
return feet*inches*centi/100





def FeetToMetres(feet):
    centi = 2.54
    inches = 12
    return feet*inches*centi/100
print "x"



# What if I make a mistake?

def FeetToMetres2(feet):
    centi = 2.54
    inches = 12
    return feet*inches*cen/100



FeetToMetres2(10)

# Can you find the mistake?


# Try this:

cen = 7
FeetToMetres(10)
FeetToMetres2(10)

# Surprised?
# What's going on?


##################################################
# End
##################################################
