#set working directory
setwd("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

# Load test and training files
# Load test Data into test data frame
test <- read.table("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/X_test.txt", quote="\"", comment.char="")
# load subject list for test
subject_test  <- read.table("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/subject_test.txt", quote="\"", comment.char="")
# load y data (activity list) for test
activity_test <- read.table("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/y_test.txt", quote="\"", comment.char="")



# Load and combine trainign data set
#loade tarining data into data 
train <- read.table("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/X_train.txt", quote="\"", comment.char="")

# Load subject as subject_train
subject_train <- read.table("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/subject_train.txt", quote="\"", comment.char="")

activity_train <- read.table("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/y_train.txt", quote="\"", comment.char="")

# combine test and training files
data <- rbind(test,train)

# load features(cloumn names)
features <- read_table2("C:/Users/jmcnamara/Desktop/Coursera/Course 3/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt",col_names = FALSE)
# creaest list of column names and transpose it
feature_names <- t(features[,2])
# add column names to test
colnames(data) <- c(feature_names)
# add column nmes to test 
#create vector with colum,ns that have mean and standard deviation values in the title
mean_std <- grep("mean|std", c(feature_names), value = FALSE)
#subset dataframe to only include thesecolumns
library(dplyr)
data_mean_std <- data[,mean_std]

#combine subject and activity for test and training data
activity <- rbind(activity_test,activity_train)
subject <- rbind(subject_test,subject_train)

#combine activty and subject with data to create a labeled data set

data_mean_std_1 <- cbind(subject,activity,data_mean_std)
colnames(data_mean_std_1)[c(1,2)] <- c("subject","activity")

#reclassify activity column into a factor and add factor labels 
 
data_mean_std_1$activity <- factor(data_mean_std_1$activity, labels=c("Walking","Walking_UpStairs","Walking_DownStairs", "Sitting", "Standing","Laying"))
#remove() from column names and make all letters lower case
colnames(data_mean_std_1) <- tolower(sub("\\()","",colnames(data_mean_std_1)))

# create average for each subject and each activity called 
average <- data_mean_std_1 %>% group_by(subject,activity) %>% summarise_all(funs(mean))
 


