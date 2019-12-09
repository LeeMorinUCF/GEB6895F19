.open AuctionsDatabase.db 

.mode column 
.headers on 
.output query_c.out


SELECT
    part_b.AuctionID,
    part_b.Date,
    part_b.MaxBid * part_b.Volume AS Revenue,
    part_b.BidderID

FROM (
    SELECT 
        Bids.AuctionID AS AuctionID,
        Auctions.Date , 
        Bids.BidderID,
        MAX(Bids.Bid) AS MaxBid,
        Auctions.Volume
    FROM Bids
    INNER JOIN
        Auctions
        ON Bids.AuctionID = Auctions.AuctionID
    GROUP BY
        Bids.AuctionID
) part_b

GROUP BY
    part_b.AuctionID;

.output stdout