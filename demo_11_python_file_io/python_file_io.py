# -*- coding: utf-8 -*-
"""
##################################################
#
# ECO 5445: Intro to Business Analytics
#
# GEB 6895: Tools for Business Intelligence
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# September 30, 2019
#
##################################################
"""



##################################################
# Import Modules.
##################################################

import os
import csv


##################################################
# Interacting with the Operating System.
##################################################


# import os

# Find out the current directory.
os.getcwd()
# Change to a new directory.
# Notice the double backslashes. The first is the escape sequence to tell the interpreter to actually print the second backslash.
os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\ECO5445_Fall2019\\GitRepos\\Original\\demo_06_python_file_io')
# Check that the change was successful.
os.getcwd()


##################################################
# Using 'with' to Interact with Files.
##################################################



with open('file_to_save.txt', 'w') as open_file:
    for i in range(5):
        open_file.write('A string to write on line %d.\n' % (i+1))


##################################################
# Creating a File Object to Interact with Files.
##################################################


open_file = open('another_file_to_save.txt', 'w')
open_file.write('A string to write on line 1\n')
open_file.write('A string to write on line 2\n')
open_file.write('A string to write on line 3\n')
open_file.close()




inputFile = open('another_file_to_save.txt', 'r')
firstLine = inputFile.readline()
secondLine = inputFile.readline()
thirdLine = inputFile.readline()



##################################################
# Interacting with csv Files.
##################################################


# import csv

with open('eggs.csv', 'wb') as csvfile:
    spamwriter = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    spamwriter.writerow(['Spam'] * 5 + ['Baked Beans'])
    spamwriter.writerow(['Spam', 'Lovely Spam', 'Wonderful Spam'])


with open('eggs.csv', 'rb') as csvfile:
     spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
     for row in spamreader:
         print row
         print ', '.join(row)


##################################################
# End
##################################################
