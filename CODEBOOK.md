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

## 4. Merging the data
## 5. Manipulating the data
## 6. Presenting the data graphically
## 7. Writing Final data to CSV
