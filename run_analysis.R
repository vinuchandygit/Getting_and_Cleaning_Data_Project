#-----------------------------------------------------------------------#
# Assignment: Getting and Cleaning Data Course Project
#
# Task: create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only measurements on mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#
# Submited by: Vinu George Chandy
#-----------------------------------------------------------------------#

#Setiting the working directory to UCI HAR Dataset
setwd("D:\\CourseraRFile\\Course3-Week4-Quiz\\UCI HAR Dataset")

#Read features list data file
#This will help extract variables related to mean and standard deviation
featurelist <-read.table("features.txt",header=FALSE)

#Extract values for mean and standard deviation from featurelist
#Concatenating to generate one integer vector
selected_v_list <-c(grep("std",featurelist$V2),grep("\\-mean\\(\\)",featurelist$V2))


#Read Test and Train set file data
testdata <- read.table(".\\test\\X_test.txt",header=FALSE)
traindata <- read.table(".\\train\\X_train.txt",header=FALSE)

#Assign column names to data set
colnames(testdata) <- featurelist[,2]
colnames(traindata) <- featurelist[,2]

#Merge both Train and Test dataset
m_dataset <- rbind(testdata,traindata)

# Select only mean and standard devition related dataset
selected_m_dataset <- m_dataset[,selected_v_list]


# Extract Test and Train Label (Activity list for datasets)
testlabel <-read.table(".\\test\\y_test.txt",header=FALSE)
trainlabel <-read.table(".\\train\\y_train.txt",header=FALSE)
colnames(testlabel) <- "activity_ID"
colnames(trainlabel) <- "activity_ID"

# Extract Activity names file data
activitylabel <-read.table("activity_labels.txt",header=FALSE)
colnames(activitylabel) <- c("activity_ID","activity_Name")

# Attaching descriptive names to activities
testlabel <- merge(testlabel,activitylabel,by="activity_ID")
trainlabel <- merge(trainlabel,activitylabel,by="activity_ID")

labelslist <- rbind(testlabel,trainlabel)
  
# Extract Test and Train Subject details
subtest <-read.table(".\\test\\subject_test.txt",header=FALSE)
subtrain <-read.table(".\\train\\subject_train.txt",header=FALSE)
colnames(subtest) <- "subject_ID"
colnames(subtrain) <- "subject_ID"

sublist <- rbind(subtest,subtrain)

#Getting the final data list with subject and activity linked
final_data <- cbind(labelslist,sublist,selected_m_dataset)

# cleaning the variable names
names_v <- names(final_data)
names_v <- gsub("-mean\\(\\)"," Mean",names_v)
names_v <- gsub("-std\\(\\)"," StdDev",names_v)
names_v <- gsub("^f","Frequency_Based ",names_v)
names_v <- gsub("^t","Time_Based ",names_v)
names_v <- gsub("Acc","Accelerate ",names_v)
names_v <- gsub("Gyro","Gyroscope ",names_v)
names_v <- gsub("BodyBody","Body",names_v)
names_v <- gsub("Body","Body_",names_v)
names_v <- gsub("Gravity","Gravity_",names_v)
names_v <- gsub("([ M]*ag)"," Magnitude",names_v)

colnames(final_data) <- names_v

# Export the final set for further reference
write.table(final_data, './Final_TidyData.txt',row.names=TRUE, sep='\t')


#Summarize by variables /activity/subject
a_Value <- aggregate(
            final_data[,c(4:69)],
            by=list(activity_Name=final_data$activity_Name,
                    subject_ID = final_data$subject_ID),
            mean)

# Export the final set for further reference
write.table(a_Value, './Final_Average_TidyData.txt',row.names=FALSE, sep='\t')
