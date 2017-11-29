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
library(rVest)

# R - environment
sessionInfo()

# Set Base Directory:

# Executing from Vivek's System:
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/Case_Study_2/MSDS6306_CaseStudy_2/"

# Executing from Megan's System:
BaseDir <- "/Users/megandiane/Desktop/DDS_Class/Case_Study_2/MSDS6306_CaseStudy_2"
#BaseDir <- "/Users/megandiane/Desktop/DDS_Class/Case_Study_2/MSDS6306_CaseStudy_2"

# Set Other Working Directories and File Path
DataDir <- paste(BaseDir,"Data", sep = "/")
CodeDir <- paste(BaseDir,"Code", sep = "/")
PresenatationDir <- paste(BaseDir,"Presentation", sep = "/")

ProcrastinationDataFile <- paste(DataDir, "Procrastination.csv", sep = "/")

# Read the Data File
ProcrastinationData <- read.csv(ProcrastinationDataFile, sep = ",", header = T, na.strings = "")

# Assign Column Names
names(ProcrastinationData) <- c("Age",	"Gender",	"Kids",	"Education",	"WorkStatus",	"AnnualIncome",	"CurrOccption",	"PostHeldYrs",	"PostHeldMths",	"CmmuntySize",	"CntryResdnc",	"MaritlStatus",	"SonsCnt",	"DaughtersCnt",	"D1DsnTmeWst",	"D2DelayActn",	"D3HesitatDsn",	"D4DelayDsn",	"D5PutoffDsn",	"A1BillsOnTm",	"A2OnTm4Appt",	"A3Rdy4NxtDy",	"A4RuningLate",	"A5ActvtDlyd",	"A6TmeMgmtTrg",	"A7FrndsOpn",	"A8ImpTskOnTm",	"A9MissDedlns",	"A10RnOutOfTm",	"A11DrAptOnTm",	"A12MorPnctul",	"A13RtneMntnc",	"A14SchdulLte",	"A15DldActCst",	"G1LteToTsk",	"G2LteTktPrch",	"G3PlnPrtyAhd",	"G4GetUpOnTme",	"G5PstLtrOnTm",	"G6RtrnCalls",	"G7DlyEsyTsks",	"G8PrmptDscsn",	"G9DlyTskStrt",	"G10TrvlRsh",	"G11RdyOnTme",	"G12StayOnTsk",	"G13SmlBlOnTm",	"G14PrmptRSVP",	"G15TskCmpErl",	"G16LstMntGft",	"G17DlyEsntPr",	"G18DyTskCmpl",	"G19PshTskTmr",	"G20CmpTskRlx",	"S1LfClsI2dl",	"S2LfCndExlnt",	"S3StsfdWtLf",	"S4GtImThgsLf",	"S5LvAgChgNth",	"CnsdrSlfProc",	"OthCsndrProc")

levels(ProcrastinationData$SonsCnt) <- c(levels(ProcrastinationData$SonsCnt), "1", "2")
ProcrastinationData$SonsCnt[ProcrastinationData$SonsCnt=='Male'] <- '1'
ProcrastinationData$SonsCnt[ProcrastinationData$SonsCnt=='Female'] <- '2'

ProcrastinationData[,"SonsCnt"] <- as.integer(as.character(ProcrastinationData[,"SonsCnt"]))

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

HumDevUrl <- "https://en.wikipedia.org/wiki/List_of_countries_by_Human_Development_Index#Complete_list_of_countries"

VHighHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[5]/table') %>%
  html_table(fill = T)

VHighHumDev <- data.frame(VHighHumDev[[1]])

HighHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[6]/table') %>%
  html_table(fill = T)

HighHumDev <- data.frame(HighHumDev[[1]])

MedHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[7]/table') %>%
  html_table(fill = T)

MedHumDev <- data.frame(MedHumDev[[1]])

LowHumDev <- HumDevUrl %>%
  read_html() %>%
  html_nodes(xpath='//*[@id="mw-content-text"]/div/div[8]/table') %>%
  html_table(fill = T)

LowHumDev <- data.frame(LowHumDev[[1]])
