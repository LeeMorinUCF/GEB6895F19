.open AuctionsDatabase.db 

.mode column 
.headers on 
.output query_b.out

SELECT 
    Bids.AuctionID AS AuctionID,
    Auctions.Date , 
    Bids.BidderID,
    MAX(Bids.Bid) AS MaxBid
FROM Bids
INNER JOIN
    Auctions
    ON Bids.AuctionID = Auctions.AuctionID
GROUP BY
    Bids.AuctionID;

.output stdout