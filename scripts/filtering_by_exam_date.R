library(tidyverse)

# read in the cleaned data 
df <- read_csv("./analyzed_data/cleaned_survey_data_FALL_2019.csv")


# add in the first_exam_date column
df$first_exam_date = NA

df$first_exam_date = as.Date(df$first_exam_date)


# for Rocks Chem 1110
df$first_exam_date[which(df$instructorLastName == "Rocks" & 
                           df$courseName == "CHEM-1010-004 | Fall 2019")] = as.Date("2019-09-19")


# for Rocks Chem 3100
df$first_exam_date[which(df$instructorLastName == "Rocks" & 
                           df$courseName == "CHEM-3100-001 | Fall 2019")] = as.Date("2019-09-30")


# for Domyan 3500
df$first_exam_date[which(df$instructorLastName == "Domyan" & 
                           (df$courseName == "BIOL-3500-002 | Fall 2019" | df$courseName == "BIOL-3500-602 | Fall 2019"))] = as.Date("2019-09-23")

# for Kopp 1610
df$first_exam_date[which(df$instructorLastName == "Kopp" & 
                           (df$courseName == "BIOL-1610-602 | Fall 2019" | 
                              df$courseName == "BIOL-1610-005 | Fall 2019" | df$courseName == "BIOL-1610-003 | Fall 2019"))] = as.Date("2019-09-10")


# filter out instructors whose exam dates were not listed
new_df <- df %>% filter(! is.na(first_exam_date))


# filter out the students who took the survey after the first exam date

new_df$end_date = as.Date(new_df$end_date) # make end_date Date format

new_df <- new_df %>% filter(end_date < first_exam_date) # keep students whose end date was BEFORE the first exam date


# save the newly filtered df
write.csv(new_df, "./analyzed_data/filtered_data_exam_dates.csv", row.names = F)
