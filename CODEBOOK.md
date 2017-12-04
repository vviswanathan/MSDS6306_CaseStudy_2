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

##1. Help Functions/Constants 
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

##2. Downloading and loading the data
##3. Cleaning the data
##4. Merging the data
##5. Manipulating the data
##6. Presenting the data graphically
7. Writing Final data to CSV
