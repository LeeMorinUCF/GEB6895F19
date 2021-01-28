# Numerical Methods with Python

## Before anything else, set the working directory.
```python
import os
# Find out the current directory.
os.getcwd()
# Change to a new directory.
os.chdir('C:\\Users\\le279259\\Documents\\Teaching\\ECO5445_Fall2019\\GitRepos\\Original\\demo_10_python_num')
# Check that the change was successful.
os.getcwd()
```

## Numerical Methods

### The ```numpy``` Package

This package provides a framework for mathematical computing, including manipulating multidimensional arrays. For example,

```python
import numpy as np
A = np.array([[1., 2.], [3., 4.]])
b = np.array([1., 1.])
soln = np.linalg.solve(A, b)
soln
```

Note that he above instance of ```numpy``` uses the abbreviation ```np```, thereby assigning the functions in the ```numpy``` package as if they were attributes of a newly defined ```np``` object.

This package comes with its own function for loading numerical data, as in the following example.

```python
import numpy as np

# Create some data to output.
x_out = (np.array(range(7)) + 1)*0.1
y_out = np.full(7, 0.1)
z_out = np.sqrt(x_out*x_out + y_out*y_out)
dataOut = np.column_stack((x_out, y_out, z_out))
np.savetxt('PythagExample.dat', dataOut, fmt = ('%10.4f %10.4f %10.4f'), header = 'x, y, z')

# Now read it back in, perform calculations and save another output.
x, y, z = np.loadtxt('PythagExample.dat', unpack = True)
d = np.sqrt(x*x + y*y)
dataOut = np.column_stack((d, z))
np.savetxt('PythagOutput.dat', dataOut, fmt = ('%15.10f %10.4f'), header = 'd, z\n')
```

With an additional argument, this function can also be used to load ```csv``` files.

```python
i, j, k = np.loadtxt('FileName.csv', unpack = True, delimiter = ',')
```

For now, we have been unpacking the columns into separate objects to demonstrate that functionality but this practice could lead to errors if the elements become misaligned. Normally you would load the data as a single array and operate on the columns.

NumPy has functions to produce a number of kinds of arrays

```Python
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
print(e)                     # Might print "[[ 0.91940167  0.08143941]
                             #               [ 0.68744134  0.87236687]]"
```

Slicing ```numpy``` arrays is similar to that for lists:

```Python
# Create the following rank 2 array with shape (3, 4)
# [[ 1  2  3  4]
#  [ 5  6  7  8]
#  [ 9 10 11 12]]
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
```

Are you surprised yet?

Note that there is a difference between integer indexing and slicing
```Python
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

# We can make the same distinction when accessing columns of an array:
col_r1 = a[:, 1]
col_r2 = a[:, 1:2]
print(col_r1, col_r1.shape)  # Prints "[ 2  6 10] (3,)"
print(col_r2, col_r2.shape)  # Prints "[[ 2]
                             #          [ 6]
                             #          [10]] (3, 1)"
```
Note the double square brackets.

You can get fairly creative with your selection of elements in a ```numpy``` array.

```python
# Create a new array from which we will select elements
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
          #                [ 4,  5, 16],
          #                [17,  8,  9],
          #                [10, 21, 12]])
```

One of the most useful methods of selecting data is the use of boolean indexing

```python
a = np.array([[1,2], [3, 4], [5, 6]])

bool_idx = (a > 2)   # Find the elements of a that are bigger than 2;
                     # this returns a numpy array of Booleans of the same
                     # shape as a, where each slot of bool_idx tells
                     # whether that element of a is > 2.

print(bool_idx)      # Prints "[[False False]
                     #          [ True  True]
                     #          [ True  True]]"

# We use boolean array indexing to construct a rank 1 array
# consisting of the elements of a corresponding to the True values
# of bool_idx
print(a[bool_idx])  # Prints "[3 4 5 6]"

# We can do all of the above in a single concise statement:
print(a[a > 2])     # Prints "[3 4 5 6]"
```

Numpy arrays are made of elements of the same numeric type


```python
x = np.array([1, 2])   # Let numpy choose the datatype
print(x.dtype)         # Prints "int64"

x = np.array([1.0, 2.0])   # Let numpy choose the datatype
print(x.dtype)             # Prints "float64"

x = np.array([1, 2], dtype=np.int64)   # Force a particular datatype
print(x.dtype)                         # Prints "int64"
```


You can do mathematical operations on elements in arrays, element-by-element

```python
x = np.array([[1,2],[3,4]], dtype=np.float64)
y = np.array([[5,6],[7,8]], dtype=np.float64)

# Elementwise sum; both produce the array
# [[ 6.0  8.0]
#  [10.0 12.0]]
print(x + y)
print(np.add(x, y))

# Elementwise difference; both produce the array
# [[-4.0 -4.0]
#  [-4.0 -4.0]]
print(x - y)
print(np.subtract(x, y))

# Elementwise product; both produce the array
# [[ 5.0 12.0]
#  [21.0 32.0]]
print(x * y)
print(np.multiply(x, y))

# Elementwise division; both produce the array
# [[ 0.2         0.33333333]
#  [ 0.42857143  0.5       ]]
print(x / y)
print(np.divide(x, y))

# Elementwise square root; produces the array
# [[ 1.          1.41421356]
#  [ 1.73205081  2.        ]]
print(np.sqrt(x))
```

For applications in linear algebra, the ```dot``` function performs matrix multiplication


```python
x = np.array([[1,2],[3,4]])
y = np.array([[5,6],[7,8]])

v = np.array([9,10])
w = np.array([11, 12])

# Inner product of vectors; both produce 219
print(v.dot(w))
print(np.dot(v, w))

# Matrix / vector product; both produce the rank 1 array [29 67]
print(x.dot(v))
print(np.dot(x, v))

# Matrix / matrix product; both produce the rank 2 array
# [[19 22]
#  [43 50]]
print(x.dot(y))
print(np.dot(x, y))
```


You can also sum elements across a specified dimensional

```python
x = np.array([[1,2],[3,4]])

print(np.sum(x))  # Compute sum of all elements; prints "10"
print(np.sum(x, axis=0))  # Compute sum of each column; prints "[4 6]"
print(np.sum(x, axis=1))  # Compute sum of each row; prints "[3 7]"
```


The transpose operator is specified by ```T```

```Python
x = np.array([[1,2], [3,4]])
print(x)    # Prints "[[1 2]
            #          [3 4]]"
print(x.T)  # Prints "[[1 3]
            #          [2 4]]"
```

Now you can perform computations just as you would on the blackboard.







### The ```scipy``` Package

This package includes a number of modules for scientific computing.
Here, we will only scratch the surface, while these tools can be discussed
in greater detail when we move on to numerical methods.
You will typically import a selected module from the ```scipy``` package.

### Linear Algebra


```python
import numpy as np
from scipy import linalg
A = np.array([[1,3,5],[2,5,1],[2,3,8]])
A

linalg.inv(A)

A.dot(linalg.inv(A)) #double check

```

This package offers another approach to solve a linear system.

```python
A = np.array([[1, 2], [3, 4]])
A

b = np.array([[5], [6]])
b

# Make sure A is invertible firstself.
linalg.det(A)

linalg.inv(A).dot(b)  # slow

A.dot(linalg.inv(A).dot(b)) - b  # check

np.linalg.solve(A, b)  # fast

A.dot(np.linalg.solve(A, b)) - b  # check

```

You can calculate eigenvalues and eigenvectors numerically.


```python
A = np.array([[1, 2], [3, 4]])
la, v = linalg.eig(A)
l1, l2 = la
print(l1, l2)   # eigenvalues

print(v[:, 0])   # first eigenvector

print(v[:, 1])   # second eigenvector

print(np.sum(abs(v**2), axis=0))  # eigenvectors are unitary

v1 = np.array(v[:, 0]).T

print(linalg.norm(A.dot(v1) - l1*v1))  # check the computation

```

### Example

Put some of these tools together to generate and estimate a nonlinear model (that is linear in the parameters)

```python
# Declare packages
import numpy as np
from scipy import linalg
import matplotlib.pyplot as plt

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
```


### Solving Systems of Equations

See the script ```scipy_solving.py``` for some examples of solving nonlinear systems of equations.


### Optimization

See the script ```scipy_optimization.py``` for some examples.



The examples cited above are drawn from the Scipy.org website in the documentation for the [Optimization (scipy.optimize)](https://docs.scipy.org/doc/scipy/reference/tutorial/optimize.html) module. 



