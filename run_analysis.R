#run_analysis.R

#Part 1:
#Read in all the data
#First the test data
testdata <- read.table('./data/test/X_test.txt')  #test data
testlabels <- read.table('./data/test/y_test.txt', col.names = c('Activity'))  #corresponding activity list
testsubject <- read.table('./data/test/subject_test.txt', col.names = c('Subject'))  #corresponsing subject list

#Then the training data
traindata <- read.table('./data/train/X_train.txt')  #test data
trainlabels <- read.table('./data/train/y_train.txt', col.names = c('Activity'))  #corresponding activity list
trainsubject <- read.table('./data/train/subject_train.txt', col.names = c('Subject'))  #corresponding subject list

#combine test and training data into a single data frame
testdata <- cbind(testsubject, testlabels, testdata)  #combine test data: subject, activity, data into a data.frame
traindata <- cbind(trainsubject, trainlabels, traindata)  #combine training data: subject, activity, data into a data.frame
allData <- rbind(testdata, traindata)  #combine the testdata and traindata data.frames into one large data.frame

#Part 2:
#Identify mean and std measurements in all of the data, then extract just those 
#measurements for the tidy data set
features <- read.table('./data/features.txt', stringsAsFactors = FALSE)
measurementsToExtract <- grep('.*(mean|std).*', features[,2])  #search for 'mean' or 'std' in the names of the features listed in features.txt
tidyData1 <- allData[ , c(1,2,measurementsToExtract+2)]  #'+2' because the first two columns of allData are the subject and the activity

#Part 3:
#Replace activity numbers with descriptive activity names/labels taken from activity_labels.txt
activityLabels <- read.table('./data/activity_labels.txt', stringsAsFactors = FALSE)
for (idx in activityLabels[,1]) {
    tidyData1$Activity[tidyData1$Activity == idx] <- activityLabels[idx,2]
}

#Part 4:
#Replace abbreviated variable names with more descriptive variable names
#Used camel casing
tidyData1ColNames <- features[measurementsToExtract,2]  #Assign the original feature names from features.txt to tidyData1's column names
tidyData1ColNames <- gsub('^t','time', tidyData1ColNames)  #expand leading 't' to 'time'
tidyData1ColNames <- gsub('^f','freq', tidyData1ColNames)  #expand leading 'f' to 'freq'
tidyData1ColNames <- gsub('Acc','Accelerometer', tidyData1ColNames)  #expand 'Acc' to 'Accelerometer'
tidyData1ColNames <- gsub('Gyro','Gyroscope', tidyData1ColNames)  #expand 'Gyro' to 'Gyroscope'
tidyData1ColNames <- gsub('Mag','Magnitude', tidyData1ColNames)  #expand 'Mag' to 'Magnitude'
tidyData1ColNames <- gsub('-mean','-Mean', tidyData1ColNames)  #capitalize 'Mean'
tidyData1ColNames <- gsub('-std','-Std', tidyData1ColNames)  #capitalize 'Std' (for Standard Deviation)
tidyData1ColNames <- gsub('(Body){2}','Body', tidyData1ColNames)  #remove duplicate 'Body'
tidyData1ColNames <- gsub('\\()','', tidyData1ColNames)  #remove parentheses
tidyData1ColNames <- gsub('-','', tidyData1ColNames)  #remove dashes

colnames(tidyData1) <- c('Subject','Activity',tidyData1ColNames)  #reassign tidyData1's column names

#Part 5:
#Create a second tidy dataset that calculates the averages of each variable by subject and by activity
tidyData2 <- aggregate(tidyData1[,3:81], by=list(Subject = tidyData1$Subject, Activity = tidyData1$Activity), FUN = mean)
colnames(tidyData2)[3:81] <- paste0(colnames(tidyData2)[3:81], '_Mean')  #Distinguish the Averages from the raw data by appending '_Mean' to tidyData2's column names
write.csv(tidyData2, file = './data/tidyData2.csv', row.names = FALSE)  #write tidyData2 out to a .csv file