#install packages required
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

# Load Libraries
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

# R - environment
sessionInfo()

# Set Base Directory:

# Executing from Vivek's System:
# BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/Case_Study_2/MSDS6306_CaseStudy_2/"

# Executing from Megan's System:
BaseDir <- "/Users/megandiane/Desktop/DDS_Class/Case_Study_2/MSDS6306_CaseStudy_2"

# Set Other Working Directories and File Path
DataDir <- paste(BaseDir,"Data", sep = "/")
CodeDir <- paste(BaseDir,"Code", sep = "/")
PresenatationDir <- paste(BaseDir,"Presentation", sep = "/")

ProcrastinationDataFile <- paste(DataDir, "Procrastination.csv", sep = "/")

# Read the Data File
ProcrastinationData <- read.csv(ProcrastinationDataFile, sep = ",", header = T, na.strings = "")

# Assign Column Names
names(ProcrastinationData) <- c("Age",	"Gender",	"Kids",	"Education",	"WorkStatus",	"AnnualIncome",	"CurrOccption",	"PostHeldYrs",	"PostHeldMths",	"CmmuntySize",	"CntryResdnc",	"MaritlStatus",	"SonsCnt",	"DaughtersCnt",	"D1DsnTmeWst",	"D2DelayActn",	"D3HesitatDsn",	"D4DelayDsn",	"D5PutoffDsn",	"A1BillsOnTm",	"A2OnTm4Appt",	"A3Rdy4NxtDy",	"A4RuningLate",	"A5ActvtDlyd",	"A6TmeMgmtTrg",	"A7FrndsOpn",	"A8ImpTskOnTm",	"A9MissDedlns",	"A10RnOutOfTm",	"A11DrAptOnTm",	"A12MorPnctul",	"A13RtneMntnc",	"A14SchdulLte",	"A15DldActCst",	"G1LteToTsk",	"G2LteTktPrch",	"G3PlnPrtyAhd",	"G4GetUpOnTme",	"G5PstLtrOnTm",	"G6RtrnCalls",	"G7DlyEsyTsks",	"G8PrmptDscsn",	"G9DlyTskStrt",	"G10TrvlRsh",	"G11RdyOnTme",	"G12StayOnTsk",	"G13SmlBlOnTm",	"G14PrmptRSVP",	"G15TskCmpErl",	"G16LstMntGft",	"G17DlyEsntPr",	"G18DyTskCmpl",	"G19PshTskTmr",	"G20CmpTskRlx",	"S1LfClsI2dl",	"S2LfCndExlnt",	"S3StsfdWtLf",	"S4GtImThgsLf",	"S5LvAgChgNth",	"CnsdrSlfProc",	"OthCsndrProc")

# To Clean up the data from Procrastination.csv we took the "Male" and "Female" that we found under the Column of "Sons" and
# replaced it with the correct response of 1 = Male and 2 = Female.
levels(ProcrastinationData$SonsCnt) <- c(levels(ProcrastinationData$SonsCnt), "1", "2")
ProcrastinationData$SonsCnt[ProcrastinationData$SonsCnt=='Male'] <- '1'
ProcrastinationData$SonsCnt[ProcrastinationData$SonsCnt=='Female'] <- '2'

ProcrastinationData[,"SonsCnt"] <- as.integer(as.character(ProcrastinationData[,"SonsCnt"]))

#To Clean up the data from Procrastination.csv we did the folowing:
#1. If Annual Income was blank, we filled with a -0.01, that way we could easily differentiate from true data, and keep as a numerical data type 
#2. If the Country of Residence was filled with a "0", we filled with "Missing", to keep as a character data type
#3. If Current Occupation was filled with "0" or "please specify", we filled with "Missing", to keep as a character data type

#4. For all of the Procrastination Scales: DP, AIP, GP, and SWLS, the means were taken and columns added to reflect those means.
#   This Mean data is to be used later on.
ProcTrans <- ProcrastinationData %>% 
  mutate(AnnualIncome=replace(AnnualIncome, is.na(AnnualIncome), -0.01)) %>%
  mutate_if(is.numeric, funs(ifelse(is.na(.), 0, .))) %>% 
  mutate_if(is.character, funs(ifelse(is.na(.), "Missing", .))) %>% 
  mutate_if(is.factor, funs(ifelse(is.na(.), "Missing", as.character(.)))) %>%
  mutate(CntryResdnc=replace(CntryResdnc, CntryResdnc=="0", "Missing")) %>%
  mutate(CurrOccption=replace(CurrOccption, (CurrOccption=="0" | CurrOccption=="please specify"), "Missing")) %>%
  mutate(DPMean=rowMeans(ProcrastinationData[c('D1DsnTmeWst', 'D2DelayActn', 'D3HesitatDsn', 'D4DelayDsn', 'D5PutoffDsn')], na.rm=TRUE)) %>%
  mutate(AIPMean=rowMeans(ProcrastinationData[c('A1BillsOnTm', 'A2OnTm4Appt', 'A3Rdy4NxtDy', 'A4RuningLate', 'A5ActvtDlyd', 'A6TmeMgmtTrg', 'A7FrndsOpn', 'A8ImpTskOnTm', 'A9MissDedlns', 'A10RnOutOfTm', 'A11DrAptOnTm', 'A12MorPnctul', 'A13RtneMntnc', 'A14SchdulLte', 'A15DldActCst')], na.rm=TRUE)) %>%
  mutate(GPMean=rowMeans(ProcrastinationData[c('G1LteToTsk', 'G2LteTktPrch', 'G3PlnPrtyAhd', 'G4GetUpOnTme', 'G5PstLtrOnTm', 'G6RtrnCalls', 'G7DlyEsyTsks', 'G8PrmptDscsn', 'G9DlyTskStrt', 'G10TrvlRsh', 'G11RdyOnTme', 'G12StayOnTsk', 'G13SmlBlOnTm', 'G14PrmptRSVP', 'G15TskCmpErl', 'G16LstMntGft', 'G17DlyEsntPr', 'G18DyTskCmpl', 'G19PshTskTmr', 'G20CmpTskRlx')], na.rm=TRUE)) %>% 
  mutate(SWLSMean=rowMeans(ProcrastinationData[c('S1LfClsI2dl', 'S2LfCndExlnt', 'S3StsfdWtLf', 'S4GtImThgsLf', 'S5LvAgChgNth')], na.rm=TRUE))


sapply(ProcTrans, class)

#Remove all Participants who are under 18
ProcTrans <- ProcTrans[ProcTrans$Age !=1-18, ]
ProcTrans <- ProcTrans[ProcTrans$Age !=7.5, ]
ProcTrans <- ProcTrans[ProcTrans$Age !=16.5, ]

#Also chose to remove all Age of Zero (0) because our client is looking for Procrastination as it relates to positions held, how long, and annual income, and all observations with Zero Age, also did not have jobs listed
ProcTrans <- ProcTrans[ProcTrans$Age !=0, ]

#Rename Column CntryResdnc to Country for later Merge
ProcTransCntry <- rename(ProcTrans, c("CntryResdnc"="Country"))

#Scrap Data from Wikipedia: List of Countries By Human Development Index
HumDevUrl <- "https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries"

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

#Combine the Four Data Frames
Total_HumDev <- list(VHighHumDev, HighHumDev, MedHumDev, LowHumDev)
Total_HumDev <- Reduce(function(x, y) merge(x, y, all=TRUE), Total_HumDev, accumulate = FALSE)

#Add new HumDevScore Column and Score variables
Total_HumDev["HumDev_Score"] <- NA
Total_HumDev$HumDev_Score <- with(Total_HumDev, ifelse(HDI >=.800, "VHigh", ifelse(HDI <=.796 & HDI >=.701, "High", ifelse(HDI <=.699 & HDI >=.550, "Med", ifelse(HDI <=.541, "Low", "na")))))

#Prior to the Merge of both datasets, Remove Unnecessary Columns for 4B: Preliminary Analysis of Age, Income, HDI, and the means of DP, et
ProcTransCntry_Clean1 <- ProcTransCntry[c("Age", "AnnualIncome", "Country", "DPMean", "AIPMean", "GPMean", "SWLSMean")]

#Merge Cleaned Procrastination Data in 4B with HDI data
MergedData_DescripStats <- merge(ProcTransCntry_Clean1, Total_HumDev, by=c("Country"))

#Histogram of Age and Income from 4B Prelim Analysis
MergedData_DescripStats1 <- hist(MergedData_DescripStats$Age, main="Histogram of Age and Income", xlab="Age", border="Black", col="Green") 
MergedData_DescripStats2 <- hist(MergedData_DescripStats$AnnualIncome, xlab="Annual Income", border="Black", col="Blue")

ggplot(MergedData_DescripStats, aes(age, fill = Age, AnnualIncome)) + geom_histogram(alpha = 0.5)

#Remove Unnecessary Columns for 4C:  Preliminary Analysis of Gender, Work Status, and Occupation
ProcTransCntry_Clean2 <- ProcTransCntry[c("Gender","WorkStatus", "CurrOccption")]

#Frequency of Gender: Male or Female, Work Status, and Current Occupation
count(ProcTransCntry_Clean2, "Gender")
count(ProcTransCntry_Clean2, "WorkStatus")
count(ProcTransCntry_Clean2, "CurrOccption")

#Frequency of how many participants per country in descending order
count(ProcTransCntry, "Country", decreasing=TRUE)

ProcTransCntryDesc <- ProcTransCntry %>% 
  filter(!is.na(Country) & Country != "NULL") %>% 
  group_by(Country) %>% tally(sort=T) %>% 
  ungroup() %>% 
  arrange(desc(n))
ProcTransCntryDesc

#Do People who consider themselves Procrastinators, do others consider them Procrastinators
#Preliminary Analysis of Procrastination Variables, 2 other them, 4e
ProcTransCntry_Clean3 <- ProcTransCntry[c("CnsdrSlfProc","OthCsndrProc")]
counts <- ddply(ProcTransCntry_Clean3, .(ProcTransCntry_Clean3$CnsdrSlfProc, ProcTransCntry_Clean3$OthCsndrProc), nrow)
names(counts) <- c("CnsdrSlfProc", "OthCsndrProc", "Freq")

#Answer: 482 answered NO/NO
# 2358 answered YES/YES





