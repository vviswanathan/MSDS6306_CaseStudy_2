# CodeBook

## This document describes the code inside MSDS6306_CaseStudy_2.R 

## We have split the code, by comments, into 7 sections: 
1. Help Functions/Constants 
2. Downloading and loading the data 
3. Cleaning the data 
4. Merging the data 
5. Manipulating the data 
6. Presenting the data graphically 
7. Writing Final data to CSV 

## 1. Help Functions/Constants 
### install packages required 
if (!require(tidyverse)) install.packages("tidyverse") 
if (!require(repmis)) install.packages("repmis") 
if (!require(dplyr)) install.packages("dplyr") 
if (!require(tidyr)) install.packages("tidyr") 
if (!require(ggplot2)) install.packages("ggplot2") 
if (!require(sqldf)) install.packages("sqldf") 
if (!require(kimisc)) install.packages("kimisc") 
if (!require(XML)) install.packages("XML") 
if (!require(RCurl)) install.packages("RCurl") 
if (!require(rvest)) install.packages("rvest") 
if (!require(plyr)) install.packages("plyr") 
if (!require(pastecs)) install.packages("pastecs") 

### Load Libraries 
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

### Executing from Vivek's System:
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/Case_Study_2/MSDS6306_CaseStudy_2/"

### Executing from Megan's System:
BaseDir <- "/Users/megandiane/Desktop/DDS_Class/Case_Study_2/MSDS6306_CaseStudy_2"

### Set Other Working Directories and File Path
DataDir <- paste(BaseDir,"Data", sep = "/")
CodeDir <- paste(BaseDir,"Code", sep = "/")
PresenatationDir <- paste(BaseDir,"Presentation", sep = "/")

## 2. Downloading and loading the data
### Read the CSV file, and see how many Rows and Columns there are: 
ProcrastinationData <- read.csv(ProcrastinationDataFile, sep = ",", header = T, na.strings = "")

dim(ProcrastinationData)
### The column names in the ProcrastinationData are too long, so we shortened the Column names to 12 characters and removed any special characters:
names(ProcrastinationData) <- c("Age", "Gender", "Kids", "Education", "WorkStatus", 
                                "AnnualIncome", "CurrOccption", "PostHeldYrs", "PostHeldMths", 
                                "CmmuntySize", "CntryResdnc", "MaritlStatus", "SonsCnt", 
                                "DaughtersCnt", "D1DsnTmeWst", "D2DelayActn", "D3HesitatDsn", 
                                "D4DelayDsn", "D5PutoffDsn", "A1BillsOnTm", "A2OnTm4Appt", 
                                "A3Rdy4NxtDy", "A4RuningLate", "A5ActvtDlyd", "A6TmeMgmtTrg", 
                                "A7FrndsOpn", "A8ImpTskOnTm", "A9MissDedlns", "A10RnOutOfTm", 
                                "A11DrAptOnTm", "A12MorPnctul", "A13RtneMntnc", "A14SchdulLte", 
                                "A15DldActCst", "G1LteToTsk", "G2LteTktPrch", "G3PlnPrtyAhd", 
                                "G4GetUpOnTme", "G5PstLtrOnTm", "G6RtrnCalls", "G7DlyEsyTsks", 
                                "G8PrmptDscsn", "G9DlyTskStrt", "G10TrvlRsh", "G11RdyOnTme", 
                                "G12StayOnTsk", "G13SmlBlOnTm", "G14PrmptRSVP", "G15TskCmpErl", 
                                "G16LstMntGft", "G17DlyEsntPr", "G18DyTskCmpl", "G19PshTskTmr", 
                                "G20CmpTskRlx", "S1LfClsI2dl", "S2LfCndExlnt", "S3StsfdWtLf", 
                                "S4GtImThgsLf", "S5LvAgChgNth", "CnsdrSlfProc", "OthCsndrProc")

## 3. Cleaning the data
The Procrastination Data csv had a lot of manipulation in it, and can be found in the Procrastination.csv CODEBOOK

After scraping the data from https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries the data needed a lot of manipulation to get it into a format from 8 table to one table displaying Country, and (2016 Estimates for 2015) HDI score. We only pulled data from the section titled "Complete List of Countries".

#Scrap Data from Wikipedia: List of Countries By Human Development Index
HumDevUrl <- "https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries"

We then needed to manipulate each section of "Very High Humand Development", "High Human Development", "Medium Human Development", and "Low Human Development". We placed each into a dataframe, removed unnecessary rows and columns. We renamed the columns to make sense for our project: "Rank", "Country", and "HDI", and lastly removed any unused enviornment variables.

#Very High Human Development
VHighHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[5]/table') %>%
  html_table(fill = T)

VHighHumDev <- data.frame(VHighHumDev[[1]])

#Remove Unnecessary Rows
VHighHumDev_1Head <- VHighHumDev[-c(1,2,3,30,31), ]

#Remove Unnecessary Columns
VHighHumDev[2] <- list(NULL)
VHighHumDev_Clean <- VHighHumDev_1Head[,c(1,3,4)]

#Rename Columns
VHighHumDev <- rename(VHighHumDev_Clean, c("X1"="Rank", "X3"="Country", "X4"="HDI"))

VHighHumDev$HumDev_Categ <- "VHigh"

VHighHumDev[,"HDI"] <- as.numeric(VHighHumDev[,"HDI"])

# Remove Unused Environment Variables
rm(VHighHumDev_1Head, VHighHumDev_Clean)

#High Human Development
HighHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[6]/table') %>%
  html_table(fill = T)

HighHumDev <- data.frame(HighHumDev[[1]])

#Remove Unnecessary Rows
HighHumDev_1Head <- HighHumDev[-c(1,2,3,32,33), ]

#Remove Unnecessary Columns
HighHumDev[2] <- list(NULL)
HighHumDev_Clean <- HighHumDev_1Head[,c(1,3,4)]

#Rename Columns
HighHumDev <- rename(HighHumDev_Clean, c("X1"="Rank", "X3"="Country", "X4"="HDI"))

HighHumDev$HumDev_Categ <- "High"

HighHumDev[,"HDI"] <- as.numeric(HighHumDev[,"HDI"])

# Remove Unused Environment Variables
rm(HighHumDev_1Head, HighHumDev_Clean)

#Medium Human Development
MedHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[7]/table') %>%
  html_table(fill = T)

MedHumDev <- data.frame(MedHumDev[[1]])

#Remove Unnecessary Rows
MedHumDev_1Head <- MedHumDev[-c(1,2,3,24,25), ]

#Remove Unnecessary Columns
MedHumDev[2] <- list(NULL)
MedHumDev_Clean <- MedHumDev_1Head[,c(1,3,4)]

#Rename Columns
MedHumDev <- rename(MedHumDev_Clean, c("X1"="Rank", "X3"="Country", "X4"="HDI"))

MedHumDev$HumDev_Categ <- "Med"

MedHumDev[,"HDI"] <- as.numeric(MedHumDev[,"HDI"])

# Remove Unused Environment Variables
rm(MedHumDev_1Head, MedHumDev_Clean)

#Low Human Development
LowHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[8]/table') %>%
  html_table(fill = T)

LowHumDev <- data.frame(LowHumDev[[1]])

#Remove Unnecessary Rows
LowHumDev_1Head <- LowHumDev[-c(1,2,3,25,26), ]

#Remove Unnecessary Columns
LowHumDev[2] <- list(NULL)
LowHumDev_Clean <- LowHumDev_1Head[,c(1,3,4)]

#Rename Columns
LowHumDev <- rename(LowHumDev_Clean, c("X1"="Rank", "X3"="Country", "X4"="HDI"))

LowHumDev$HumDev_Categ <- "Low"

LowHumDev[,"HDI"] <- as.numeric(LowHumDev[,"HDI"])

#Remove Unused Environment Variables
rm(LowHumDev_1Head, LowHumDev_Clean)

We then combimed the four dataframes, into one dataframe.
#Combine the Four Data Frames
Total_HumDev <- rbind(VHighHumDev, HighHumDev, MedHumDev, LowHumDev)

Total_HumDev <- within(Total_HumDev, rm("Rank"))

#Remove Unused Environment Variables
rm(VHighHumDev, HighHumDev, MedHumDev, LowHumDev)
## 4. Merging the data
## 5. Manipulating the data
## 6. Presenting the data graphically
## 7. Writing Final data to CSV
