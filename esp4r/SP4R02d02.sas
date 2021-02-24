/*SP4R02d02*/

/*Import data using a DATA step*/
data sp4r.all_names;
   length First_Name $ 25 Last_Name $ 25;
   infile "&path/allnames.csv" dlm=',';
   input First_Name $ Last_Name $ age height;
run;

/***************************************************************************************************/
/*Import data using PROC IMPORT*/
proc import out=sp4r.baseball 
   datafile= "&path/baseball.csv" DBMS=CSV REPLACE;
   getnames=yes;
   datarow=2; 
run;

/*Rename the variables*/
data sp4r.baseball;
   set sp4r.baseball;
   rename nAtBat = At_Bats
	     nHits = Hits
	     nHome = Home_Runs
	     nRuns = Runs
	     nRBI = RBIs
	     nError = Errors;
run;

/***************************************************************************************************/
/*Creating a SAS data set from delimited data by hand*/
data sp4r.example_data3;
   length First_name $ 25;
   infile datalines dlm='*';
   input First_Name $ Last_Name $ age height;
   datalines;
   Jordan*Bakerman*27*68
   Bruce*Wayne*35*70
   Walter*White*51*70
   Henry*Hill*65*66
   Jean Claude*Van Damme*55*69
;run;

*
In this section, we'll read in delimited raw data files with both DATA and 
PROC steps. Here I'm printing a new data set called, ALL_NAMES in my SP4R 
library. The names are going to be the same names as before-- first name, 
last name, and also, I'm going to read in age and height. I'll change the 
length of the first name and last name variables, as well, because they 
are character.

In my INFILE statement, I'll specify the path to the data file. And I want 
to read in the allnames.csv data file. And the DLM= option, I'll specify 
the comma for the csv file type. Now the allnames.csv file has the 
original five names to be read in from the previous demonstration, as well 
as 195 other names. So of course, I wouldn't want to type those out by 
hand. So I'll just save those in my csv and read them in with the DATA 
step.

So let's run this. And again, we have 200 observations and the same 4 
columns. So here are the first five names from before, and my 195 other 
ones that you can scroll through. And we also have age and height, as well.

Next, let's import a data set with the IMPORT procedure. So in the PROC 
IMPORT statement, I use the OUT= option to specify my data set name. I'm 
calling it baseball. And my DATAFILE option, I'll specify the path to the 
data file. And I'm going to read in the baseball.csv file. And the file 
type of course, is csv.

And I like to use the REPLACE option to overwrite any existing data sets 
in my SP4R library with the same name. Now this csv has the first row 
with the variable names I want to use as SAS dataset variable names. So 
I'll use GETNAMES= yes. And then I'll tell SAS, start reading in the 
data on row 2. And let's run this IMPORT procedure.

And this data set is from the 1986 MLB season. So here we have the name 
of the player, the team they played for, and a bunch of other variables 
indicating player performance. So here we have the number of at bats 
during the season, the number of hits, the number of home runs, and so 
on. And again, I read in those variables from the csv to be used in 
this SAS data set.

But now, maybe I don't want the n character in front of all those variable 
names. Maybe I don't want it to be nHits. I just want it to be Hits. 
How could I change that?

So let's go back to the code. And let's use a RENAME statement in my data 
step. In the DATA statement and the SET statement I'm going to specify 
the same name, baseball. And again, if it is the same name, it 
overwrites that existing data set with my changes.

So here in the RENAME statement, I'm changing nAtBat to At_Bats, nHits 
to Hits. And all the way through nError to Errors. So once I run this, 
I'll have the new variable names in my data set. So now again, I have 
At_Bats, Hits, and so on.

And finally, I wanted to show you one more method for reading in data. 
Now perhaps you have a text file, and you don't want to read in the text 
value. You just want to go ahead and copy and paste that data right 
into a data step and read it in. But maybe that text file, the data in 
it is delimited in some way. How can we still read that in?

So here I'm creating a new data set called EXAMPLE_DATA3. I have a 
LENGTH statement to change first name to 25 characters maximum. And 
notice, in this case, I'm not setting a length for last name.

My INPUT statement has the same four variables for my ALL_NAMES dataset-- 
first name, last name, age, and height. And now in my DATALINES statement, 
I copied and pasted data from perhaps a text file. And you'll notice the 
data here is delimited with stars.

So Jordan*Bakerman*27*68, and so on. How could I read this in? I'm 
going to add in an INFILE statement, and I'm going to use the keyword, 
datalines. So that tells SAS to read in the data under the DATALINES 
statement, as opposed to a delimited raw data file.

And in this case, I'm still going to use the DLM= option, and specify 
in this case, a star delimiter. So when I run this DATA step, the data 
set should look just like the one I created in Section One. But remember 
I only specified a length for first name, so the last name field defaults 
to 8 bytes. And values that are longer than 8 characters will be truncated.
*;