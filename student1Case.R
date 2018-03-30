# Case Study - student1
# MY TRY IN HOME

#using gsheet
library(gsheet)
url = 'https://docs.google.com/spreadsheets/d/1PWWoMqE5o3ChwJbpexeeYkW6p4BHL9hubVb1fkKSBgA/edit#gid=2051155174'

# functionality that retrieves information from googles sheet to my Data variables
stud1info = as.data.frame(gsheet2tbl(url))
str(stud1info)

# studentinfo = stud1info # Keeping a Backup
studentinfo = stud1info
class(studentinfo)
str(studentinfo)
?summary
summary(studentinfo)

# Converting the subject marks 'integer' as "Numeric", so that we can easily do the numeric mathematical operations on them.
studentinfo$java = as.numeric(studentinfo$java)
studentinfo$dbms = as.numeric(studentinfo$dbms)
studentinfo$dwm = as.numeric(studentinfo$dwm)
studentinfo$vlsi = as.numeric(studentinfo$vlsi)
studentinfo$cpp = as.numeric(studentinfo$cpp)
studentinfo$cbnst = as.numeric(studentinfo$cbnst)
studentinfo$btechmarks = as.numeric(studentinfo$btechmarks)
str(studentinfo)

# to display the categorical names of studentinfo
names(studentinfo)
length(names(studentinfo))
#number of various unique locations from where the students turn up
unique(studentinfo$city)
length(unique(studentinfo$city))

# Sorting students name and roll number as per 'btechmarks'
stud1 = aggregate(stud1info$btechmarks , by=list(stud1info$sname, stud1info$rollno), FUN=sum)
head(stud1,10)
# calling the students in order like, max marks at first and min marks at last and so on
stud1=stud1[order(stud1$x, decreasing=TRUE),] # Descending order
head(stud1,10) ## displays first 10 students

library(dplyr)
# finding those who paid fees less than 10000 along with their cgpa in descending order
studentinfo %>% filter(feepaid < 10000) %>% arrange(city, br, desc(cgpa)) 
studentinfo %>% filter(feepaid < 10000) %>% arrange(city, br, desc(cgpa)) %>% select(sname, rollno, city, br, cgpa)

# person with attendance less than 75 percent with their cgpa in decreasing order
filter(studentinfo, attnd <= .75) %>% arrange(desc(cgpa))
filter(studentinfo, attnd <= .75) %>% arrange(desc(cgpa)) %>% select(sname, rollno, cgpa)

# person with attendance more than 75 percent with their cgpa in decreasing order
filter(studentinfo, attnd >= .75) %>% arrange(city, desc(cgpa))
filter(studentinfo, attnd >= .75) %>% arrange(city, desc(cgpa)) %>% select(sname, rollno, city, cgpa)

# Finding from which region are the maximum no. of students 
table(studentinfo$city)
sort(table(studentinfo$city), decreasing = T)

