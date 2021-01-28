
CREATE TABLE ExtracurricularList
(
    NID         TEXT,
    FirstName   TEXT,
    LastName    TEXT,
    Program     TEXT,
    Position    TEXT,
    PRIMARY KEY (NID)
);

.mode csv
.import ExtracurricularList.csv ExtracurricularList