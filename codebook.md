##codebook.md

This codebook describes the input files and data as well as the steps run_analysis.R performs to transform the raw data into a tidy data set for the Getting and Cleaning Data course project.  Also, this file contains a description of the data in the output file.

###Input Files and Data
The following, taken from the original README.txt file associated with the data set describes the input files and data, which were extracted to the ~/data/ directory.  Only the input files and data that were used for this project are listed below.

```
In aggregate, each data record provides:
======================================
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

However, this aggregate data is split across the following files:
=========================================
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels. 
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
```

Taken from the features_info.txt file, the following information describes the data used in the project.
```
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 
mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean
```

###run_analysis.R's Data Transformation
As described in the embedded comments within the run_analysis.R file, this R script takes the input files and data and transforms it into a tidy dataset that is saved in .csv format.  Broken down to correspond with the five parts of the course project assignment description, the steps that the script follows are:

1.  Read in the test and training data with corresponding subjects and activity numbers from these files: train/X_train.txt, train/y_train.txt, test/X_test.txt, test/y_test.txt, test/subject_test.txt, and train/subject_train.txt.  Once read in, combine the test and training data into a single data frame.
2.  Filter out all variables except those pertaining to the mean and standard deviation (std) of the measurements.
3.  Replace the activity numbers in the second column of the data frame with the actvitiy labels, which are taken from activity_labels.txt.
4.  Assign the abbreviated variable names to their corresponding column in the data frame, then expand those variable names to be more readable using camel casing. The following list shows some examples of how the variable names were expanded:

* tBodyAcc-mean()-X -> timeBodyAccelerometerMeanX
* tBodyGyro-std()-Y -> timeBodyGyroscopeStdY
* fBodyAccJerkMag-mean() -> freqBodyAccelerometerJerkMagnitudeMean
* fBodyGyroJerkMag-std() -> freqBodyGyroscopeJerkMagnitudeStd

5.  Aggregate the 10299 observations into 180 by taking the mean of each variable based on both the subject and the activity.  Append '_Mean' to the name of each variable (column name).  Finally, write this new and now tidy dataset out to a file in ..csv format.  That output file is called tidyData2.csv.

###Output File Contents
The output file tidyData2.csv contains the tidy data set generated by run_analysis.R.  The list below is a description of the variables (columns) in tidyData2.csv:
* Subject - a number designating which subject performed the activity. Its range is from 1 to 30.
* Activity - one of six activities measured in the study: laying, sitting, standing, walking, walking downstairs, and walking upstairs
* The remaining 79 variables are the means of the 79 features, calculated by subject and activity.  For example, the timeBodyAccelerometerMeanX_Mean, timeBodyGyroscopeStdY_Mean, freqBodyGyroscopeJerkMagnitudeStd_Mean, etc.

###Appendix - License for the Input Dataset
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.}