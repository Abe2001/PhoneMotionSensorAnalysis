## Assume the Samsung smartphone motion data is downloaded in the R home directory as a .zip file
## Name of the zip file = "getdata-projectfiles-UCI HAR Dataset.zip"
## Assume : The user has already unzipped the above file (using Winzip or something like that).
## Assume : The contents of the unzipped file are in a folder called "UCI HAR Dataset".
## Assume : The folder "UCI HAR Dataset" is in the R home directory.


library(dplyr);
library(stringr);
############################# BEGIN: Read in all the relevant datasets ######################
##  Read training data from the unzipped folder
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE,na.strings = "N/A");
train_X <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE,na.strings = "N/A");
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE,na.strings = "N/A");

##  Read testing data from the unzipped folder
test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE,na.strings = "N/A");
test_X <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE,na.strings = "N/A");
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE,na.strings = "N/A");

##  Read features data from the unzipped folder (which will eventually become the column headings of the tidy dataset) 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE,na.strings = "N/A");
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE,na.strings = "N/A");

print("#### COMPLETED: Read in all the relevant datasets ####");
############################# COMPLETED: Read in all the relevant datasets ######################

print("#### Assignment steps are being executed in this order: ");
print("#### Steps 4 --> 3 --> 1 --> 2 --> 5 ");
########################### BEGIN:ASSIGNMENT TASK#4: Appropriately label the data set with descriptive variable names ####################
## Format the "features" data frame since these are going to be the 561 column headings of an intermediate tidy dataset, 
## i.e. remove the parentheses, commas etc from the 2nd column of the "features" data frame
features$V2 <- as.character(features$V2);
features2 <- features[,2];    ## just get the 2nd column of the features dataframe

features2 <- gsub("[()]","",features2);  ## Remove "()" from column names
features2 <- gsub(",", "_",features2);   ## Replace commas with underscores
features2 <- gsub("^t", "Time",features2);  ## Prefix t variables with the full word "Time"
features2 <- gsub("^f", "Freq",features2);  ## Prefix f variables with the more descriptive word "Freq"

## Assign the meaningful column names to test_X and train_X dataframes (each of which currently have 561 variables currently called V1 to V561)
colnames(test_X) <- features2; 
colnames(train_X) <- features2;

## Assign meaningful column names to activity_labels, train_subject & test_subject dataframe 
colnames(activity_labels) <- c("activityID", "activityName");
colnames(test_subject) <- c("SubjectID");
colnames(train_subject) <- c("SubjectID");
colnames(test_y) <- c("activityID");
colnames(train_y) <- c("activityID");

print("#### COMPLETED: Step 4: Use descriptive variable names");
########################### COMPLETED:ASSIGNMENT TASK#4 : Appropriately label the data set with descriptive variable names ####################


########################### BEGIN:ASSIGNMENT TASK#3 FOR TEST DATA : Use descriptive activity names to name the activities in the data set #########################################

## Attach the "test subject" column to the left of the "test_X" data frame so that each row now shows the subject(volunteer person) 
### IS THIS REALLY NEEDED ? test_subject$SubjectID <- as.character(test_subject$SubjectID);  ## convert from integer to character
test_X <- cbind(test_subject,test_X);            ## test_X now has 562 columns 

## Attach the "test_y" column to the "test_X" data frame so that each row now includes the "activity-id"  
test_y$activityID <- as.character(test_y$activityID);
test_y$activityID <- as.factor(test_y$activityID);       ## convert to factor so that the data frame can be split by the 6 activity IDs
test_X <- cbind(test_y,test_X);                          ## test_X now has 563 columns

## Attach a new column "activityName" . The initial values of this column are set to "DummyActivityName"
activityName <- rep(c("DummyActivityName"),nrow(test_X) );   ## ActivityName vector has the same length as number of rows in TEST data
test_X <- cbind(activityName , test_X);              ## test_X now has 564 columns

## split the data frame according to activity ID into a list of 6 data frames & then replace the dummy activity name values with the actual activity values
## You cannot just merge the 2 data frames here since you will lose the order of the rows within test_X. 
test_X_split <- split(test_X , test_X$activityID ); 

test_X_split[[1]]$activityName <- activity_labels[activity_labels$activityID == 1,2];   ## Rows with Activity #1 = WALKING
test_X_split[[2]]$activityName <- activity_labels[activity_labels$activityID == 2,2];   ## Rows with Activity #2 = WALKING_UPSTAIRS
test_X_split[[3]]$activityName <- activity_labels[activity_labels$activityID == 3,2];   ## Rows with Activity #3 = WALKING_DOWNSTAIRS
test_X_split[[4]]$activityName <- activity_labels[activity_labels$activityID == 4,2];   ## Rows with Activity #4 = SITTING
test_X_split[[5]]$activityName <- activity_labels[activity_labels$activityID == 5,2];   ## Rows with Activity #5 = STANDING
test_X_split[[6]]$activityName <- activity_labels[activity_labels$activityID == 6,2];   ## Rows with Activity #6 = LAYING

## Now merge the 6 dataframes back into a single one for TEST data 
test_X <- rbind(test_X_split[[1]], test_X_split[[2]], test_X_split[[3]], test_X_split[[4]], test_X_split[[5]], test_X_split[[6]]);

## Attach a new column "TestOrTrain" . The values of this column for all rows are set to "Test" for the Test data & "Train" for the Train data. 
TestOrTrain <- rep(c("Test"),nrow(test_X) );   ## TestOrTrain vector has the same length as the number of rows in test_X
test_X <- cbind(TestOrTrain , test_X);              ## test_X has 565 columns

print("#### COMPLETED: Step 3 For Testing data: Use descriptive activity names");
########################### COMPLETED:ASSIGNMENT TASK#3 FOR TEST DATA:Use descriptive activity names to name the activities in the data set #########################################


################## REPEAT SAME STEPS TO TIDY UP THE "TRAINING" DATA  #####################################

########################### BEGIN:ASSIGNMENT TASK#3 FOR TRAIN DATA : Use descriptive activity names to name the activities in the data set #########################################

## Attach the "test subject" column to the left of the "test_X" data frame so that each row now includes the subject(volunteer person) 
### IS THIS REALLY NEEDED ? train_subject$SubjectID <- as.character(train_subject$SubjectID);  ## convert from integer to character
train_X <- cbind(train_subject,train_X);            ## train_X has now 562 columns 

## Attach the "train_y" column to the "train_X" data frame so that each row now includes the "activity-id"  
train_y$activityID <- as.character(train_y$activityID);
train_y$activityID <- as.factor(train_y$activityID);    ## convert to factor so that the data frame can be split by the 6 activity IDs
train_X <- cbind(train_y,train_X);                       ## train_X now has 563 columns

## Attach a new column "activityName" . The initial values of this column are set to "DummyActivityName". 
activityName <- rep(c("DummyActivityName"),nrow(train_X) )  ## same length as number of rows in TRAINING data
train_X <- cbind(activityName , train_X);              ## train_X now has 564 columns

#### split the data frame according to activity ID into a list of 6 data frames & then replace the dummy activity name values with the actual activity values
#### You cannot just merge the 2 data frames here since you will lose the order of the rows within train_X. 
train_X_split <- split(train_X , train_X$activityID );  

train_X_split[[1]]$activityName <- activity_labels[activity_labels$activityID == 1,2];   ## Rows with Activity #1 = WALKING
train_X_split[[2]]$activityName <- activity_labels[activity_labels$activityID == 2,2];   ## Rows with Activity #2 = WALKING_UPSTAIRS
train_X_split[[3]]$activityName <- activity_labels[activity_labels$activityID == 3,2];   ## Rows with Activity #3 = WALKING_DOWNSTAIRS
train_X_split[[4]]$activityName <- activity_labels[activity_labels$activityID == 4,2];   ## Rows with Activity #4 = SITTING
train_X_split[[5]]$activityName <- activity_labels[activity_labels$activityID == 5,2];   ## Rows with Activity #5 = STANDING
train_X_split[[6]]$activityName <- activity_labels[activity_labels$activityID == 6,2];   ## Rows with Activity #6 = LAYING

## Now merge the 6 dataframes back into a single one for TRAINING data 
train_X <- rbind(train_X_split[[1]], train_X_split[[2]], train_X_split[[3]], train_X_split[[4]], train_X_split[[5]], train_X_split[[6]]);

## Attach a new column "TestOrTrain" . The values of this column for all rows are set to "Test" for the Test data & "Train" for the Training data. 
TestOrTrain <- rep(c("Train"),nrow(train_X) );   ## TestOrTrain vector has the same length as the number of rows in train_X
train_X <- cbind(TestOrTrain , train_X);              ## train_X now has 565 columns

print("#### COMPLETED: Step 3 For Training data: Use descriptive activity names");
########################### COMPLETED:ASSIGNMENT TASK#3 FOR TRAIN DATA : Use descriptive activity names to name the activities in the data set #########################################



########################### BEGIN: TASK # 1:Merge training & test data sets #########################################

TidyTrainTestData <- rbind(test_X, train_X);         ## This has 565 columns & 10299 rows
print("#### COMPLETED: Step 1: Merge training & test data sets");
########################### COMPLETED: TASK # 1:Merge training & test data sets #####################################


########################### BEGIN: TASK#2:Extract only measurements on the mean and std deviation for each measurement #########################################

## Find columns which have "mean" or "std" as strings within their column-names.
WantedMeasures <- grep( "std|mean", colnames(TidyTrainTestData), value = TRUE);        

## length of WantedMeasures = 79. There are 79 variables having "mean" or "std" in the variable names
## However, this list of 79 includes a number of "meanFreq" variables, which we are not interested in.  
## "meanFreq" has been defined in the "features_info.txt" file as "Weighted average of the frequency components to obtain a mean frequency". 
## So I have inferred that it is not a "mean" in the same sense of the other "mean" variables. 
## Whether I am correct in removing "meanFreq" columns or not is not material to the letter and spirit of this project assignment.
## (since I have explained my assumption & rationale clearly here for  doing so).

WantedMeasures <- grep("meanFreq", WantedMeasures, invert = TRUE, value = TRUE);   ## Remove "meanFreq" variables using the "invert" option 

## Now,length of WantedMeasures = 66. So there are 66 variables that we are interested in. 
## In addition, we need the 2 "identifier" columns: activityName and SubjectID. 
## So the final tidy dataset will have 66 + 2 = 68 columns
FinalTidyDataColumns <- c("activityName", "SubjectID", WantedMeasures);   ## concatenate the 2 columns mentioned above to the z1 character vector

## Subset the full dataframe (with 565 columns) to only include those columns whose column-names are in the WantedMeasures vector.
TidyTrainTestData <- TidyTrainTestData[, names(TidyTrainTestData) %in% FinalTidyDataColumns];        ## This now has 68 columns & 10299 rows.

print("#### COMPLETED: Step 2: Extract only mean & std dev measurements");
########################### COMPLETED: TASK # 2:Extract only measurements on the mean and std deviation for each measurement #########################################

## At this point,completed the tasks # 1, 2, 3 and 4 of the assignment as follows (although not done in that order): 
## Task#1: DONE: Merge the training and the test sets to create one data set.
## Task#2: DONE: Extract only the measurements on the mean and standard deviation for each measurement. 
## Task#3: DONE: Use descriptive activity names to name the activities in the data set
## Task#4: DONE: Appropriately label the data set with descriptive variable names. 

############ BEGIN: ASSIGNMENT TASK # 5  : From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.. #########################################

TidyDataGrouped <- group_by(TidyTrainTestData, SubjectID, activityName);
TidyDataSummarised <- summarise_each(TidyDataGrouped, (funs(mean)));

#write the summarised tidy data to file (use comma-separated format for easier viewing)
write.table(TidyDataSummarised,file="tidySummaryData.txt",row.names=FALSE, sep="," );
print("#### COMPLETED: Step 5: Create a second,independent tidy dataset with the average of each variable for each activity and each subject.");
print("#### THE FINAL OUTPUT TIDY DATA FILE <tidySummaryData.txt> HAS BEEN WRITTEN TO YOUR R HOME DIRECTORY LOCATION");
############ COMPLETED: ASSIGNMENT TASK # 5  : From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. #########################################


