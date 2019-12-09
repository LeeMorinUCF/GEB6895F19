.mode column
.headers on
.output SchoolInvolvement.out 

SELECT
    t.NID,
    t.FirstName,
    t.LastName,
    t.Employer,
    t.job_title AS JobTitle,
    t.Program,
    t.Position,
    t.[Course 1],
    t.[Course 2]
From
(
SELECT
    e.nid AS NID,
    e.first_name AS FirstName,
    e.last_name AS LastName,
    e.department AS Employer,
    e.job_title,
    ex.program,
    ex.position,
    s.[Course 1],
    s.[Course 2]
FROM
    EmployeeTable e
LEFT JOIN ExtracurricularList ex ON e.nID = ex.Nid
LEFT JOIN StudentRegister s ON e.nid = s.NID
UNION
SELECT
    ex.NID,
    ex.FirstName,
    ex.LastName,
    e.department,
    e.job_title,
    ex.Program,
    ex.Position,
    s.[Course 1],
    s.[Course 2]
FROM ExtracurricularList ex
LEFT JOIN EmployeeTable e ON ex.NID = e.nid
LEFT JOIN StudentRegister s ON ex.NID = s.NID
UNION
SELECT
    s.NID,
    s.FirstName,
    s.LastName,
    e.department,
    e.job_title,
    ex.Program,
    ex.Position,
    s.[Course 1],
    s.[Course 2]
FROM StudentRegister s
LEFT JOIN EmployeeTable e ON s.NID = e.nid
LEFT JOIN ExtracurricularList ex ON s.NID = ex.NID
) t
WHERE LENGTH(t.NID) = 6;

.output stdout
