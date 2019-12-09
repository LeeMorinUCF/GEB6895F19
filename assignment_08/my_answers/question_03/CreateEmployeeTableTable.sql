
CREATE TABLE EmployeeTable
(
    nid         TEXT,
    first_name  TEXT,
    last_name   TEXT,
    department  TEXT,
    job_title   TEXT,
    PRIMARY KEY (nid)
);

.mode csv
.import EmployeeTable.csv EmployeeTable