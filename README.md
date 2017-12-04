# Codebook - MSDS6306_CaseStudy_2
---
title: "Understanding Top Procrastination Countries based on DP and GP Scores, and how it relates to Age, Income, Life Satisfaction, and Human Development"

author: Vivek Viswanathan and Megan Hodges

date: Decemeber 4, 2017

output:
  html_document:
    keep_md: yes
    
Contact Information: 

SessionInfo:
---

# Introduction
The purpose/objective of this project came from an engagement between the client LinkedIn and Vivek Viswanathan and Megan Hodges LLC. LinkedIn is in need of understanding procrastination among people in certain countries, and how that relates to age, income, life satisfaction, and human development as they look to expand their "hiring assistance" efforts to more countries. They have contracted Vivek and Megan to deliver meaningful data and graphs depicting:
1. The Top 15 Nations in Average DP and GP Procrastination Scores
2. The correlation between the counties on both top 15 lists and Age and Income
3. And the correlation/relationship between the countries on both top 15 and Life Satisfaction and Human Development (HDI)

## Datasets
The following datasets are taken from data collected by Qualtrics on Procrastination as well as data scraped from public domain on the Human Development Index.

### This data folder contains the following:
CleanedInput_w_HDI.csv	Revert "Data File."	
HumanDevelopment.csv	Close to final code.	
Procrastination.csv	Code for 3c and 4a		

1. Original Procrastination.csv - a data frame collected from 4162 participants in a study on Procrastination based on 1-5 ranking scores of the DP, AIP, GP, SWLS (all described below).

2. http://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries - This is a list of all the countries by the Human Development Index as included in a United Nations Development Programme's Human Development Report. The latest report was released on 21 March 2017 and compiled on the basis of estimates for 2015.

3. Top 15 DP Countries (Top_15_DP_Cntry.csv)

4. Top 15 GP Countries (Top_15_GP_Cntry.csv)

## Procrastination.csv

* Type: Comma-separated value file
* Dimensions: 4162 observations x 19 variables

### Variable Information: 

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

### Miscellaneous Infomation:
* Definition of Decisional Procrastination (DP): Decisional Procrastination distinguishes between adaptive and non-adaptive patterns of coping with challenge. One of the non-adaptive patterns is defensive avoidance, which arises when any alternative available is unsatisfactory or risky and the decision-maker does not hope to find a better solution. The individual then may try to escape from making a decision by procrastinating. Decisional Procrastination Scale (DPS) was developed within this framework of decision-making research. As implied by the name, this kind of procrastination means to put off making a decision within some specific time frame. The DP is composed of items such that respondents express an opinion on a 5-point scale (1 = strongly disagree; 5 = strongly agree).

* Definition of Adult Inventory Procrastination (AIP): The AIP Scale measures the chronic tendency to postpone tasks in various situations. It examines procrastination motivated by fears (e.g., success or failure), avoidance of disclosure of skill inabilities, and performance insecurity. The AIP assesses avoidance procrastination; that is, putting off tasks to protect one’s self-esteem from possible failure. The AIP is composed of 15 Likert-scale items such that respondents express an opinion on a 5-point scale (1 = strongly disagree; 5 = strongly agree) to statements such as “I am not very good at meeting deadlines” and “I don’t get things done on time.” For seven items, scores are reversed so that high ratings indicate procrastination.

* Definition of General Procrastination Scale (GP):The GP Scale is composed of 20 items that measure trait procrastination on a variety of everyday activities such that respondents express an opinion on a 5-point scale (1 = extremely uncharacteristic; 5 = extremely characteristic).

* Definition of Satisfaction with Life Scale (SWLS): The SWLS is a short 5-item instrument designed to measure gloabl cognitive judgements of satisfaction with one's life. The SWLS usually requires only about one minute of a respondent's time. Expressed on a 5-point scale (1 = extremely dissatisfied; 5 = highly satisfied).

## Human Development Index http://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries 

* Type: url
* Dimensions: 188 observations x 5 variables

### Variable Information of Complete list of Countries:
* There are 8 tables that pulled data on Human Development by Country, there were 2 tables per Scale:

### Very High Human Development:
* Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
* Country/Territory
* HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

### High Human Development:
* Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
* Country/Territory
* HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

### Medium Human Development:
* Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
* Country/Territory
* HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

### Low Human Development:
* Rank: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year
* Country/Territory
* HDI: This variable has two subset variables: 2016 estimates for 2015 and Change in rank from previous year

# Conclusion

## Sources
* Human Development Index: Wikipedia: United Nations Development Programme's Human Development Report, "Human Development Report 2016 – "Human Development for Everyone"" (PDF). HDRO (Human Development Report Office) United Nations Development Programme. pp. 198–201. Retrieved 2 September 2017.
* Procrastination Data: Qualtrics
* Decisional Procrastination: Janis and Mann’s (1977) conflict model of decision making. Mann’s (1982, as cited in Ferrari et al., 1995). (Mann, Burnett, Radford, & Ford, 1997). https://pdfs.semanticscholar.org/f02f/76877ec329060cad0ff8c94b5fc3f4e3e1f9.pdf
* Adult Inventory Procrastination:  (Ferrari, 1991) (see Ferrari et al., 1995, for the complete list of items)
* General Procrastination Scale: Lay, C. (1986). At last, my research article on procrastination. Journal of Research in
Personality, 20, 474-495. 
* Satisfaction with Life Scale: Ed Diener, Robert A. Emmons, Randy J. Larsen and Sharon Griffin as noted in the 1985 article in the Journal of Personality Assessment. 5-point attribution: Kobau, R., Sniezek, J., Zack, M. M., Lucas, R. E., & Burns, A. (2010). Well‐being assessment: An evaluation of well‐being scales for public health and population estimates of well‐being among US adults. Applied Psychology: Health and Well-being, 2(3), 272-297. doi:http://dx.doi.org/10.1111/j.1758-0854.2010.01035.x
