# This readme file describes the files in this repository and what they contain

## Overview
This repo was created as part of the week 4 assignment of the Getting and Cleaning Data course of the data science specialisation course from JHU in Coursera.

The original files used for the analysis were downloaded from the following link
 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzipping the file created a folder structure with UCI HAR Dataset as the top level folder with two sub folders “train” and “test” along with other files and folders.

As part of the analysis a script called run_analysis.R was created which ultimately created a tidy output in a data file called summary_data.txt


Here is the summary of the key steps performed

1. run_analysis.R was created and run from inside the folder UCI HAR Dataset

2. It merges train/X_train.txt and test/X_test.txt to create one set of data. X_* files contain the 561 variables that were measured as part of the original study. There are 10299 rows in this set.

3. The list of the 561 variables is in the file features.txt and as per the instructions in the assignment, we need to extract all the variables which are either “mean” or standard deviation. Assuming that the column numbers in features.txt map 1-1 with the X_* files (since both have 561 columns), the script extracts all such columns from the data set created in step 2.


4. It also merges Y_train.txt and Y.test.txt to create one set of data for all the activities and then joins with the activity labels to create a mapped data set of activity numbers with activity labels creating a data frame of 10299 rows and 2 columns

5. Now we create a new column called “activity” and add it to the data set of step 2.

6. In a similar fashion train/subject_train.txt and test/subject_test.txt were merged to create the complete data set for 10299 rows of observations for the 30 subjects and this merged data was used to create a second additional column called “subject” in the data set created in step 5

7. The column names were cleaned to unnecessary characters and converted to lower case to make them easier to read and process.

8. Now the data in the step 7 was grouped by activity and subject and a mean computed for each group giving us 180 rows ( 6 activities * 30 subjects )

9. This data set was stored in a file called summary_data.txt which has 180 rows and 81 columns. The description of the columns is there in summary_data_info.txt and the column names are also given in a separate file called summary_data_cols.txt

## Note
Please install the package dplyr before running the script as it is required.

## Here’s a summary of all the files 

* README.md - this file
* summary_data_info - codebook describing the data in summary_data.txt
* summary_data_cols - file containing all the column names in summary_data.txt
* summary_data.txt - summarised data containing the final output as required by the assignment

