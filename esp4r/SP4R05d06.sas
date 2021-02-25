/*SP4R05d06*/

/* This program assumes the sales_all data set does not exist in the SP4R library, */
/* and will fail or produce unexpected results if the data set already exists.     */
/* In this case simply delete the sales_all data set and rerun this program.       */

%macro myappend(start,stop);
   %do year=&start %to &stop;
      proc import datafile="&path/sales_&year..csv" out=sp4r.sales_&year dbms=csv replace;
      run;

      proc append base=sp4r.sales_all data=sp4r.sales_&year;
      run;

      proc datasets library=sp4r noprint;
         delete sales_&year;
      quit;
   %end;
%mend;

options mprint;
%myappend(2000,2009)

/*Why did we use a double period to specify the DATAFILE above?*/
%let mypath = s:workshop/;
%put &mypathmydata.csv;
%put &mypath.mydata.csv;

%let mydata = sales_data;
%put &mydata.csv;
%put &mydata..csv;


*
In this demonstration, I want to use a macro program for iterative 
processing. So imagine I have 10 separate csv files that I want to 
read in separately, and then I want to stack those data sets on top
of each other. I can use a macro to make this process extremely simple.

So imagine the 10 csvs that you're going to read in have the same 
structure. Each csv has three variables. The store number which is
1 through 15, the year, in this case, 2000, and the sales the store
generated.

And each csv is going to be called sales, underscore, followed by
the year pertaining to the sales. So in this case, I have sales_2000,
the next csv file, the sales_2001, and so on. So I want to read in
all 10 of these data sets and stack the data into a single SAS data
set.

I'm going to call this macro myappend, because I'm going to be 
reading in csvs iteratively and appending them to a single SAS data 
set. And this is going to have two positional parameters, start and stop.

I'll start with the %DO loop, and I'll go from year equal to the
first positional parameter start to the second positional parameter 
stop. Now in each iteration of this DO loop, I'm first going to 
generate the IMPORT procedure. Recall, we use this in Chapter 2 to
read in raw delimited files.

First, we specify the data file option and set it equal to the full 
path, followed by the name of the file we're reading in. So in this 
case, I have &path/sales_&year..csv. And you'll notice, I'm actually 
using the index variable year as if it were a macro variable. So 
I'm tacking on an ampersand to the year index and using it to
iteratively read in these sales csv files.

Now to tell SAS to stop evaluating a macro variable, between the
ampersand and the first period, SAS will try to resolve the macro 
variable. So here I'm explicitly telling SAS, use the ampersand year
macro variable. Because it uses the first period to stop evaluating,
I need to add in a second period to give it the file type .csv. And
I have an example of that after this demonstration.

Next, I'll use the out equal to option and save a new SAS data set
called sales_&year in my SP4R library. My data file, of course, is
the csv. And I'll replace all instances of the same SAS data set
name in my directory.

Next, I'm going to use the append procedure. I'll give it the base 
equal to option to tell SAS what I'm appending to. So I want to append
all these data sets I'm reading into the sales_all SAS data set. Now 
if that doesn't exist on the first PROC APPEND that I run, it's going
to initialize a null data set. So I don't actually have to initialize
it on my own.

Next, I'm going to use the data= option to specify what data set I'm
appending to sales_all. And in this case, I want to iteratively tell 
it the new SAS data set-- sales_&year. So this is going to be sales_2000,
sales_2001, and so on.

After I append it to the sales_all data set, I'm going to use PROC 
DATASETS to delete that data set. I'll specify the library I'm going
to be deleting from-- in this case, sp4r. And I'm using the NOPRINT 
option so I don't clutter up my results page. Then I'll use the DELETE
statement and tell it explicitly to delete that data set I just ran in
after I tack the information onto my sales_all data set.

Another method would simply be to save everything in your work directory.
And then of course, when you close your SAS session, all those data sets
would be deleted anyway. But I just wanted to show you the DATASETS 
procedure.

And again, when you submit the macro, nothing should happen in your 
log. You'll see the exact same text. Now I have access to use it.

Again, a best practice-- always use your OPTIONS statement with the 
MPRINT option. That's going to print all the generated SAS code to the log.

Next, I'm going to go ahead and read in all my csvs, from year 2000 to 
2009. And when I do so, it opens up the new sales_all data set, which 
of course has 150 observations and the same three columns that we saw 
in the csv file. So now I have the first 15 stores for year 2000 and 
their sales, stacked onto the second 15 stores for 2001 and their sales,
and so on.

So the macro program iteratively read everything in, stacked it onto a
new SAS data set and I deleted the intermediary data sets. That way, I
don't have to keep running the IMPORT procedure and changing the data
file and output data set names. And if you check the log, you will see
all the code that was generated that you would have had to generate if
you didn't use a macro program.

So for example, you can see PROC APPEND to the base file sales_all. And
in the last case, the data set was sales_2009. So in this case, &year
resolved. And the same thing can be said for the DATASETS procedure 
below. Again, a best practice-- always use your OPTIONS statement with
the MPRINT option to diagnose errors.

And again, why did I use two periods in my data file option above? 
Well, let's look at an example. So imagine I have the macro variable 
mypath, which is s:workshop followed by a forward slash.

And I want to use this macro variable to specify the location and the 
name of the data file I want to read in. Well, I can't simply use 
mypathmydata.csv. In this case, mypath is not going to resolve to 
s:workshop. It's actually going to try and resolve the entire name, 
mypathmydata.

How do we circumvent this problem? Just use a period to tell SAS to stop
resolving the macro variable. So here, it assumes the macro variable is
between the ampersand and the period. And that period is used for the 
macro variable resolve and is deleted. Then I can tack on mydata.csv.

So I first tried to run my path without the period, and I got the 
apparent symbolic reference-- not resolved. Then I used the period and
my path resolved to s:workshop and I was able to tack on the data set 
and file name.

Now why did I use two periods? Well, again, imagine I have a macro 
variable called mydata which represents sales data. And I want to tack 
on the file type. Well, if I use a period directly after the macro 
variable, SAS uses that period and deletes it.

So the first period is to resolve the macro variable. The second one is
for the file type. So the first instance, use the first period, so the
file type is not explicit. I use two periods and now I have a .csv file.
*;