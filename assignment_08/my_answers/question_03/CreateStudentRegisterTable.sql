
CREATE TABLE StudentRegister
(
    NID         TEXT,
    FirstName   TEXT,
    LastName    TEXT,
    Program     TEXT,
    Status      TEXT,
    GPA         INTEGER,
    [Course 1]  TEXT,
    [Course 2]  Text,
    PRIMARY KEY (NID)   
);

.mode csv
.import StudentRegister.csv StudentRegister