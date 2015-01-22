## ==============================================
## Getting and Cleaning Data
## ==============================================
## Course Project
## ----------------------------------------------------------------------------
### 2015-01-23, Shibdas Roy
## ==============================================

Here is a description of what the script "run_analysis.R" does with the Samsung
data downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and unzipped in the working directory. It extracts the various
data from text files, cleans the data and creates a tidy dataset out of it.

The training data is fetched from "./UCI HAR Dataset/train/X_train.txt" into a 
dataframe called trainData. The column names for this dataframe are set with 
the feature names extracted from "./UCI HAR Dataset/features.txt". Note that 
the feature names extracted with read.table are of class "factor", that was 
transformed to "character" class.

Next, the subject data for the training set is fetched from 
"./UCI HAR Dataset/train/subject_train.txt" and transformed from "integer" 
class to "factor" class, before assigning it to a new variable "subject" in 
the dataframe trainData.

Next, the activity identifiers (integers) for the training set are extracted
from "./UCI HAR Dataset/train/y_train.txt". This is of class "factor" and is
assigned to a new variable "actv_id" in the dataframe trainData.

The test data is similarly fetched from "./UCI HAR Dataset/test/X_test.txt" into
a dataframe called testData. The column names are again set to the feature names
extracted before. The subject data and activity identifiers for the test set are 
extracted respectively from "./UCI HAR Dataset/test/subject_test.txt" and 
"./UCI HAR Dataset/test/y_test.txt" and assigned as "factor" variables to new
variables "subject" and "actv_id" respectively in the dataframe testData.

The training set and the test set are then combined to form one dataset called
mergedData using the function rbind(). The activity labels for the different
actv_ids are extracted from "./UCI HAR Dataset/activity_labels.txt" into a
dataframe called activity_labels. In this table, the first variable represents
the activity identifier and the second variable is the descriptive name for
each activity identifier.

The dataframes mergedData and activity_labels are further merged by activity id
to generate a new dataframe called completeData. The column name for the
variable representing activity name/description is appropriately named as
"activity" in the new dataset.

Thus, the dataset completeData contains a total of 564 variables/columns, viz.
561 features, plus the actv_id, subject, and activity variables. We need to
extract only the measurements on the mean and standard deviation for each 
measurement against each subject and activity. This is done by first creating
a logical vector corresponding to the columns that we want in our tidy dataset.
This is achieved by using the grepl function on names(completeData) with
the regular expression "[Mm]ean|[Ss]td|^activity$|^subject$". This would return
a TRUE for every variable/column name that has the string "Mean"/"mean"/"std"/"Std"
or if variable/column name is "activity" or "subject". This logical vector
is then used to generate a new dataset called tidyData from completeData. The
resulting dataset contains a total of 88 variables.

Finally, the tidyData dataset is written into a text file using write.table().
The code book "CodeBook.md" explains the variables of this tidy dataset.