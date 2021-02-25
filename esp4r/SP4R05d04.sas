/*SP4R05d04*/

/*Part A*/
proc means data=sp4r.ameshousing;
   var saleprice;
   output out=sp4r.stats mean=sp_mean std=sp_sd;
run;

proc sql;
   select sp_mean into :sp_mean from sp4r.stats;
   select sp_sd into :sp_sd from sp4r.stats;
quit;

/*Part B*/
data sp4r.ameshousing;
   set sp4r.ameshousing;
   sp_stan = (saleprice - &sp_mean) / &sp_sd;
run;

proc print data=sp4r.ameshousing (obs=6);
   var saleprice sp_stan;
run;

proc means data=sp4r.ameshousing mean std;
   var saleprice sp_stan;
run;

/*Part C*/
proc contents data=sp4r.cars varnum out=carscontents;
run;

proc print data=carscontents;
   var name type;
run;

/*Part D*/
proc sql;
   select distinct name into: vars_cont separated by ' ' from carscontents where type=1;
   select distinct name into: vars_cat  separated by ' ' from carscontents where type=2;
quit;

%put The continuous variables are &vars_cont and the categorical variables are &vars_cat;


*
Let's see how to create and use macro variables. In the first part, I'm 
going to show you how to automate the process. So first, I need to create
a new SAS data set.

I'm going to use the MEANS procedure on the ameshousing data set, and 
I'll analyze the sale price variable. I'll use the OUTPUT statement to 
save a new SAS data set with the OUT= to option, and I'll save the data
set called STATS. And I want to save the mean and standard deviation 
under the variable names sp_mean, sp_sd.

Once I create that data set, I'm going to go ahead and query it with the
PROC SQL and create new global macro variables. So I'm going to select 
the variable name sp_mean, and I'll put it into a new macro variable 
with the colon operator sp_mean. Yes, these are the same names. One is
a variable name, and one is my new macro variable name. And of course, 
this is from the stats data set I've just made.

Likewise, I'm going to select sp_sd, put it into sp_sd macro variable 
from the stats data set. Let's run Part A first. You'll notice when I
run PROC SQL, it's going to print my new macro variables. Now let's use
those macro variables to standardize the sale price variable in my 
ameshousing data set.

So I'm going to overwrite that existing data set and add in a new 
variable, sp_stan. And you'll notice here it's the sale price minus my
macro variable for sale price mean, and divide those values by my macro
variable for the sale price standard deviation. And again, notice that 
I'm using the ampersands so the macro variable will resolve.

Next, to make sure I've used them correctly, I'm simply going to print 
the first six observations of both sale price and my standardized 
values. And I'm also going to print the mean and standard deviation of 
the sale price and standardized values as well.

So here it would appear that I've done it correctly by just looking at 
a little bit of the data. But with the MEANS procedure, we can see that
the Mean is about zero and the Standard Deviation is about 1. So I did 
standardize it correctly using macro variables. You could also use PROC
STANDARDIZE as well.

Next, I'm going to run the CONTENTS procedure on the cars data set. 
I'll use the VARNUM option to print variables in the order that they 
appear in the data set. This time, I'm going to use the OUT= to option
and save all the contents information in a data set called carscontents.
And I'm going to print that data set. And specifically, I'm only going
to print the name and type variables from that new data set I've saved.
And I'll show you why.

So here is the original contents output. And we actually get quite a bit
more information when we use the out option to save data. But again, 
I've only printed the name and type variables. You'll notice, of course,
the name is just the name of the variable, and the type is either 1 or 2.

And if we look a little bit closer, you'll notice that a value of 1 
indicates numeric data-- Cylinders, EngineSize, Horsepower, and so on.
And a value of 2 indicates character data-- Drive Train, Make, Model, 
Origin, and Type. So I can actually use this new type variable in my 
contents output to read in the name of variables conditionally into a
macro variable. Let's do that.

So again, I'll use SQL to query that new carscontents data set. I'm 
going to start with the SELECT DISTINCT statement. And you can replace 
the key word DISTINCT with UNIQUE. It does the exact same thing.

I'm going to select the UNIQUE values of the name variable. And I'm 
going to put it into a new macro variable called vars_cont for continuous.
And I want these values to be separated by-- and I'll pass it a delimiter
in quotations-- simply just a space. And of course, I'll use the from 
keyword to tell SAS what data set I'm querying-- in this case, carscontents.

And finally, I'll use a WHERE option and provide an expression. I only
want to read in values of the name variable where the type variable is 
equal to 1. So that's going to read in all my numeric data.

Likewise, I'm going to select the distinct values of the name variable.
I'll put them into a new macro variable called vars_cat for categorical.
Again, I'll separate them by just a single space from the carscontents
data set where the type variable is equal to 2. So now I have a set of
continuous variables and categorical variables in two separate macro 
variables.

I'll just go ahead and run the %PUT statement to make sure they were 
read in correctly. So the continuous variables are-- and I'll specify
the macro variable for vars_cont. And the categorical variables are 
&vars_cat. Let's run Part D.

So here is the output from simply running the SQL procedure. But because
I used the %PUT statement, let's go to the log. And then it prints my 
separated, continuous, and categorical variables. The continuous variables
are Cylinders, EngineSize, and so on. The categorical variables are 
DriveTrain, Make, Model, Origin, and Type.

Now, of course, I probably wouldn't stop here. I'd actually go ahead 
and then pass these macro variables into appropriate procedures. For 
example, I'd pass the continuous variables into PROC CORR and PROC 
MEANS, and then I'd pass the categorical variables into PROC FREQ.
But as an exercise, You'll use Part D as starter code and then pass 
the continuous and categorical variables into the appropriate procedures.
*;
