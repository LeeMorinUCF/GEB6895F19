# -*- coding: utf-8 -*-
"""
##################################################
#
# GEB 6895: Business Intelligence
#
# Numerical Methods in Python
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

import numpy as np

from scipy import linalg

import matplotlib.pyplot as plt


##################################################
# Set Working Directory.
##################################################


# Find out the current directory.
os.getcwd()
# Change to a new directory.
os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\ECO5445_Fall2019\\GitRepos\\Original\\demo_10_python_num')
# Check that the change was successful.
os.getcwd()



##################################################
# Numpy.
##################################################



A = np.array([[1., 2.], [3., 4.]])
b = np.array([1., 1.])
soln = np.linalg.solve(A, b)
soln



# Create some data to output.
x_out = (np.array(range(7)) + 1)*0.1
y_out = np.full(7, 0.1)
z_out = np.sqrt(x_out*x_out + y_out*y_out)
dataOut = np.column_stack((x_out, y_out, z_out))
np.savetxt('PythagExample.dat', dataOut, fmt = ('%10.4f %10.4f %10.4f'), header = 'x, y, z')




x, y, z = np.loadtxt('PythagExample.dat', unpack = True)
d = np.sqrt(x*x + y*y)
dataOut = np.column_stack((d, z))
np.savetxt('PythagOutput.dat', dataOut, fmt = ('%15.10f %10.4f'), header = 'd, z\n')




a = np.zeros((2,2))   # Create an array of all zeros
print(a)              # Prints "[[ 0.  0.]
                      #          [ 0.  0.]]"

b = np.ones((1,2))    # Create an array of all ones
print(b)              # Prints "[[ 1.  1.]]"

c = np.full((2,2), 7)  # Create a constant array
print(c)               # Prints "[[ 7.  7.]
                       #          [ 7.  7.]]"

d = np.eye(2)         # Create a 2x2 identity matrix
print(d)              # Prints "[[ 1.  0.]
                      #          [ 0.  1.]]"

e = np.random.random((2,2))  # Create an array filled with random values
print(e)                     # Might





a = np.array([[1,2,3,4], [5,6,7,8], [9,10,11,12]])

# Use slicing to pull out the subarray consisting of the first 2 rows
# and columns 1 and 2; b is the following array of shape (2, 2):
# [[2 3]
#  [6 7]]
b = a[:2, 1:3]

# A slice of an array is a view into the same data, so modifying it
# will modify the original array.
print(a[0, 1])   # Prints "2"
b[0, 0] = 77     # b[0, 0] is the same piece of data as a[0, 1]
print(a[0, 1])   # Prints "77"



c = a


c[1,1] = 88

a




# Create the following rank 2 array with shape (3, 4)
# [[ 1  2  3  4]
#  [ 5  6  7  8]
#  [ 9 10 11 12]]
a = np.array([[1,2,3,4], [5,6,7,8], [9,10,11,12]])

# Two ways of accessing the data in the middle row of the array.
# Mixing integer indexing with slices yields an array of lower rank,
# while using only slices yields an array of the same rank as the
# original array:
row_r1 = a[1, :]    # Rank 1 view of the second row of a
row_r2 = a[1:2, :]  # Rank 2 view of the second row of a
print(row_r1, row_r1.shape)  # Prints "[5 6 7 8] (4,)"
print(row_r2, row_r2.shape)  # Prints "[[5 6 7 8]] (1, 4)"

row_r1
row_r1[0]

row_r2
row_r2[0]
row_r2[1]

row_r2[0,1]





# We can make the same distinction when accessing columns of an array:
col_r1 = a[:, 1]
col_r2 = a[:, 1:2]
print(col_r1, col_r1.shape)  # Prints "[ 2  6 10] (3,)"
print(col_r2, col_r2.shape)  # Prints "[[ 2]
                             #          [ 6]
                             #          [10]] (3, 1)"



a = np.array([[1,2,3], [4,5,6], [7,8,9], [10, 11, 12]])

print(a)  # prints "array([[ 1,  2,  3],
          #                [ 4,  5,  6],
          #                [ 7,  8,  9],
          #                [10, 11, 12]])"

# Create an array of indices
b = np.array([0, 2, 0, 1])

# Select one element from each row of a using the indices in b
print(a[np.arange(4), b])  # Prints "[ 1  6  7 11]"

# Mutate one element from each row of a using the indices in b
a[np.arange(4), b] += 10

print(a)  # prints "array([[11,  2,  3],







a

a[a>2]






##################################################
# Scipy.
##################################################


# import numpy as np
# from scipy import linalg
A = np.array([[1,3,5],[2,5,1],[2,3,8]])
A

linalg.inv(A)

A.dot(linalg.inv(A)) #double check





# import numpy as np
# from scipy import linalg
# import matplotlib.pyplot as plt

# Set parameters and generate data
c1, c2 = 5.0, 2.0
i = np.r_[1:11]
xi = 0.1*i
yi = c1*np.exp(-xi) + c2*xi
zi = yi + 0.05 * np.max(yi) * np.random.randn(len(yi))

# Arrange into matrix form
A = np.c_[np.exp(-xi)[:, np.newaxis], xi[:, np.newaxis]]
# The newaxis argument increases the dimension of the array by one dimension
# Useful for creating objects one dimension higher

# Solve the system by least squares
c, resid, rank, sigma = linalg.lstsq(A, zi)

# Calculate the fitted values
xi2 = np.r_[0.1:1.0:100j]
yi2 = c[0]*np.exp(-xi2) + c[1]*xi2

# Plot the data and the fitted model
plt.plot(xi,zi,'x',xi2,yi2)
plt.axis([0,1.1,3.0,5.5])
plt.xlabel('$x_i$')
plt.title('Data fitting with linalg.lstsq')
plt.show()


A.describe()



##################################################
# End.
##################################################
