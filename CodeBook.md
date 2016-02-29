#Codebook

##Getting and Cleaning Data Course Project
###Human Activity Recognition Using Smartphones Dataset
------------------------------------------------------------------------------------------------------------

The original base experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
-Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. 
-Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
-The experiments have been video-recorded to label the data manually. 
-The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

Activities recorded were:-
-WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

Files used for analysis:-
- 'features_info.txt': Shows information about the variables used on the feature vector
- 'features.txt': List of all features
- 'activity_labels.txt': Links the class labels with their activity name
- 'train/X_train.txt': Training set
- 'train/y_train.txt': Training labels
- 'test/X_test.txt': Test set
- 'test/y_test.txt': Test labels
- 'train/subject_train.txt': Each row identifies the subject who performed the activity
- 'test/subject_test.txt': Each row identifies the subject who performed the activity

Tasks performed:
- Original data sets were merged to get one single dataset
- Relevant variable heads of mean() and sd() were taken out and linked to the subject and activity labels data
- Transformations done to get a clean header varable and row dentifier of activity names
- Finally average of different variables were taken with respect to per/activity per/subject

Transformation down to make the variables tidy were:
- gsub("-mean\\(\\)"," Mean",names_v)
- gsub("-std\\(\\)"," StdDev",names_v)
- gsub("^f","Frequency_Based ",names_v)
- gsub("^t","Time_Based ",names_v)
- gsub("Acc","Accelerate ",names_v)
- gsub("Gyro","Gyroscope ",names_v)
- gsub("BodyBody","Body",names_v)
- gsub("Body","Body_",names_v)
- gsub("Gravity","Gravity_",names_v)
- gsub("([ M]*ag)"," Magnitude",names_v)
