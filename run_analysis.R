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
keep<-c(1,2,keep,ncol(data))
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