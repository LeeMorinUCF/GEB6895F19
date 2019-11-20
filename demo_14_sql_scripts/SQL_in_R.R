##################################################
# 
# GEB 6895: Tools for Business Intelligence
# 
# SQL in R
# Executing SQL queries to aggregate and join data in data frames.
# 
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# November 20, 2019
# 
##################################################
# 
# SQL_in_R shows how to execute SQL queries
#   using tables read as dataframes from csv files.
#   The SQL queries are used to aggregate and join data 
#   and output data frames.
# 
# Dependencies:
#   library(sqldf) 
# 
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder'
wd_path <- '~/Teaching/GEB6895_Fall_2019/GitRepos/demo_14_sql_scripts'

setwd(wd_path)

# Load the sqldf package to use data frames with SQL queries.
# Need to install it the first time.
# install.packages('sqldf')
library(sqldf)


##################################################
# Load tables from auction database
##################################################

# Read the raw data.
Auctions <- read.csv('AuctionsTable.csv')
Bidders <- read.csv('BiddersTable.csv')
Bids <- read.csv('BidsTable.csv')

# Define the column names.
# The rest of the schema is inferred from the data,
# just as with any other data frame.
colnames(Auctions) <- c('AuctionID', 'Volume', 'District', 'Date')
colnames(Bidders) <- c('BidderID', 'FirstName', 'LastName', 
                       'Address1', 'Address2', 'Town', 'Province', 'PostalCode',
                       'Telephone', 'Email', 'Preferred')
colnames(Bids) <- c('BidID', 'AuctionID', 'BidderID', 'Bid')







##################################################
# Execute queries with these tables
##################################################

# Display the contents of the tables.
sqldf('SELECT * FROM Auctions;')
sqldf('SELECT * FROM Bidders;')
sqldf('SELECT * FROM Bids;')

# Execute queries with aggregation.
sqldf('SELECT 
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      GROUP BY
        bids.BidderID
      ;')


sqldf('SELECT 
        bids.BidderID,
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      GROUP BY
        bids.BidderID
      ;')


# Execute queries with joins.
sqldf('SELECT 
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        bids.Bid
      FROM
        Bids AS bids
      INNER JOIN 
        Bidders AS bidders
      ON 
        bids.BidderID = bidders.BidderID
      ;')

# Example of left join. 
sqldf('SELECT 
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        AVG(bids.Bid) AS AverageBid
      FROM
        Bids AS bids
      LEFT JOIN 
        (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
      ON 
        bids.BidderID = bidders.BidderID
      GROUP BY 
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName
      ;')
# Note that some bidder names were not included 
# when dropping BidderID >= 6.
# The joined AverageBid on the right is include anyway, 
# with bidder information left blank. 


# Inner join.
sqldf('SELECT 
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName,
        AVG(bids.Bid) AS AverageBid
      FROM
        (SELECT * FROM Bids WHERE BidderID > 2) AS bids
      INNER JOIN 
        (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
      ON 
        bids.BidderID = bidders.BidderID
      GROUP BY 
        bidders.BidderID,
        bidders.FirstName,
        bidders.LastName
      ;')
# With an inner join, the dropped observations from either table
# are dropped from the joined table as well. 



# Outer join.
sqldf('SELECT 
    bidders.BidderID,
      bidders.FirstName,
      bidders.LastName,
      AVG(bids.Bid) AS AverageBid
      FROM
      (SELECT * FROM Bids WHERE BidderID > 2) AS bids
      FULL OUTER JOIN (SELECT * FROM Bidders WHERE BidderID < 6) AS bidders
      ON bids.BidderID = bidders.BidderID
      GROUP BY 
      bidders.BidderID,
      bidders.FirstName,
      bidders.LastName
      ;')
# FAIL: Not all pakages support outer joins.
# It is just a regular merge without much SQL machinery anyway.

# Most queries can be executed with left joins. 
# It is a matter of choosing the table on the left.



##################################################
# 
##################################################

# Read the text from the SQL script.
query_1 <- readLines('ComputeBidSummariesByBidder.sql', 
                     n = 21)
# See which lines contain the query. 
query_1
# Select the lines containing the query.
query_1[11:20]

# Execute the query, after collapsing into a single line.
sqldf(paste(query_1[11:20], collapse = ' '))



# Read and execute the next query.
query_2 <- readLines('ComputeBidSummariesAndJoinNames.sql', 
                     n = 27)
# See which lines contain the query. 
query_2
# Select those lines.
query_2[12:26]


# Execute the query, after collapsing into a single line.
sqldf(paste(query_2[12:26], collapse = ' '))


# In practice, you might use an sql script 
# that contains only the query for this purpose,
# rather than the script designed for outputting a file.


##################################################
# End
##################################################

