library(dplyr)
#set working directory to UCI HAR Dataset

x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")

#Merge the two data sets to get one set of 10299 rows and 561 columns
x <- rbind(x_train, x_test)

# read the 561 features which represent the 561 columns in the combined data frame (x above)
features <- read.table("features.txt")

#get the vector containing only columns numbers that have mean or std (for standard deviation)
# in their name

mstd <- grep("mean|std",features[,2])

# extract only the above columns from the "x" dataset that was created initially
x <- x[,mstd]

# give column names to the filtered version of x
names(x) <- as.character(features[,2][mstd])

# convert x to dplyr table
x <- tbl_df(x)

##now to create the activity labels for all the rows

#read the y_train and y_test files and combine into a single dataset
# this dataset contains only the activity numbers (1 to 6) and not the actual labels
y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
y <- rbind(y_train, y_test)

#now map the numbers to labels by reading activity lables and left joining with y
#V1 is the variable for the the activity code

activity_labels <- read.table("activity_labels.txt")
y <- left_join(y, activity_labels, "V1")

#now we can extract only the vector with activity lables and merge with x

yx <- cbind(y[,2], x)

#combine the subject data into 1 dataset

sub_train <- read.table("train/subject_train.txt")
sub_test <- read.table("test/subject_test.txt")

subjects <- rbind(sub_train, sub_test)[,1]

#add the subjects data as the first column of to the yx dataset.
#This gives us the unsummarised complete dataset

subjects_y_x <- cbind(subjects, yx)

## Give meaningful names to the first two variables
## Other variables still have their names as inherited from the original data

names(subjects_y_x)[1:2] <- c("subject","activity")
names(subjects_y_x) <- gsub('\\(\\)', '', names(subjects_y_x))
names(subjects_y_x) <- tolower(names(subjects_y_x))   #convert to lower case

##Group the data by activity and subject columns and then apply the summarize_all function to get mean of each column
## we use the chaining technique for the dplyr functions

summary_data <- subjects_y_x %>% group_by(activity,subject) %>% summarize_all(mean)

## save the summarised tidy data in a file 
write.table(summary_data, file = "summary_data.txt")