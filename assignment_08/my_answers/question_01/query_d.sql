.open AuctionsDatabase.db 

.mode columns 
.header on 
.output query_d.out

SELECT
     CASE
        WHEN SUBSTR(part_c.Date, 5, 2) = '01' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q1')
        WHEN SUBSTR(part_c.Date, 5, 2) = '02' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q1')
        WHEN SUBSTR(part_c.Date, 5, 2) = '03' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q1')
        WHEN SUBSTR(part_c.Date, 5, 2) = '04' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q2')
        WHEN SUBSTR(part_c.Date, 5, 2) = '05' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q2')
        WHEN SUBSTR(part_c.Date, 5, 2) = '06' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q2')
        WHEN SUBSTR(part_c.Date, 5, 2) = '07' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q3')
        WHEN SUBSTR(part_c.Date, 5, 2) = '08' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q3')
        WHEN SUBSTR(part_c.Date, 5, 2) = '09' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q3')
        WHEN SUBSTR(part_c.Date, 5, 2) = '10' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q4')
        WHEN SUBSTR(part_c.Date, 5, 2) = '11' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q4')
        WHEN SUBSTR(part_c.Date, 5, 2) = '12' THEN REPLACE(part_c.Date,SUBSTR(part_c.Date, 5, 4), 'Q4')
    END AS Quarter,
    SUM(part_c.Revenue) AS Revenue
FROM(
    SELECT
        part_b.AuctionID,
        part_b.Date AS Date,
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
        part_b.AuctionID

) part_c

GROUP BY
    Quarter;

.output stdout