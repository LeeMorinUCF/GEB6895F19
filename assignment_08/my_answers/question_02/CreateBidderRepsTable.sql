CREATE TABLE BiddersReps(
RepID       INTEGER,
BidderID    INTEGER ,
Name        TEXT ,
Address1    TEXT ,
City        TEXT ,
State       TEXT ,
Zip         TEXT ,
Phone       TEXT ,
FOREIGN KEY     (BidderID) REFERENCES Bidders (BidderID),
PRIMARY KEY     (RepID)
);

