# Codebook - MSDS6306_CaseStudy_2

### Introduction
The purpose of this project came from an engagement between the client LinkedIn and Vivek Viswanathan and Megan Hodges LLC. LinkedIn is in need of understanding procrastination among people in certain countries, and how that relates to age, income, life satisfaction, and human development as they look to expand their "hiring assistance" efforts to more countries. They have contracted Vivek and Megan to deliver meaningful data and graphs depicting:
1. The Top 15 Nations in Average DP and GP Procrastination Scores
2. The correlation between the counties on both top 15 lists and Age and Income
3. And the correlation/relationship between the countries on both top 15 and Life Satisfaction and Human Development (HDI)

The following datasets are taken from data collected by Qualtrics on Procrastination as well as data scraped from public domain on the Human Development Index.

This data folder contains the following:
CleanedInput_w_HDI.csv	Revert "Data File."	
HumanDevelopment.csv	Close to final code.	
Procrastination.csv	Code for 3c and 4a	
Top_15_DP_Cntry.csv	Close to final code.	
Top_15_GP_Cntry.csv

*Original Procrastination.csv - a data frame collected from 4162 participants in a study on Procrastination based on 1-5 ranking scores of the DP, AIP, GP, SWLS (all described below).
*http://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries - This is a list of all the countries by the Human Development Index as included in a United Nations Development Programme's Human Development Report. The latest report was released on 21 March 2017 and compiled on the basis of estimates for 2015.

### Procrastination.csv

*Type: Comma-separated value file
*Dimensions: 4162 observations x 19 variables

Variable Information: 

*Age
*Gender
*Kids
*Edu (Education)
*Work Status
*Annual Income
*Current Occupation
*How long have you held this position? Years: Number of years in this job
*How long have you helpd this position? Months: Number of months in this job
*Community: Size of Community
*Country of Residence: 
*Marital Status
*Number of Sons / Number of Daughters
*All variables starting DP
*All variables starting AIP
*All variables starting GP
*All variables starting SWLS
*Do you consider yourself a procrastinator?
*Do others consider you a procrastinator?

Miscellaneous Infomations:

*Definition of DP:
*Definition of AIP:
*Definition of GP:
*Definition of SWLS:

### Human Development Index http://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries 

*Type: url
*Dimensions: 188 observations x 5 variables

Variable Information of Complete list of Countries:
*There are 8 tables that pulled data on Human Development by Country, there were 2 tables per Scale:

Very High Human Development:
*Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
*Country/Territory
*HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

High Human Development:
*Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
*Country/Territory
*HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

Medium Human Development:
*Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
*Country/Territory
*HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

Low Human Development:
*Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
*Country/Territory
*HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
