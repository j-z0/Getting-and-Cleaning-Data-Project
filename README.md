# Getting-and-Cleaning-Data-Project
Coursera Data Science Track

To read the tidydata.txt:

  	data <- read.table(file_path, header = TRUE)
  	View(data)
Get the data by download it:

	url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	zip <- "Dataset.zip"
	if (!file.exists(path)) {
		 dir.create(path)
	}
	download.file(url, file.path(path, zip))

Before you run the run_analysis.R code:

Save the UCI HAR Dataset in your working directory.

Loads in all the relevant data (test + train):
	#Test data
	sub.test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
	x.test<-read.table("./UCI HAR Dataset/test/x_test.txt")
	y.test<-read.table("./UCI HAR Dataset/test/y_test.txt")
	
	#Training data
	sub.train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
	x.train<-read.table("./UCI HAR Dataset/train/x_train.txt")
	y.train<-read.table("./UCI HAR Dataset/train/y_train.txt")
	
Merges all the different parts of the data set back together
	
	- Inserts the descriptive column names, using information from features.txt
	
	- Subsets only the columns with information on "mean" and "std"
	
	- Gives descriptive names to activity, using information from activity_labels.txt
	
	- Tidies up variable names by removing parentheses and hyphens, detailed definition will be provided in codebook
	
	- Generates a second data frame with mean of each variable factored by subject and activity 
	
	- Saves the last data frame as "tidydata.txt"
