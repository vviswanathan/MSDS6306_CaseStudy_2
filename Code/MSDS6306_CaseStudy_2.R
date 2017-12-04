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
if (!require(pastecs)) install.packages("pastecs")

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
library(pastecs)

# R - environment
sessionInfo()

# Set Base Directory:

# Executing from Vivek's System:
BaseDir <- "C:/Vivek/Data_Science/MSDS6306-DoingDataScience/Case_Study_2/MSDS6306_CaseStudy_2/"

# Executing from Megan's System:
# BaseDir <- "/Users/megandiane/Desktop/DDS_Class/Case_Study_2/MSDS6306_CaseStudy_2"

# Set Other Working Directories and File Path
DataDir <- paste(BaseDir,"Data", sep = "/")
CodeDir <- paste(BaseDir,"Code", sep = "/")
PresenatationDir <- paste(BaseDir,"Presentation", sep = "/")

ProcrastinationDataFile <- paste(DataDir, "Procrastination.csv", sep = "/")

# Read the Data File
ProcrastinationData <- read.csv(ProcrastinationDataFile, sep = ",", header = T, na.strings = "")

dim(ProcrastinationData)

# Assign Column Names
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

# To Clean up the data from Procrastination.csv we took the "Male" and "Female" that we found under the Column of "Sons" and
# replaced it with the correct response of 1 = Male and 2 = Female.
levels(ProcrastinationData$SonsCnt) <- c(levels(ProcrastinationData$SonsCnt), "1", "2")
ProcrastinationData$SonsCnt[ProcrastinationData$SonsCnt=='Male'] <- '1'
ProcrastinationData$SonsCnt[ProcrastinationData$SonsCnt=='Female'] <- '2'

ProcrastinationData[,"SonsCnt"] <- as.integer(as.character(ProcrastinationData[,"SonsCnt"]))
ProcrastinationData[,"PostHeldYrs"] <- as.integer(ProcrastinationData[,"PostHeldYrs"])

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
  mutate(PostHeldYrs=replace(PostHeldYrs, PostHeldYrs==999, NA)) %>%
  mutate(CurrOccption=replace(CurrOccption, 
                              (CurrOccption=="0" | CurrOccption=="please specify"), 
                              "Missing")) %>%
  mutate(DPMean=rowMeans(ProcrastinationData[c('D1DsnTmeWst', 'D2DelayActn', 'D3HesitatDsn', 
                                               'D4DelayDsn', 'D5PutoffDsn')], na.rm=TRUE)) %>%
  mutate(AIPMean=rowMeans(ProcrastinationData[c('A1BillsOnTm', 'A2OnTm4Appt', 'A3Rdy4NxtDy', 
                                                'A4RuningLate', 'A5ActvtDlyd', 'A6TmeMgmtTrg', 
                                                'A7FrndsOpn', 'A8ImpTskOnTm', 'A9MissDedlns', 
                                                'A10RnOutOfTm', 'A11DrAptOnTm', 'A12MorPnctul', 
                                                'A13RtneMntnc', 'A14SchdulLte', 'A15DldActCst')], 
                          na.rm=TRUE)) %>%
  mutate(GPMean=rowMeans(ProcrastinationData[c('G1LteToTsk', 'G2LteTktPrch', 'G3PlnPrtyAhd', 
                                               'G4GetUpOnTme', 'G5PstLtrOnTm', 'G6RtrnCalls', 
                                               'G7DlyEsyTsks', 'G8PrmptDscsn', 'G9DlyTskStrt', 
                                               'G10TrvlRsh', 'G11RdyOnTme', 'G12StayOnTsk', 
                                               'G13SmlBlOnTm', 'G14PrmptRSVP', 'G15TskCmpErl', 
                                               'G16LstMntGft', 'G17DlyEsntPr', 'G18DyTskCmpl', 
                                               'G19PshTskTmr', 'G20CmpTskRlx')], na.rm=TRUE)) %>% 
  mutate(SWLSMean=rowMeans(ProcrastinationData[c('S1LfClsI2dl', 'S2LfCndExlnt', 'S3StsfdWtLf', 
                                                 'S4GtImThgsLf', 'S5LvAgChgNth')], na.rm=TRUE))


sapply(ProcTrans, class)

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

# Remove Unused Environment Variables
rm(LowHumDev_1Head, LowHumDev_Clean)

#Combine the Four Data Frames
Total_HumDev <- rbind(VHighHumDev, HighHumDev, MedHumDev, LowHumDev)

Total_HumDev <- within(Total_HumDev, rm("Rank"))

# Remove Unused Environment Variables
rm(VHighHumDev, HighHumDev, MedHumDev, LowHumDev)

ProcTrans[grep("(teacher)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Teacher"
ProcTrans[grep("(accountant)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Accountant"
ProcTrans[grep("(professor)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Professor"
ProcTrans[grep("(engineer)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Engineer"
ProcTrans[grep("(manager)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Manager"
ProcTrans[grep("(retired)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Retired"
ProcTrans[grep("(marketing)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Marketing"
ProcTrans[grep("(attorney)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Attorney"
ProcTrans[grep("(doctor)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Doctor"
ProcTrans[grep("(student)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Student"
ProcTrans[grep("(writer)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Writer"
ProcTrans[grep("(developer)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Developer"
ProcTrans[grep("(nurse)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Nurse"
ProcTrans[grep("(consultant)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Consultant"
ProcTrans[grep("(scientist)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Scientist"
ProcTrans[grep("(admin)+", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Administrator"
ProcTrans[grep("(Financial)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Finance"
ProcTrans[grep("(director)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Director"
ProcTrans[grep("(customer service)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Customer Service"
ProcTrans[grep("(libra)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Librarian"
ProcTrans[grep("(Business / Test Analyst)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "BA"
ProcTrans[grep("(Business Systems Analyst)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "BA"
ProcTrans[grep("(BUSINESS CONSULTA)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "BA"
ProcTrans[grep("(busi)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Business Owner"
ProcTrans[grep("(artist)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Artist"
ProcTrans[grep("(web)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Website Designer"
ProcTrans[grep("(prog)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Programmer"
ProcTrans[grep("(vp)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Vice President"
ProcTrans[grep("(train)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Trainer"
ProcTrans[grep("(technician)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Technician"
ProcTrans[grep("(CTO))", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "CTO"
ProcTrans[grep("(technici)", ProcTrans$CurrOccption, ignore.case = T), "CurrOccption"] <- "Technician"

#Merge this data frame to the Country of Residence column of Procrastination.csv so that your data now has an HDI column and HDI categories
Merged_ProctransHumDev <- merge(ProcTrans, Total_HumDev, by.x=c("CntryResdnc"), by.y = c("Country"))

#Remove all Participants who are under 18
#Also chose to remove all Age of Zero (0) because our client is looking for Procrastination as it relates to positions held, how long, and annual income, and all observations with Zero Age, also did not have jobs listed
Merged_ProctransHumDev <- Merged_ProctransHumDev[Merged_ProctransHumDev$Age >= 18.0, ]

unique(format(Merged_ProctransHumDev$Age, digits = 10))

Merged_ProctransHumDev_DescripStats <- Merged_ProctransHumDev[c("Age", "AnnualIncome", "HDI",
                                                                "DPMean", "AIPMean",
                                                                "GPMean", "SWLSMean")]

options(scipen=100)
options(digits=2)
ProctransHumDev_DescripStats <- stat.desc(Merged_ProctransHumDev_DescripStats)
ProctransHumDev_DescripStats

hist(Merged_ProctransHumDev_DescripStats$DPMean)
hist(Merged_ProctransHumDev_DescripStats$GPMean)

# Remove Unused Environment Variables
rm(Merged_ProctransHumDev_DescripStats, ProctransHumDev_DescripStats)

Cnt_By_Gender <- as.data.frame(table(Merged_ProctransHumDev$Gender))
Cnt_By_Gender
Cnt_By_WorkStatus <- as.data.frame(table(Merged_ProctransHumDev$WorkStatus))
Cnt_By_WorkStatus
Cnt_By_Curr_Occupation <- as.data.frame(table(Merged_ProctransHumDev$CurrOccption))
Cnt_By_Curr_Occupation

Cnt_By_CntryResdnc <- Merged_ProctransHumDev %>%
  group_by(CntryResdnc) %>% 
  do(data.frame(nrow=nrow(.))) %>%
  arrange(desc(nrow))

Cnt_By_CntryResdnc

Merged_ProctransHumDev %>%
  group_by(CnsdrSlfProc, OthCsndrProc) %>% 
  do(data.frame(nrow=nrow(.))) %>%
  arrange(desc(nrow)) %>%
  filter((CnsdrSlfProc == "yes" & OthCsndrProc == "yes") 
         | (CnsdrSlfProc == "no" & OthCsndrProc == "no"))

DP_Top15 <- aggregate(DPMean ~ CntryResdnc+HDI, Merged_ProctransHumDev, mean) %>%
  arrange(desc(DPMean)) %>%
  head(n=15)

ggplot(data = merge(Merged_ProctransHumDev, within(DP_Top15, rm("DPMean", "HDI")), by = "CntryResdnc")) +
  geom_bar(aes(x=reorder(CntryResdnc,-DPMean,mean), DPMean, fill = HumDev_Categ),
           stat = "summary", fun.y = "mean", show.legend = T) + 
  xlab("Country") + ylab("DPMean") + 
  ggtitle("Top 15 Countries of DP Procrastination Mean Scale") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5))


GP_Top15 <- aggregate(GPMean ~ CntryResdnc+HDI, Merged_ProctransHumDev, mean) %>%
  arrange(desc(GPMean)) %>%
  head(n=15)

ggplot(data = merge(Merged_ProctransHumDev, within(GP_Top15, rm("GPMean", "HDI")), by = "CntryResdnc")) +
  geom_bar(aes(x=reorder(CntryResdnc,-GPMean,mean), GPMean, fill = HumDev_Categ),
           stat = "summary", fun.y = "mean", show.legend = T) + 
  xlab("Country") + ylab("GPMean") + 
  ggtitle("Top 15 Countries of GP Procrastination Mean Scale") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5)) + ylim(0,5)

GP_DP_Common_Cntry <- as.data.frame(intersect(DP_Top15$CntryResdnc, GP_Top15$CntryResdnc))
dim(as.data.frame(GP_DP_Common_Cntry))
names(GP_DP_Common_Cntry) <- c("CommonCntry")
GP_DP_Common_Cntry

plot(Merged_ProctransHumDev$Age, Merged_ProctransHumDev$AnnualIncome, 
     xlab="Age", ylab="Annual Income", 
     main="Age vs Annual Income", pch=2, cex.main=1.5, 
     frame.plot=FALSE, col=ifelse(Merged_ProctransHumDev$Gender=="Male", "red", "blue"))

legend("topleft", pch=c(2,2), col=c("red", "blue"), 
       c("Male", "Female"), bty="o",  box.col="darkgreen", cex=.8)

ggplot(Merged_ProctransHumDev, aes(x=Age,y=AnnualIncome,color=Gender)) + 
  geom_point()+ geom_smooth(method = lm) + 
  xlab("Age") + ylab("Annual Income") + 
  ggtitle("Age vs Annual Income plot for all countries") +
  theme(plot.title = element_text(hjust = 0.5))


ggplot(data = merge(Merged_ProctransHumDev, GP_DP_Common_Cntry, x.by = "CntryResdnc", y.by = "CommonCntry")) +
  aes(x=Age,y=AnnualIncome,color=Gender) + 
  geom_point()+ geom_smooth(method = lm) + 
  xlab("Age") + ylab("Annual Income") + 
  ggtitle("Age vs Annual Income plot for the 8 countries \ncommon between Top 15 DP and GP countries") +
  theme(plot.title = element_text(hjust = 0.5))

plot(Merged_ProctransHumDev$SWLSMean, Merged_ProctransHumDev$HDI, 
     xlab="SWLSMean", ylab="HDI", ylim = c(0,1),
     main="SWLSMean vs HDI", pch=2, cex.main=1.5, 
     frame.plot=FALSE, col=ifelse(Merged_ProctransHumDev$Gender=="Male", "red", "blue"))

ggplot(Merged_ProctransHumDev, aes(x=SWLSMean,y=HDI,color=Gender)) + 
  geom_point()+ geom_smooth(method = lm) + 
  xlab("HDI Category") + ylab("SWLSMean") + 
  ggtitle("Scatterplot of Mean Life Satisfaction by \nHuman Development Index Category by Gender") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5))

ggplot(Merged_ProctransHumDev) +
  geom_bar(aes(x=reorder(HumDev_Categ,-SWLSMean,mean), SWLSMean, fill = HumDev_Categ),
           stat = "summary", fun.y = "mean", show.legend = T) + 
  xlab("HDI Category") + ylab("SWLSMean") + 
  ggtitle("Bar Chart of Mean Life Satisfaction by \nHuman Development Index Category") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5))


LS_Top15 <- aggregate(SWLSMean ~ CntryResdnc+HDI, Merged_ProctransHumDev, mean) %>%
  arrange(desc(SWLSMean)) %>%
  head(n=15)

ggplot(data = merge(Merged_ProctransHumDev, within(LS_Top15, rm("SWLSMean", "HDI")), by = "CntryResdnc")) +
  geom_bar(aes(x=reorder(CntryResdnc,-SWLSMean,mean), SWLSMean, fill = HumDev_Categ),
           stat = "summary", fun.y = "mean", show.legend = T) + 
  xlab("Country") + ylab("SWLSMean") + 
  ggtitle("Top 15 Countries of LS Procrastination Mean Scale") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  theme(plot.title = element_text(hjust = 0.5)) + ylim(0,5)

#Write the Human Development Data to CSV
HumDevDataFile <- paste(DataDir, "HumanDevelopment.csv", sep = "/")
write.table(Total_HumDev,HumDevDataFile,row.names=F, col.names = T, sep = ",")

#Write the Cleaned Input Data with HDI to CSV
CleanInputData_w_HDI_File <- paste(DataDir, "CleanedInput_w_HDI.csv", sep = "/")
write.table(Merged_ProctransHumDev,CleanInputData_w_HDI_File,row.names=F, col.names = T, sep = ",")

#Write the Human Development Data to CSV
Top_15_DP <- paste(DataDir, "Top_15_DP_Cntry.csv", sep = "/")
write.table(DP_Top15, Top_15_DP,row.names=F, col.names = T, sep = ",")

#Write the Cleaned Input Data with HDI to CSV
Top_15_GP <- paste(DataDir, "Top_15_GP_Cntry.csv", sep = "/")
write.table(GP_Top15, Top_15_GP,row.names=F, col.names = T, sep = ",")

# Remove Unused Environment Variables
rm(Total_HumDev, Merged_ProctransHumDev, DP_Top15, GP_Top15, LS_Top15, GP_DP_Common_Cntry, 
   Cnt_By_CntryResdnc, Cnt_By_Curr_Occupation, Cnt_By_Gender, Cnt_By_WorkStatus, ProcTrans,
   ProcrastinationData, CleanInputData_w_HDI_File, HumDevDataFile, Top_15_DP, Top_15_GP)

rm(BaseDir, CodeDir, DataDir, HumDevUrl, PresenatationDir, ProcrastinationDataFile)
