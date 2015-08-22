# Getting-and-Cleaning-Data-Project
Coursera Data Science Track

To read the tidydata.txt:

  	data <- read.table(file_path, header = TRUE)
  	View(data)

Before you run the run_analysis.R code:

	Save the UCI HAR Dataset in your working directory.

What the run_analysis.R code do:

	- Loads in all the relevant data (test + train)
	
	- Merges all the different parts of the data set back together
	
	- Inserts the descriptive column names, using information from features.txt
	
	- Subsets only the columns with information on "mean" and "std"
	
	- Gives descriptive names to activity, using information from activity_labels.txt
	
	- Tidies up variable names by removing parentheses and hyphens, detailed definition will be provided in codebook
	
	- Generates a second data frame with mean of each variable factored by subject and activity 
	
	- Saves the last data frame as "tidydata.txt"
