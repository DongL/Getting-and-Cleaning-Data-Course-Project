# Libraries
library(data.table)
library(magrittr)
library(tidyr)
library(dplyr)
library(purrr)

# 1) Merge the training and the test sets to create one data set

 # - Create loading function
loading <- function(fileloc){
        if(!grepl("/$", fileloc)) fileloc = paste0(fileloc, "/")
        file_list = list()
        fi <- list.files(fileloc, pattern = "*.txt")
        for(file in fi){
                file_list[[gsub(".txt|_train|_test", "", file)]] <- fread(paste0(fileloc, file), header = F)
        }
        file_list
}

 # - Data loading
train = loading(fileloc = "./UCI HAR Dataset/train")
test = loading(fileloc = "./UCI HAR Dataset/test")
activity_labels = fread("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "label"))
features = fread("./UCI HAR Dataset/features.txt", col.names = c("code", "label"))

 # - Merge the train and test datasets
dataset = map2(.x = train, .y = test, .f = ~ rbindlist(list(.x, .y)))

# 2) Extract only the measurements on the mean and standard deviation for each measurement
extracted_features = features[grepl("mean|std", tolower(label)), code]
extracted_dataset = dataset$X[, extracted_features, with = F]

# 3) Use descriptive activity names to name the activities in the data set
setkey(activity_labels, code)
activity = activity_labels[dataset$y, label]
extracted_dataset$activity = activity

# 4) Appropriately Label the data set with descriptive variable names.
colnames(extracted_dataset)[1:86] = features[grepl("mean|std", tolower(label)), label]

# 5) Create a second, independent tidy data set with the average of each variable for each activity and each subject.
extracted_dataset$subject = dataset$subject  
tidy_data <- extracted_dataset[, lapply(.SD, mean), .(subject, activity)] 
write.table(tidy_data1, file = "tidy_data.txt", row.names = F)
