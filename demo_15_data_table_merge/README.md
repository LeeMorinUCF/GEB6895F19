# Joining Data Tables in R

## The ```merge``` Function


For the common types of joins, here is the corresponding ``data.table::merge()`` syntax.

INNER JOIN:
``merge(X, Y, all=FALSE)``

LEFT OUTER JOIN:
``merge(X, Y, all.x=TRUE)``

RIGHT OUTER JOIN:
``merge(X, Y, all.y=TRUE)``

FULL OUTER JOIN:
``merge(X, Y, all=TRUE)``



## The ```data.table``` Package

### Reading Data the ```fast``` Way

The ```f``` is for fast reading.

my_table <- fread('table_file_name.csv')

The bigger the dataset, the more of a speed gain you will see compared to alternatives such as ```read.table()``` or ```read.csv()```.
If, at the end of the day, you find that ```data.table``` syntax is not your thing, you might want to load the library just for the speed advantage of this function.


### Mapping SQL Syntax to ```data.table```


The basic elements of the syntax are built on the ```i```, ```j``` and ```by``` arguments.

```SQL
SELECT
  j
FROM data_table
WHERE
  i
GROUP BY
  key_name
;
```

This is taken care of with the following syntax in ```data.table```.

```r
data_table[i, j, by = c('key_name')]
```


The ```data.table``` package uses the join keys as an index for selecting the elements from each table.
To enable this, the ```setkey()``` function must be invoked to identify the join keys.
Essentially, the ```ON``` or ```USING``` clause is defined implicitly by setting the keys on the tables with ```setkey()```.

```
setkey(data_table, key_names)
```

After that, you would use the data table as an argument in the ```i``` argument and ```data.table``` will know how you intend to perform the join, using whatever join keys the two tables have in common.

INNER JOIN:
``X[Y, nomatch=0]``
The ```nomatch``` argument specifies that we drop all records without a match.

LEFT OUTER JOIN:
``Y[X]``

RIGHT OUTER JOIN:
``X[Y]``

FULL OUTER JOIN:
Stick with	```merge(X, Y, all=TRUE)```
Who wants to do a ```FULL OUTER JOIN``` anyway?


### Examples

```
# Read the tables.
Employees <- fread('Employees.csv')
Departments <- fread('Departments.csv')
```

#### Set the keys

```
# Set the ON clause as keys of the tables.
setkey(Employees,Department)
setkey(Departments,Department)
```

#### INNER JOIN
```
# Perform the join, eliminating not matched rows from Right
inner_dt <- Employees[Departments, nomatch=0]
inner_dt
```
Take attendance and see who is missing.

Compare this with ```merge```:
```
inner_merge <- merge(Employees, Departments)
inner_merge
```

#### LEFT OUTER JOIN
```
left_outer_dt <- Departments[Employees]
left_outer_dt

left_outer_merge <- merge(Employees, Departments, all.x = TRUE)
left_outer_merge
```


#### RIGHT OUTER JOIN
```
right_outer_dt <- Employees[Departments]
right_outer_dt

right_outer_merge <- merge(Employees, Departments, all.y = TRUE)
right_outer_merge
```


#### FULL OUTER JOIN
```
full_outer_merge <- merge(Employees, Departments, all = TRUE)
full_outer_merge
```



## The real magic of ```data.table```

In a word: ```speed``` .
The ```data.table``` package uses a variety of memory-saving tricks to make operations more efficient and scalable.
Also, once you get used to it, the notation is less cumbersome than that for ```data.frame```s, especially when it comes to subsetting, by using the ```i``` argument instead.

See the following ```data.table``` cheat sheets for more detail:

[Data Analysis the data.table Way](https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf)

[R For Data Science Cheat Sheet: data.table](https://s3.amazonaws.com/assets.datacamp.com/blog_assets/datatable_Cheat_Sheet_R.pdf)

[Advanced tips and tricks with data.table](http://brooksandrew.github.io/simpleblog/articles/advanced-data-table/)


If you are having problems grasping the sometimes baffling syntax for data.table, the following references may be helpful.

[FAQs about the data.table package in R](http://datatable.r-forge.r-project.org/datatable-faq.pdf)

[Frequently Asked Questions about data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-faq.html)

Hint: Most of the common errors stem from thinking of a data.table as a data frame. 
