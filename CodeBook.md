# Tidy Data Project:Smartphone Motion Sensor Data Analysis
## Data Dictionary of the output file **tidySummaryData.txt** produced by **run_analysis.R**

This R script takes the raw input data with 561 variables and tidies it up by adding meaningful column headings,  removing brackets / commas from the column headings, replacing the activity identifier numbers with actual activity descriptions (e.g. WALKING, STANDING, etc.). 

Then R script extracts only those 66 variables out of the original 561, which are "mean" and "standard deviation" measurements. This gives a data frame of 10299 observations with those 66 variables for the combined Testing and Traing data.

Then the R script aggregates the data by subject and activity, thus giving 180 rows (30 volunteer subjects , multiplied by 6 activites). The aggregation operation applied is mean(i.e. simple arithmetic averaging).

*** 

Column #1. SubjectID

+ definition: Identifier within a group of 30 volunteer subjects whose motion data was recorded while carrying a waist-mounted smartphone with embedded inertial sensors (accelerometer and gyroscope).            
+ value:
    + 1...30
          
          
*** 

Column #2. activityName

+ definition: Each person in subject group performed six activities. This variable shows for each observation in the dataset which activity for each subject the other 66 variables were for.
+ value:
    + 1     WALKING
    + 2     WALKING_UPSTAIRS
    + 3     WALKING_DOWNSTAIRS
    + 4     SITTING
    + 5     STANDING
    + 6     LAYING

*** 

Columns #3 to #68. The **average** of each of the 66 mean & std-variance variables for each activity and each subjectIDlues (excluding meanFreq).

+  Value:  the average of each variable for each activity and each subject. The values of the original variables themselves had already been normalised in the input data to be between -1 and 1. So the values of the averages of those variables also will be within the range -1 and 1.  
    +  Definition of 66 variables as follows
    * __Time__ : These time domain signals were captured at a constant rate of 50 Hz.
    * __BodyAcceleration__: the acceleration signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz
    * __mean__ : Mean value
    * __std__ : Standard deviation    
    * __X, Y, Z__: is used to denote 3-axial signals in the X, Y and Z directions.

        * TimeBodyAcc-mean-X
        * TimeBodyAcc-mean-Y
        * TimeBodyAcc-mean-Z
        * TimeBodyAcc-std-X
        * TimeBodyAcc-std-Y
        * TimeBodyAcc-std-Z
    * __GravityAcceleration__: the acceleration signal was separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz       
        * TimeGravityAcc-mean-X
        * TimeGravityAcc-mean-Y
        * TimeGravityAcc-mean-Z
        * TimeGravityAcc-std-X
        * TimeGravityAcc-std-Y
        * TimeGravityAcc-std-Z
    * __BodyAccelerationJerk__: the body linear acceleration were derived in time to obtain Jerk signals        
        * TimeBodyAccJerk-mean-X
        * TimeBodyAccJerk-mean-Y
        * TimeBodyAccJerk-mean-Z
        * TimeBodyAccJerk-std-X
        * TimeBodyAccJerk-std-Y
        * TimeBodyAccJerk-std-Z
    * __BodyGyroscope__: gyroscope 3-axial raw signals        
        * TimeBodyGyro-mean-X
        * TimeBodyGyro-mean-Y
        * TimeBodyGyro-mean-Z
        * TimeBodyGyro-std-X
        * TimeBodyGyro-std-Y
        * TimeBodyGyro-std-Z
    * __BodyGyroscopeJerk__: the body angular velocity were derived in time to obtain Jerk signals      
        * TimeBodyGyroJerk-mean-X
        * TimeBodyGyroJerk-mean-Y
        * TimeBodyGyroJerk-mean-Z
        * TimeBodyGyroJerk-std-X
        * TimeBodyGyroJerk-std-Y
        * TimeBodyGyroJerk-std-Z
    * __BodyAccelerationMagnitude__: the magnitude of these three-dimensional signals were calculated using the Euclidean norm        
        * TimeBodyAccMag-mean
        * TimeBodyAccMag-std
        * TimeGravityAccMag-mean
        * TimeGravityAccMag-std
        * TimeBodyAccJerkMag-mean
        * TimeBodyAccJerkMag-std
        * TimeBodyGyroMag-mean
        * TimeBodyGyroMag-std
        * TimeBodyGyroJerkMag-mean
        * TimeBodyGyroJerkMag-std
    * __Frequency__ : The frequency domain signals. A Fast Fourier Transform (FFT) was applied to some of these signals.
    * __BodyAcceleration__: the acceleration signal was  using another low pass Butterworth filter with a corner frequency of 0.3 Hz 
    * __X, Y, Z__: is used to denote 3-axial signals in the X, Y and Z directions.
        * FreqBodyAcc-mean-X
        * FreqBodyAcc-mean-Y
        * FreqBodyAcc-mean-Z
        * FreqBodyAcc-std-X
        * FreqBodyAcc-std-Y
        * FreqBodyAcc-std-Z
    * __BodyAccelerationJerk__: the body linear acceleration were derived in time to obtain Jerk signals                
        * FreqBodyAccJerk-mean-X
        * FreqBodyAccJerk-mean-Y
        * FreqBodyAccJerk-mean-Z
        * FreqBodyAccJerk-std-X
        * FreqBodyAccJerk-std-Y
        * FreqBodyAccJerk-std-Z
    * __BodyGyroscope__: gyroscope 3-axial raw signals                
        * FreqBodyGyro-mean-X
        * FreqBodyGyro-mean-Y
        * FreqBodyGyro-mean-Z
        * FreqBodyGyro-std-X
        * FreqBodyGyro-std-Y
        * FreqBodyGyro-std-Z
    * __BodyAccelerationMagnitude__: the magnitude of these three-dimensional signals were calculated using the Euclidean norm        
        * FreqBodyAccMag-mean
        * FreqBodyAccMag-std
        * FreqBodyBodyAccJerkMag-mean
        * FreqBodyBodyAccJerkMag-std
        * FreqBodyBodyGyroMag-mean
        * FreqBodyBodyGyroMag-std
        * FreqBodyBodyGyroJerkMag-mean
        * FreqBodyBodyGyroJerkMag-std

*** 
