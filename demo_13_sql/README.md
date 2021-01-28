# Organizing Data

## Basic SQL Example

### Operations on a single table

First specify the schema of the first table

```
CREATE TABLE FirstTable(
KeyID          INTEGER NOT NULL ,
Date           TEXT NOT NULL ,
Name           TEXT NOT NULL ,
PRIMARY KEY    (KeyID)
);
```

To verify the above, you can verify the schema by using the ```.schema``` command at the ```sqlite``` prompt. 
Aside from checking for mistakes made on input, this is epecially useful for understanding a database created by someone else. 

You can then populate ```FirstTable``` with a few entries as follows

```
INSERT INTO FirstTable(KeyID, Date, Name)
VALUES(1, "20131204", "Harry J. Paarsch");
INSERT INTO FirstTable(KeyID, Date, Name)
VALUES(2, "20131204", "Konstantin Golyaev");
INSERT INTO FirstTable(KeyID, Date, Name)
VALUES(3, "20131204", "Alberto M. Segre");
```
To see the table entered above, you can execute the simplest SQL query
```
SELECT * FROM FirstTable;
```
which will return the entire table. 

You can execute a query with a restriction by adding a ```WHERE``` clause

```
SELECT * FROM FirstTable WHERE KeyID > 1;
```

Alternatively, you can execute a query with a projection by specifying the fields
```
SELECT Name, Date FROM FirstTable;
```

If you prefer variables that are functions of the fields in the table, you can specify them with additional functions
```
SELECT 
    Name ,
    SUBSTR(Date 1, 4) as Year 
FROM FirstTable;
```


Finally, you can combine these operations in a more complex query

```
SELECT 
    Name ,
    SUBSTR(Date 1, 4) as Year 
FROM 
    FirstTable
WHERE KeyID > 1;
```

### Combining more than one table

Again, first specify the schema of this table

```
CREATE TABLE SecondTable(
KeyID          INTEGER PRIMARY KEY ,
OtherID        INTEGER PRIMARY KEY ,
Name           TEXT NOT NULL ,
FOREIGN KEY    (OtherID) REFERENCES FirstTable (KeyID)
PRIMARY KEY    (KeyID)
);
```


Next populate ```SecondTable``` with a few entries as follows

```
INSERT INTO SecondTable(KeyID, OtherID, Name)
VALUES(101, 1, "Harry J. Paarsch");
INSERT INTO SecondTable(KeyID, OtherID, Name)
VALUES(102, 2, "Konstantin Golyaev");
```

Now you can verify the contents of the database with ```.tables``` and ```.schema```

In addition, for a small example like this, you can output the tables to screen

```
SELECT * FROM FirstTable;
```
```
SELECT * FROM SecondTable;
```

With two tables, you can implement a theta join

```
SELECT 
    FirstTable.KeyID ,
    SecondTable.KeyID ,
    FirstTable.Name
FROM
    FirstTable ,
    SecondTable
WHERE 
    (FirstTable.Name = SecondTable.Name)
AND
    (FirstTable.KeyID = SecondTable.OtherID)
;
```

### Using Command Files

While you might type faster than I do, what you type at the prompt would have to be re-entered to make any modifications. In addition, there would be no record of what you entered.

If your commands are collected into ```.sql``` scripts then it would serve as a form of documentation, enabling someone else to build upon your work in the future.

See the scripts ```FirstTable.sql```, ```SecondTable.sql``` and ```ExampleThetaJoin.sql``` above.

You can create the first table by running the command 

```
sqlite> .read FirstTable.sql
```
at the ```sqlite>``` prompt and likewise for the second table. 
Verify the result by entering ```.tables``` and ```.schema```.

RUn the sample query by entering 
```
sqlite> .read ExampleThetaJoin.sql
```
at the ```sqlite>``` prompt.

To see the result, type ```more ExampleThetaJoin.csv``` in a terminal window. 



