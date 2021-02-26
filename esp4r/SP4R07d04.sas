/*SP4R07d04*/

/*Part A*/
proc iml;
   use sp4r.cars;
   read all var {msrp mpg_city mpg_highway} where(msrp>80000) into imlCars;
   close sp4r.cars;

   varNames = {"MSRP" "MPG City" "MPG Highway"};
   Means = mean(imlCars);
   print imlCars, Means[colname=varNames];
quit;

/*Part B*/
proc iml;
   call randseed(802);
   n=10;
   weight = randfun(n,"Normal",200,50);
   age = randfun(n, "Poisson",35);

   create sp4r.newDataTable var{age weight};
   append;
   close sp4r.newDataTable;

   /*Identical Result 2
   create sp4r.newDataTable2;
   append var{age weight};
   close sp4r.newDataTable2;*/

   /*Identical Result 3
   mymat = age||weight;
   print mymat;

   create newDataTable from mymat [colname={weight, age}];
   append from mymat;
   close newDataTable;*/
quit;

proc print data=sp4r.newDataTable; run;

/*Part C*/
proc iml;
   call randseed(919);
   n=10;
   weight = randfun(n,"Normal",200,50);
   age = randfun(n, "Poisson",35);
   mymat = age||weight;

   edit sp4r.newDataTable;
   append from mymat;
   close sp4r.newDataTable;
quit;

proc print data=sp4r.newDataTable; run;


*
Demo: Calling SAS Data Sets fom IML
Let's look at a couple of examples of working with SAS data sets and
IML matrices together. So first, in Part A, I'm going to open the SAS 
data set cars, and then I'm going to read in all observations for the 
variables MSRP, MPG City, and MPG Highway. And I'm going to only read 
in observations where MSRP is greater than 80,000 and read all this 
data into the new matrix called imlCars and close your data set.

Next, I'm just going to create a new vector called varNames, which is 
going to have the column names when I print it-- MSPR, MPG City, and 
Highway. Next, I'll just use the built-in function MEAN to create a row
vector of the column Means. Again, the MEAN function in SAS is the same
as the CALLMEANS function in R. And finally, I'll print the matrix I 
just read in, imlCars, followed by the Means vector and give it the 
column names varNames.

So this is another option to analyze your data, find summary statistics
instead of using PROC MEANS. So here is the data I read in from the SAS
data set cars and here are the Means of that matrix. And again, that 
data set was read in conditionally.

Next in Part B, I'm going to create a new data set. I'll first set a 
seed because I'm going to simulate some values, and I'm going to simulate
10 observations for each vector I'm creating. I'm creating a variable
called weight, which is normally distributed with a mean of 200 and a 
standard deviation of 5, and I'm creating the variable age, which is 
Poisson distributed with a mean of 35.

Now, let's save these as a SAS data set. So I'll create the new SAS data
set called New Data Table in my SP4R library, and I'll use the VAR option
and tell SAS what vectors I'm going to append, age and weight. And again,
these are the names that SAS will use as the SAS data set variable names.
Then I'll use the APPEND statement to explicitly append it and close the
open data set.

The comment Result 2 is the exact same method except different syntax.
I just put the VAR option into the APPEND statement, and Result 3 creates
age and weight and then concatenates them to create a 10 by 2 matrix. I then
create the same SAS data set from the matrix mymat and change the column
names to weight and age, and that causes me to use a different APPEND
statement. But these are all equivalent. They'll do the exact same thing.

And finally, I'm just going to print that new data set to make sure it was
created. So here is my SAS data set with the appropriate variable names,
AGE and WEIGHT. Now, what if I wanted to go ahead and add data underneath
that existing SAS data set? I wanted to stack a matrix underneath.

Well, let's first create the data, so I'll set a seed. I'm going to
simulate another 10 observations, both for weight and age, simulated
the same way, and this time, I'm going to create a matrix because,
remember, the data I stack underneath has to have the same number of
columns. So mymat is now going to be a 10 by 2 matrix for age and weight.
I'll open the SAS data set with the EDIT statement, and I'll use the 
APPEND FROM statement to stack the data underneath and close the data
set. Now, my new data set should be 20 by 2.
*;