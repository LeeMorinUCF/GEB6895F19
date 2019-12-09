.open AuctionsDatabase.db 

.mode column
.headers on 
.output query_a.out 

SELECT 
    AuctionID,
    MAX(Bid) AS Max_Bid
FROM Bids
GROUP BY AuctionID;

.output stdout