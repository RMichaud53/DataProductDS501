library(dbplyr)
library(tibble)
library(janitor)
library(ggplot2)

# Import downloaded data files by reading the csv's, 
# one for each of the last 8 seasons
cfb13 = read.csv("cfb13.csv")
cfb14 = read.csv("cfb14.csv")
cfb15 = read.csv("cfb15.csv")
cfb16 = read.csv("cfb16.csv")
cfb17 = read.csv("cfb17.csv")
cfb18 = read.csv("cfb18.csv")
cfb19 = read.csv("cfb19.csv")
cfb20 = read.csv("cfb20.csv")

# Add column to each data frame that stipulates what year the data is from to 
# prepare to bring all years into one data frame
cfb13 = cfb13 %>% add_column(Year = 2013, .after = "Team")
cfb14 = cfb14 %>% add_column(Year = 2014, .after = "Team")
cfb15 = cfb15 %>% add_column(Year = 2015, .after = "Team")
cfb16 = cfb16 %>% add_column(Year = 2016, .after = "Team")
cfb17 = cfb17 %>% add_column(Year = 2017, .after = "Team")
cfb18 = cfb18 %>% add_column(Year = 2018, .after = "Team")
cfb19 = cfb19 %>% add_column(Year = 2019, .after = "Team")
cfb20 = cfb20 %>% add_column(Year = 2020, .after = "Team")

# The first three years have less variable than the latter 5. To be able to
# combine all years into one data frame, it is necessary to identify which
# columns are not in all years to delete them
compare_df_cols(cfb13, cfb16)

# There were 7 variable not present in the first 3 years, and one not in the 
# latter 5 that need to be removed.
cfb16 = subset(cfb16, select = -...40)
cfb17 = subset(cfb17, select = -...40)
cfb18 = subset(cfb18, select = -...40)
cfb19 = subset(cfb19, select = -...40)
cfb20 = subset(cfb20, select = -...40)
cfb16 = subset(cfb16, select = -Avg.Yards.per.Kickoff.Return.Allowed)
cfb17 = subset(cfb17, select = -Avg.Yards.per.Kickoff.Return.Allowed)
cfb18 = subset(cfb18, select = -Avg.Yards.per.Kickoff.Return.Allowed)
cfb19 = subset(cfb19, select = -Avg.Yards.per.Kickoff.Return.Allowed)
cfb20 = subset(cfb20, select = -Avg.Yards.per.Kickoff.Return.Allowed)
cfb16 = subset(cfb16, select = -Kickoff.Return.Def.Rank)
cfb17 = subset(cfb17, select = -Kickoff.Return.Def.Rank)
cfb18 = subset(cfb18, select = -Kickoff.Return.Def.Rank)
cfb19 = subset(cfb19, select = -Kickoff.Return.Def.Rank)
cfb20 = subset(cfb20, select = -Kickoff.Return.Def.Rank)
cfb16 = subset(cfb16, select = -Kickoff.Touchbacks)
cfb17 = subset(cfb17, select = -Kickoff.Touchbacks)
cfb18 = subset(cfb18, select = -Kickoff.Touchbacks)
cfb19 = subset(cfb19, select = -Kickoff.Touchbacks)
cfb20 = subset(cfb20, select = -Kickoff.Touchbacks)
cfb16 = subset(cfb16, select = -Opp.Kickoff.Return.Touchdowns.Allowed)
cfb17 = subset(cfb17, select = -Opp.Kickoff.Return.Touchdowns.Allowed)
cfb18 = subset(cfb18, select = -Opp.Kickoff.Return.Touchdowns.Allowed)
cfb19 = subset(cfb19, select = -Opp.Kickoff.Return.Touchdowns.Allowed)
cfb20 = subset(cfb20, select = -Opp.Kickoff.Return.Touchdowns.Allowed)
cfb16 = subset(cfb16, select = -Opp.Kickoff.Returns)
cfb17 = subset(cfb17, select = -Opp.Kickoff.Returns)
cfb18 = subset(cfb18, select = -Opp.Kickoff.Returns)
cfb19 = subset(cfb19, select = -Opp.Kickoff.Returns)
cfb20 = subset(cfb20, select = -Opp.Kickoff.Returns)
cfb16 = subset(cfb16, select = -Opponent.Kickoff.Return.Yards)
cfb17 = subset(cfb17, select = -Opponent.Kickoff.Return.Yards)
cfb18 = subset(cfb18, select = -Opponent.Kickoff.Return.Yards)
cfb19 = subset(cfb19, select = -Opponent.Kickoff.Return.Yards)
cfb20 = subset(cfb20, select = -Opponent.Kickoff.Return.Yards)
cfb13 = subset(cfb13, select = -Total.TDs)
cfb14 = subset(cfb14, select = -Total.TDs)
cfb15 = subset(cfb15, select = -Total.TDs)

#Combine into one file for the 8 years in total
cfb = rbind(cfb13, cfb14, cfb15, cfb16, cfb17, cfb18, cfb19,cfb20)