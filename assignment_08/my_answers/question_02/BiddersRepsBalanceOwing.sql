.open AuctionsDatabase.db 

.mode column 
.headers on 
.output BiddersRepsBalanceOwing.out


SELECT
    two_c.BidderID,
    two_c.Name,
    two_c.Address,
    two_c.Zip,
    two_c.Phone,
    SUM(two_c.Balance) AS Total_Balance

From(

    SELECT
        b.BidderID AS BidderID,
        b.Name AS Name,
        b.Address1 AS Address,
        b.City AS City,
        b.State AS State,
        b.Zip AS Zip,
        b.Phone AS Phone,
        part_c.Date AS Date,
        part_c.AuctionID AS AuctionID,
        part_c.Volume AS Volume,
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
        part_c.AuctionID
) two_c

GROUP BY
    two_c.BidderID;

.output stdout