# Tidy Data Project:Smartphone Motion Sensor Data Analysis
## How to run the R script code from run_analysis.R 

1. Open an R console window in your favourite program (base R console or RStudio or another preferred program).Run the "getwd()" command to ensure your R working directory is as you expected, e.g. ("~/Documents/coursera").

2. Download the Samsung smartphone motion data in your R working directory as a .zip file from the following URL on the web: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

3. Unzip the downloaded file ("getdata-projectfiles-UCI HAR Dataset.zip") in the same location.The contents of the unzipped file should be in a folder called "UCI HAR Dataset". This folder should also be in your R working directory.

4. Make sure this R script ("run_analysis.R") is also stored in your working directory.

5. You can verify this by running the "dir()" command to **ensure the directory "UCI HAR Dataset" and the script "run_analysis.R" are both present in your R working directory.**

6. Run the following command at your R console:  source('run_analysis.R')

7. Wait a minute or so. You will see 10 messages printed out on your console window and the final message will confirm that the **tidySummaryData.txt** outout file has been created in your R current working directory.

## About the input motion sensor data being analysed in this R script.
The source data for this project comes from the Human Activity Recognition database built from the recordings of 30 volunteer subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Each volunteer subject performed six activities (WALKING, WALKING-UPSTAIRS, WALKING-DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the scientists captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% for the test data. 

A vector of 561 features (variables) was obtained by calculating variables from the time and frequency domain.

## About the output data being produced in this R script.
This R script takes the raw input data with 561 variables and tidies it up by adding meaningful column headings,  removing brackets / commas from the column headings, replacing the activity identifier numbers with actual activity descriptions (e.g. WALKING, STANDING, etc.). 

Then R script extracts only those 66 variables out of the original 561, which are "mean" and "standard deviation" measurements. This gives a data frame of 10299 observations with those 66 variables for the combined Testing and Traing data.

Then the R script aggregates the data by subject and activity, thus giving 180 rows (30 volunteer subjects , multiplied by 6 activites). The aggregation operation applied is mean(i.e. simple arithmetic averaging).

## How this R script achieves the 5 tasks in the Project Assignment
I have tackled the tasks in slightly different order to the order listed in the Coursera Project Assignment.

Assignment steps are being executed in this order: Steps 4 --> 3 --> 1 --> 2 --> 5 

* Step 4: Use descriptive variable names - Here I simply get the column headings in the "tidy" format.
* Step 3 For Testing data: Use descriptive activity names & attach the "tidy" column headings previously prepared. 
* Step 3 For Training data: Use descriptive activity names & attach the "tidy" column headings previously prepared.
* Step 1: Merge training & test data sets - I have added a variable called "TrainOrTest" before merging (although it is not present in the very final output dataset ).
* Step 2: Extract only mean & std dev measurements (excluding "meanFreq" variables)
* Step 5: Create a second,independent tidy dataset with the average of each variable for each activity and each subject.


