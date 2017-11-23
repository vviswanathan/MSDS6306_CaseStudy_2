# Load Libraries
library(repmis)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

# R - environment
sessionInfo()

# Set Base Directory:

# Executing from Vivek's System:
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/Case_Study_2/MSDS6306_CaseStudy_2/"

# Executing from Megan's System:
BaseDir <- "/Users/megandiane/Desktop/DDS_Class/Case_Study_2"

# Set Other Working Directories and File Path
DataDir <- paste(BaseDir,"Data", sep = "/")
CodeDir <- paste(BaseDir,"Code", sep = "/")
PresenatationDir <- paste(BaseDir,"Presentation", sep = "/")

ProcrastinationDataFile <- paste(DataDir, "Procrastination.csv", sep = "/")

# Read the Data File
ProcrastinationData <- read.csv(ProcrastinationDataFile, sep = ",", header = T)
