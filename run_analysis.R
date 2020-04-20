<<<<<<< HEAD
library(dplyr)

=======
>>>>>>> 1d442b3a7945da4c97999c16153ae358520464f8
#Extracting test data
test<-read.table("./UCI HAR Dataset/test/X_test.txt",sep="")
test_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt",sep="")
test_activity<-read.table("./UCI HAR Dataset/test/y_test.txt",sep="")

#Extracting train data
train<-read.table("./UCI HAR Dataset/train/X_train.txt",sep="")
train_subject<-read.table("./UCI HAR Dataset/train/subject_train.txt",sep="")
train_activity<-read.table("./UCI HAR Dataset/train/y_train.txt",sep="")

#Extracting variable names
names<-read.table("./UCI HAR Dataset/features.txt")
names<-as.character(names[,2])

#Merging the two data-sets
test<-cbind(test_subject,test_activity,test)
train<-cbind(train_subject,train_activity,train)
test$Set<-"Test"
train$Set<-"Train"
data<-rbind(test,train)
names<-c("Subject","Activity",names,"Set")
colnames(data)<-names

#Extracting mean and standard deviation for each measurement
data<-as.data.frame(data)
keep<-grep("mean|std",colnames(data))
<<<<<<< HEAD
keep<-c(1,2,keep,ncol(data))
=======
>>>>>>> 1d442b3a7945da4c97999c16153ae358520464f8
data<-data[,keep]

#Labeling the data-set with descriptive variable names
names<-colnames(data)
names<-sub("\\(\\)","",names)
names<-gsub("-"," ",names)
names<-sub("^t","",names)
colnames(data)<-names

#Giving descriptive activity names to the activities
data<-tbl_df(data)
data<-group_by(data,Subject,Activity)
data<-arrange(data,Subject,Activity)
data$Activity<-gsub(1,"Walking",data$Activity)
data$Activity<-gsub(2,"Walking Upstairs",data$Activity)
data$Activity<-gsub(3,"Walking Downstairs",data$Activity)
data$Activity<-gsub(4,"Sitting",data$Activity)
data$Activity<-gsub(5,"Standing",data$Activity)
data$Activity<-gsub(6,"Laying",data$Activity)

<<<<<<< HEAD
#To create tidy data-set with with the average of each variable 
#for each activity and each subject
tidy_data<-summarise_at(data,vars(1:(ncol(data)-3)),mean)

#Better alternative to get tidy_data data-set
tidy_data1<-melt(data,id=c("Subject","Activity","Set"))
tidy_data1<-dcast(tidy_data1,Subject+Activity+Set~variable,fun.aggregate = mean)
=======
>>>>>>> 1d442b3a7945da4c97999c16153ae358520464f8
