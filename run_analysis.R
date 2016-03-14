# GETTING AND CLEANING DATA ASSIGNMENT
# run_analysis.R
# Make sure the working directory is the parent directory.

# Read in Activity Labels
act_lbl <- read.table("activity_labels.txt")
# Read Variables Name Table / Select only mean() and std() Variables
features <- read.table("features.txt", stringsAsFactors = FALSE)
features<- features[grepl("std",features[,2], ignore.case=TRUE) | grepl("mean()",features[,2],fixed=TRUE),]

# Clean up Variable Names for Legibility
features[,2]<-gsub("()","",features[,2],fixed=TRUE)
features[,2]<-gsub("^t","Time-Domain ",features[,2])
features[,2]<-gsub("^f","Freq-Domain ",features[,2])
features[,2]<-gsub("Acc"," Acceleration ",features[,2])
features[,2]<-gsub("-mean"," Mean ",features[,2])
features[,2]<-gsub("-std-"," StdDeviation ",features[,2])
features[,2]<-gsub("-std"," StdDeviation",features[,2])
features[,2]<-gsub("-X"," X",features[,2])
features[,2]<-gsub("-Y"," Y",features[,2])
features[,2]<-gsub("-Z"," Z",features[,2])
features[,2]<-gsub("BodyGyro","Body Gyro",features[,2])
features[,2]<-gsub("BodyGyroJerk","Body Gyro Jerk",features[,2])
features[,2]<-gsub("JerkMag","Jerk Magnitude",features[,2])
features[,2]<-gsub("GyroJerk","Gyro Jerk",features[,2])
features[,2]<-gsub("GyroMag","Gyro Magnitude",features[,2])
features[,2]<-gsub(" Mag "," Magnitude ",features[,2])
features[,2]<-gsub("BodyBody","Body",features[,2])
features[,2]<-gsub("  "," ",features[,2])

# Test Datasets, 2947 obs.
setwd("./Test")
x1<-read.table("X_test.txt")            # Measurements
        x1<-x1[,features[[1]]]          # Select useful columns
        names(x1) <- features[[2]]      # Apply Variable Names
y1 <- read.table("y_test.txt")          # Activity File
        names(y1) <- "Test_Activity"
z1 <- read.table("subject_test.txt")    # Subject identifier 
        names(z1) <- "Test_Subject"
m1 <-cbind(z1,y1,x1)

setwd("../")
setwd("./Train")

# Train Datasets,7352 Obs
x2 <- read.table("X_train.txt")         # Measurements
        x2<-x2[,features[[1]]]          # Select useful columns
        names(x2) <- features[[2]]      # Apply Variable Names
y2 <- read.table("y_train.txt")         # Activity File
        names(y2) <- "Test_Activity"
z2 <- read.table("subject_train.txt")   # Subject identifier
        names(z2) <- "Test_Subject"
m2 <-cbind(z2,y2,x2)

# Merging all data
Table_1<-rbind(m1,m2)
        # Order the Dataset on Test Subject/Activity for neatness
        o1<-order(Table_1$Test_Activity,Table_1$Test_Subject) 
        Table_1<-Table_1[o1,]
        # Apply activity labels as Factor Levels
        Table_1[,2] <- factor(Table_1[,2],levels=act_lbl[,1],labels = act_lbl[,2] )

# Clean up workspace
rm(x1,y1,z1,m1,x2,y2,z2,m2,o1, act_lbl,features)

# Sum all observations for each activity for each subject
Agg_all<-aggregate(Table_1[, 3:68], list(Test_Activity=Table_1$Test_Activity,Test_Subject=Table_1$Test_Subject), mean)
Table_2<-Agg_all[,c(2,1,3:68)]

rm(Agg_all)

setwd("../")

write.table(Table_2,file="Analysis.txt",row.names = FALSE)
