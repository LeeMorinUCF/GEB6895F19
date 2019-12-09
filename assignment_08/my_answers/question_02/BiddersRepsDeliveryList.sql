.mode column 
.headers on 
.output BiddersRepsDeliveryList.out

SELECT
    b.BidderID,
    b.Name,
    b.Address1 AS Address,
    b.City,
    b.State,
    b.Zip,
    part_c.Date,
    part_c.AuctionID,
    part_c.Volume,
    part_c.Revenue AS Balance

FROM
    BiddersReps b 
INNER JOIN(

    SELECT
        part_b.AuctionID,
        part_b.Date AS Date,
        part_b.Volume AS Volume,
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
) part_c
ON part_c.BidderID = b.BidderID

GROUP BY
    part_c.AuctionID;

.output stdout