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

Before you run the run_analysis.R code: Save the UCI HAR Dataset in your working directory.

Loads in all the relevant data (test + train):

	#Test data
	sub.test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
	x.test<-read.table("./UCI HAR Dataset/test/x_test.txt")
	y.test<-read.table("./UCI HAR Dataset/test/y_test.txt")
	
	#Training data
	sub.train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
	x.train<-read.table("./UCI HAR Dataset/train/x_train.txt")
	y.train<-read.table("./UCI HAR Dataset/train/y_train.txt")
	
Combine the columns in both the test set and the training set:
	
	test<-cbind(sub.test,y.test,x.test)
	train<-cbind(sub.train,y.train,x.train)

Append the test set and training set into one complete dataset:
	
	com<-rbind(test,train)

Insert the descriptive variable names from "feature.txt":

	feat<-read.table("./UCI HAR Dataset/features.txt")
	colnames(com)<-c("Subject","Activity",as.character(feat$V2))
	
Find which column has a name with regular expression "mean" or "std", then subset those columns:

	col.mean.std<-grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",colnames(com))
	mean.std<-com[,(col.mean.std)]
	Act<-com$Activity
	Subject<-com$Subject
	mean.std.subset<-cbind(Subject,Act,mean.std)
	
Assign descriptive names to activities in new variable "Activity":
	
	attach(mean.std.subset)
	mean.std.subset$Activity[com[,2]==1]<-"Walking"
	mean.std.subset$Activity[com[,2]==2]<-"Walking Upstairs"
	mean.std.subset$Activity[com[,2]==3]<-"Walking Downstairs"
	mean.std.subset$Activity[com[,2]==4]<-"Sitting"
	mean.std.subset$Activity[com[,2]==5]<-"Standing"
	mean.std.subset$Activity[com[,2]==6]<-"Laying"
	detach(mean.std.subset)
	mean.std.subset<-select(mean.std.subset,-(Act))
	
Tidies up variable names by removing parentheses and hyphens:
	
	no.paran<-gsub("\\(|\\)","",names(mean.std.subset))
	final.colnames<-gsub("\\-"," ",no.paran)
	names(mean.std.subset)<-final.colnames
	
Generates a second data frame with mean of each variable factored by subject and activity:

	mean.by.group<-mean.std.subset %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
	
Saves the last data frame as "tidydata.txt":

	write.table(mean.by.group, file="tidydata.txt",row.names=FALSE)
