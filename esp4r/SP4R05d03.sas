/*SP4R05d03*/

/*Part A*/
ods select basicmeasures;
ods output basicmeasures = sp4r.SalePrice_BasicMeasures;
proc univariate data=sp4r.ameshousing;
   var saleprice;
run;

proc print data=sp4r.saleprice_basicmeasures;
run;

/*Part B*/
proc univariate data=sp4r.ameshousing;
   var saleprice;
   output out=sp4r.stats mean=saleprice_mean pctlpts= 40, 45, 50, 55, 60 
      pctlpre=saleprice_;
run;

proc print data=sp4r.stats;
run;

/*Part C*/
proc means data=sp4r.ameshousing;
   var saleprice garage_area;
   output out=sp4r.stats mean(saleprice)=sp_mean median(garage_area)=ga_med;
run;

proc print data=sp4r.stats;
run;

/*Part D*/
proc means data=sp4r.ameshousing;
   var saleprice garage_area;
   output out=sp4r.stats mean= std= / autoname;
run;

proc print data=sp4r.stats;
run;

*
In this demonstration, I'll show you how to use ODS SELECT, ODS OUTPUT, 
and the OUTPUT statement in several examples. First, in Part A, I'm going
to use ODS SELECT to only print the basic measures table when I run the 
UNIVARIATE procedure. And I'm also going to use ODS OUTPUT to save the 
basic measures table as a new SAS data set called SalePrice_BasicMeasures.
And I'm saving this in my SP4R library.

Then I'll just write my UNIVARIATE procedure with a single VAR statement 
and the sale price variable for my ameshousing data set. I'll also run the
PRINT procedure so I can see the new SAS data set that I just created. 
So run Part A.

The first table is the default basic measures table from the UNIVARIATE 
procedure. And the second table is my new SAS data set that I saved. You
notice it's a little bit different, but it saves the exact same information.
For example, the first column in the new SAS data set is VarName, which 
simply lists the saleprice variable. Then we have LocMeasure, which is the
Location and the Location Values. And then finally, we have the var 
VarMeasure and VarValue-- again, the exact same information that we're 
saving.

Next, I'm going to use the UNIVARIATE procedure on the ameshousing data 
set again with only the saleprice variable. And this time, I'm going to use
the OUTPUT statement to customize my new SAS data set. I'll use the OUT= 
to option to save a new data set called STATS in the SP4R library. And 
I'm going to use the keyword mean to save the mean summary statistic. And
I'll set that equal to a new variable name called saleprice_mean.

Next, I want to customize the percentiles I want to save and view. Recall 
in both PROC MEANS and PROC UNIVARIATE, those were already pre-determined.
In PROC UNIVARIATE with the OUTPUT statement, I can now customize the 
percentiles.

So first, I'll use pctlpts set that equal to a list. In this case, I want
to return the 40th, 45th, 50th, 55th, and 60th percentile. And if I use 
pctlpts I need to use pctlpre for prefix. And I'll set that equal to a 
name-- in this case, saleprice_.

So the new SAS data set variable names for these percentile points will be 
saleprice_ followed by the percentile number-- in this case, 40, 45, and 
so on. And I'll print that new data set.

So again, here we have the default PROC UNIVARIATE output. And if I scroll
to the bottom, I have the new SAS data set I saved and printed. I have the
saleprice_mean saved as well as the five percentiles I've requested. And 
again, you'll notice the names are the prefix followed by the percentile 
number.

In Part C, I'm going to use the MEANS procedure. And in the VAR statement,
I'm going to specify two variables-- saleprice and garage_area. Now, in 
the OUTPUT statement, I'm going to save a new SAS data set called stats 
with the OUT= to option. And now perhaps I don't want to save summary 
statistics for each one of those variables, saleprice and garage_area. 
Maybe I only want to save the mean for saleprice, and maybe I only want 
to save the median for garage_area. How would I do this?

Well, I'll specify the key word mean. And in parentheses, I'll give it 
the variable I want to take the mean of-- in this case, saleprice. And 
then I'll simply set that equal to my new SAS data set variable name 
SP_mean.

The same goes for the median keyword. I only want to take the median of 
garage_area. And I'm going to specify the new SAS data set variable name 
as ga_med. And next, I'll print the new SAS data set.

So the first table is the default means procedure output, and the second
table is my new SAS data set. Of course, we have only the mean for 
saleprice and only the garage_area median. You notice we also get two 
other columns. _FREQ_ refers to the number of observations used to find 
those summary statistics. And _TYPE_ refers to the subclass of observations
used to create the summary statistics.

To find subclasses of summary statistics-- for example, to find the mean
of the saleprice variable for each level of heating quality-- you would
pass the heating quality variable to the CLASS statement here in the 
MEANS procedure. Since we did not use the CLASS statement, the value of 
0 for type indicates all observations were used to compute the summary 
statistics.

Next, in Part D, I'll show you an alternative way to set the variable 
names. Again, I'm running the MEANS procedure on the saleprice and 
garage_area variables. I'm using the OUTPUT statement to save a new 
SAS data set called stats. And now I'm setting the mean and the standard
deviation equal to the null value, simply nothing. And as an option 
after the forward slash, I'm using the autoname option. Let's see what
this generates.

Again, I have the default means procedure output. And now you'll 
notice when I use the autoname, it simply concatenates the variable 
name with the summary statistic. So here I have SalePrice_Mean, 
Garage_Area_Mean, and so on. And it saves both summary statistics for
all the variables I specify in my VAR statement.
*;
