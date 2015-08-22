library(dplyr)
#Get the data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zip <- "Dataset.zip"
if (!file.exists(path)) {
    dir.create(path)
}
download.file(url, file.path(path, zip))

#Load all the relevant data
#Test data
sub.test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x.test<-read.table("./UCI HAR Dataset/test/x_test.txt")
y.test<-read.table("./UCI HAR Dataset/test/y_test.txt")
#Training data
sub.train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
x.train<-read.table("./UCI HAR Dataset/train/x_train.txt")
y.train<-read.table("./UCI HAR Dataset/train/y_train.txt")

#Combine the columns in both the test set and training set
test<-cbind(sub.test,y.test,x.test)
train<-cbind(sub.train,y.train,x.train)
#Combine the rows of the test set and training set into one complete data set
com<-rbind(test,train)

#Insert the appropriate variable names from "features.txt"
feat<-read.table("./UCI HAR Dataset/features.txt")
colnames(com)<-c("Subject","Activity",as.character(feat$V2))

#Find which column has a name that has regular expression of "mean" or "std"
col.mean.std<-grep("[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]",colnames(com))
#Subset the said columns
mean.std<-com[,(col.mean.std)]
Act<-com$Activity
Subject<-com$Subject
mean.std.subset<-cbind(Subject,Act,mean.std)

#Assign descriptive names to activities in new variable "Activity"
attach(mean.std.subset)
mean.std.subset$Activity[com[,2]==1]<-"Walking"
mean.std.subset$Activity[com[,2]==2]<-"Walking Upstairs"
mean.std.subset$Activity[com[,2]==3]<-"Walking Downstairs"
mean.std.subset$Activity[com[,2]==4]<-"Sitting"
mean.std.subset$Activity[com[,2]==5]<-"Standing"
mean.std.subset$Activity[com[,2]==6]<-"Laying"
detach(mean.std.subset)
#Remove the old Activity variable
mean.std.subset<-select(mean.std.subset,-(Act))

#Tidy up current variable names
#Remove stand-alone parentheses
no.paran<-gsub("\\(|\\)","",names(mean.std.subset))
#Remove hyphens
final.colnames<-gsub("\\-"," ",no.paran)

#Generate a second data frame with mean by subject and activity
names(mean.std.subset)<-final.colnames
mean.by.group<-mean.std.subset %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))
write.table(mean.by.group, file="tidydata.txt",row.names=FALSE)