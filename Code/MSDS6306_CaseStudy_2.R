# Load Libraries
library(repmis)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)
library(sqldf)
library(kimisc)

# R - environment
sessionInfo()

# Set Base Directory:

# Executing from Vivek's System:
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/Case_Study_2/MSDS6306_CaseStudy_2/"

# Executing from Megan's System:
#BaseDir <- ""

# Set Other Working Directories and File Path
DataDir <- paste(BaseDir,"Data", sep = "/")
CodeDir <- paste(BaseDir,"Code", sep = "/")
PresenatationDir <- paste(BaseDir,"Presentation", sep = "/")

ProcrastinationDataFile <- paste(DataDir, "Procrastination.csv", sep = "/")

# Read the Data File
ProcrastinationData <- read.csv(ProcrastinationDataFile, sep = ",", header = T, na.strings = "")

# Assign Column Names
names(ProcrastinationData) <- c("Age",	"Gender",	"Kids",	"Education",	"WorkStatus",	"AnnualIncome",	"CurrOccption",	"PostHeldYrs",	"PostHeldMths",	"CmmuntySize",	"CntryResdnc",	"MaritlStatus",	"SonsCnt",	"DaughtersCnt",	"D1DsnTmeWst",	"D2DelayActn",	"D3HesitatDsn",	"D4DelayDsn",	"D5PutoffDsn",	"A1BillsOnTm",	"A2OnTm4Appt",	"A3Rdy4NxtDy",	"A4RuningLate",	"A5ActvtDlyd",	"A6TmeMgmtTrg",	"A7FrndsOpn",	"A8ImpTskOnTm",	"A9MissDedlns",	"A10RnOutOfTm",	"A11DrAptOnTm",	"A12MorPnctul",	"A13RtneMntnc",	"A14SchdulLte",	"A15DldActCst",	"G1LteToTsk",	"G2LteTktPrch",	"G3PlnPrtyAhd",	"G4GetUpOnTme",	"G5PstLtrOnTm",	"G6RtrnCalls",	"G7DlyEsyTsks",	"G8PrmptDscsn",	"G9DlyTskStrt",	"G10TrvlRsh",	"G11RdyOnTme",	"G12StayOnTsk",	"G13SmlBlOnTm",	"G14PrmptRSVP",	"G15TskCmpErl",	"G16LstMntGft",	"G17DlyEsntPr",	"G18DyTskCmpl",	"G19PshTskTmr",	"G20CmpTskRlx",	"S1LfClsI2dl",	"S2LfCndExlnt",	"S3StsfdWtLf",	"S4GtImThgsLf",	"S5LvAgChgNth",	"CnsdrSlfProc",	"OthCsndrProc")

ProcTrans <- ProcrastinationData %>% 
  mutate_if(is.numeric, funs(ifelse(is.na(.), 0, .))) %>% 
  mutate_if(is.character, funs(ifelse(is.na(.), "Missing", .))) %>% 
  mutate_if(is.factor, funs(ifelse(is.na(.), "Missing", as.character(.))))

