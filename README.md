README
---

The R script - run_analysis.r performs the following data manipulation on the datasets:

- Merges the training and the test sets to create one data set.
	- Create a function - `loading` that loads all the datasets in a given folder.
	 
	- Load all the datasets respectively into data tables named -`train`, `test`, `activity labels` and `features`.
	
	- Merge the `train` and `test` datasets and store the result in `dataset`.

- Extracts only the measurements on the mean and standard deviation for each measurement.

	- Retrieve the codes of the activity labels containing "mean" or "std" strings from the `features` data table.

	- Extract the mean and standard deviation measurements from the `X` data table and store them in data table - `extracted_dataset`.

- Uses descriptive activity names to name the activities in the data set.
	- Retrieve activity labels from the `activity_labels` using `dataset$y` as the keys and store them in the `activity`.
	 
	- Label the dataset - `extracted_dataset` with `activity`.
	
- Appropriately labels the data set with descriptive variable names.   
	- Rename the column names[1:86] of `extracted_dataset` with the descriptive variable names extracted from `features`.

- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	- Add the subject information in the `extracted_dataset`.
	
	- Calculate the means of each variable for the `extracted_dataset` grouped by activity and each subject and store the final dataset in `tidy_data`.

	- Export `tidy_data` to the txt file - tidy_data.txt.
