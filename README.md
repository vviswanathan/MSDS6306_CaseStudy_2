# "Understanding Top Procrastination Countries based on DP and GP Scores, and how it relates to Age, Income, Life Satisfaction, and Human Development"
---
**Title:** *"Understanding Top Procrastination Countries based on DP and GP Scores, and how it relates to Age, Income, Life Satisfaction, and Human Development"*

**Author:** Vivek Viswanathan and Megan Hodges

**Date:** Decemeber 4, 2017

**Output:**
  html_document:
    keep_md: yes
    
**Contact Information:**  
Vivek, vviswanathan@mail.smu.edu  
Megan, mdhodges@smu.edu

**SessionInfo:**  
*Megan's System:*  
R version 3.4.1 (2017-06-30)  
Platform: x86_64-apple-darwin13.4.0 (64-bit)  
Running under: macOS High Sierra 10.13.1  
 
*Vivek's System:*  
R version 3.4.1 (2017-06-30)   
Platform: x86_64-w64-mingw32/x64 (64-bit)   
Running under: Windows >= 8 x64 (build 9200)     

**Packages Utilized:**

library(repmis)  
library(dplyr)  
library(tidyverse)  
library(tidyr)  
library(ggplot2)   
library(sqldf)  
library(kimisc)  
library(XML)  
library(RCurl)  
library(rvest)  
library(plyr)  
library(pastecs)   
  
---  
  
# Introduction
The purpose/objective of this project came from an engagement between the client LinkedIn and Vivek Viswanathan and Megan Hodges LLC. LinkedIn is in need of understanding procrastination among people in certain countries, and how that relates to age, income, life satisfaction, and human development as they look to expand their "hiring assistance" efforts to more countries. They have contracted Vivek and Megan to deliver meaningful data and graphs depicting:  
1. The Top 15 Nations in Average DP and GP Procrastination Scores  
2. The correlation between the counties on both top 15 lists and Age and Income  
3. And the correlation/relationship between the countries on both top 15 and Life Satisfaction and Human Development (HDI)  
  
# GitHub File Structure
**Code:** contains all the R code to produce the below conclusions.  
**Data:** contains all Datasets utilized during project. Both in its raw and manipulated/clean format.  
**Presentation:** contains the R markdown and MD file.  
**Codebook:** contains the information and commentary on the code.  
**Procrastination.csv Codebook:** this pertains specifically to the code changes to the Procrastination data.  
**README.md**  
  
## Datasets  
The following datasets are taken from data collected by Qualtrics on Procrastination as well as data scraped from public domain on the Human Development Index.  

### The Data folder contains the following:			

**1. Original Procrastination.csv -** a data frame collected from 4162 participants in a study on Procrastination based on 1-5 ranking scores of the DP, AIP, GP, SWLS (all described below).

**2. HumanDevelopment.csv	-** Scraped: http://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries - This is a list of all the countries by the Human Development Index as included in a United Nations Development Programme's Human Development Report. The latest report was released on 21 March 2017 and compiled on the basis of estimates for 2015.

  **2a.** CleanedInput_w_HDI.csv - The HDI data 

**3.** Top 15 DP Countries (Top_15_DP_Cntry.csv)

**4.** Top 15 GP Countries (Top_15_GP_Cntry.csv)

## Procrastination.csv

**Type:** Comma-separated value file
**Dimensions:** 4162 observations x 19 variables

### Variable Information, and how each variable was cleaned up:
* Rule of thumb: we made Numeric type columns missing values a "0", and Character type columns blank or "NA" values labeled "Missing".
* All columns are proper data types, whether character or numeric.

* Age: *No issues; however client only wanted to see those 18 and over, and so all under the age of 18 were removed.*
* Gender: *No issues*
* Kids: *No issues*
* Edu (Education): *No issues*
* Work Status: *No issues*
* Annual Income: *If Annual Income was "Missing" or "NA", we changed to "-0.01", so as to keep the column type Numeric.*
* Current Occupation: *There were too many observations, and so these were paired down into Industry and Title categories. If the answer was "please specify" or "0" it was replaced with "Missing".*
* How long have you held this position? Years: *Number of years in this job: If answer was a log number, we changed to integar. There were 224 observations to clean up with that issue. Also there were 42 that answered with "999", which is impractical, and so these observations were changed to "NA".*
* How long have you helpd this position? Months: Number of months in this job: *No issues.*
* Community: Size of Community: *No issues*
* Country of Residence: *Responses of "0" that were changed to "Missing". We also recatoegorized into industry and title.*
* Marital Status: *No issues*
* Number of Sons: *Represented with a number; however 274 showed up as Female, and 613 showed up as Male. This needed to be changed from Male to "1" and Female to "2".*
* Number of Daughters: *No issues.*
* All variables starting DP (scale 1-5): *No issues.*
* All variables starting AIP (scale 1-5): *No issues.*
* All variables starting GP (scale 1-5): *No issues.*
* All variables starting SWLS (scale 1-5): *No issues.*
* Do you consider yourself a procrastinator (Yes or No)? *No issues.*
* Do others consider you a procrastinator (Yes or No)? *No issues.*

### Miscellaneous Infomation:
**1. Definition of Decisional Procrastination (DP):** Decisional Procrastination distinguishes between adaptive and non-adaptive patterns of coping with challenge. One of the non-adaptive patterns is defensive avoidance, which arises when any alternative available is unsatisfactory or risky and the decision-maker does not hope to find a better solution. The individual then may try to escape from making a decision by procrastinating. Decisional Procrastination Scale (DPS) was developed within this framework of decision-making research. As implied by the name, this kind of procrastination means to put off making a decision within some specific time frame. The DP is composed of items such that respondents express an opinion on a 5-point scale (1 = strongly disagree; 5 = strongly agree).

**2. Definition of Adult Inventory Procrastination (AIP):** The AIP Scale measures the chronic tendency to postpone tasks in various situations. It examines procrastination motivated by fears (e.g., success or failure), avoidance of disclosure of skill inabilities, and performance insecurity. The AIP assesses avoidance procrastination; that is, putting off tasks to protect one’s self-esteem from possible failure. The AIP is composed of 15 Likert-scale items such that respondents express an opinion on a 5-point scale (1 = strongly disagree; 5 = strongly agree) to statements such as “I am not very good at meeting deadlines” and “I don’t get things done on time.” For seven items, scores are reversed so that high ratings indicate procrastination.

**3. Definition of General Procrastination Scale (GP):** The GP Scale is composed of 20 items that measure trait procrastination on a variety of everyday activities such that respondents express an opinion on a 5-point scale (1 = extremely uncharacteristic; 5 = extremely characteristic).

**4. Definition of Satisfaction with Life Scale (SWLS):** The SWLS is a short 5-item instrument designed to measure gloabl cognitive judgements of satisfaction with one's life. The SWLS usually requires only about one minute of a respondent's time. Expressed on a 5-point scale (1 = extremely dissatisfied; 5 = highly satisfied).

## Human Development Index http://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries 

**Type:** url
**Dimensions:** 188 observations x 5 variables

### Variable Information of Complete list of Countries:
* There are 8 tables that pulled data on Human Development by Country, there were 2 tables per Scale:
Scales:  
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
To state again, the purpose/objective of this project came from an engagement between the client LinkedIn and Vivek Viswanathan and Megan Hodges LLC. LinkedIn was in need of understanding procrastination among people in certain countries, and how that relates to age, income, life satisfaction, and human development as they look to expand their "hiring assistance" efforts to more countries. They had contracted Vivek and Megan to deliver:

**1a. The Top 15 Nations in Average DP Procrastination Scores:** 
Brunei, Panama, Qatar, Lithuania, Sri Lanka, Ecuador, Bulgaria, Austria, Slovenia, Uruguay, Finland, Portugal, Dominican Republic, Kazakhstan, and Russia 

**1b. The Top 15 Nations in Average GP Procrastination Scores:** 
Qatar, Panama, Myanmar, Sri Lanka, Poland, Austria, Turkey, Ecuador, France, Malaysia, Slovenia, Uruguay, Iceland, Portugal, and Sweden 

**1c: Countries that made both Top 15 List:** 
Qatar, Panama, Sri Lanka, Austria, Ecuador, Slovenia, Uruguay, Portugal 

**2. The correlation between the counties on both top 15 lists between Age and Income:** 
Is there a relationship between Age and Income? 

**3. And the correlation/relationship between the countries on both top 15 and Life Satisfaction and Human Development (HDI):** 
Is there a discernible relationship between SWLS and HDI? 
Yes, there is a discernible relationship and trend between Life Satisfaction (SWLS) and Human Development (HDI). The greater the HDI the more life satisfaction there is. Medium and High HDI resulted in approx the same SWLS. 

## Sources
**Human Development Index:** Wikipedia: United Nations Development Programme's Human Development Report, "Human Development Report 2016 – "Human Development for Everyone"" (PDF). HDRO (Human Development Report Office) United Nations Development Programme. pp. 198–201. Retrieved 2 September 2017.
**Procrastination Data:** Qualtrics
**Decisional Procrastination:** Janis and Mann’s (1977) conflict model of decision making. Mann’s (1982, as cited in Ferrari et al., 1995). (Mann, Burnett, Radford, & Ford, 1997). https://pdfs.semanticscholar.org/f02f/76877ec329060cad0ff8c94b5fc3f4e3e1f9.pdf
**Adult Inventory Procrastination:**  (Ferrari, 1991) (see Ferrari et al., 1995, for the complete list of items)
**General Procrastination Scale:** Lay, C. (1986). At last, my research article on procrastination. Journal of Research in
Personality, 20, 474-495. 
**Satisfaction with Life Scale:** Ed Diener, Robert A. Emmons, Randy J. Larsen and Sharon Griffin as noted in the 1985 article in the Journal of Personality Assessment. 5-point attribution: Kobau, R., Sniezek, J., Zack, M. M., Lucas, R. E., & Burns, A. (2010). Well‐being assessment: An evaluation of well‐being scales for public health and population estimates of well‐being among US adults. Applied Psychology: Health and Well-being, 2(3), 272-297. doi:http://dx.doi.org/10.1111/j.1758-0854.2010.01035.x
