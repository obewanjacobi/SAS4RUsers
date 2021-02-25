/*SP4R05d05*/

/*Part A*/
%macro mymac(dist,param1,param2=,n=100,stats=no,plot=no);

/*Part B*/
%if &dist= %then %do;
   %put Dist is a required argument;
   %return;
%end;

%if &param1= %then %do;
   %put Param1 is a required argument;
   %return;
%end;

/*Part C*/
%if &param2= %then %do;
   data random (drop=i);
      do i=1 to &n;
         y=rand("&dist",&param1);
	     x+1;
	     output;
      end;
   run;
%end;

%else %do;
   data random (drop=i);
      do i=1 to &n;
         y=rand("&dist",&param1,&param2);
	     x+1;
	     output;
      end;
   run;
%end;

/*Part D*/
%if %upcase(&stats)=YES %then %do;
   proc means data=random mean std;
      var y;
   run;
%end;

/*Part E*/
%if %upcase(&plot)=YES %then %do;
   proc sgplot data=random;
      histogram y / binwidth=1;
	  density y / type=kernel;
   run;
%end;

%mend;

/*Part F*/
%mymac(param1=0.2,stats=yes)

/*Part G*/
%mymac(dist=Geometric,param1=0.2,param2=,stats=yes)

/*Part H*/
options mprint;
%mymac(dist=Normal,param1=100,param2=10,n=1000,plot=yes)


*
In this demonstration, I want to duplicate the R script that we saw at 
the beginning of this section with a macro program. Here in Part A I'll
call my macro mymac, and I'll give it two positional parameters dist 
and param1, and four keyword parameters-- param2 set the null value, n
equal to 100 simulated observations, stats equal to no, and plot equal
to no. And inside the macro, we'll change these to Yes to print graphics
or tables conditionally.

But again, in this macro I want to be able to simulate random data 
based on whatever distribution I choose in parameters, change the number 
of simulated values, and generate summary statistics or plots based on 
the parameters, I pass it. First in Part B, I want to do some parameter
validation. So I'm going to use macro statements %IF, and if the 
positional parameter dist is equal to the null value, then I want to do
the following. I'm going to write a message to the log and say to 
myself Dist is a required argument. And then I'm going to execute 
%RETURN
So if dist is null, I want to stop processing this macro. The same can
be said for param1. If param1 is equal to the null value, I'll write
another message to the log saying param1 is a required argument, and 
also execute %RETURN, stopping the execution of the macro program. So 
basically, I need a distribution and I'm assuming all distributions have
at least one parameter. Now if param2 is equal to the null value, then
I'll do the following. I'll create a new data set called random, and 
drop my index variable i, and I'll use a DO loop to go from i equals 1 
to n, my keyword parameter.

I'll create a new variable called y. I'll use the rand function to 
simulate data, and I'll pass it in the parameter dist and param1. I'll 
also use a SUM statement to add a sequence to the random dataset 
x plus 1. Remember your OUTPUT statement to write everything to your 
dataset, and end your DO group. Now if param2 is not null, meaning I'll 
actually pass it a value, I'll do the following. Again I'm going to 
create a random dataset, dropping the index variable. I'll go from i equals
1 to my parameter n. And now I'll simulate data from my distribution 
that I specify in two parameters, param1, and param2. Again I'll add a 
sequence into the dataset.

In Part D, I want to generate the MEANS procedure conditionally. So 
here I'm using the %IF statement, and I'm using the macro function 
%UPCASE to avoid case sensitivity when I'm looking at the parameter 
stats. I'm saying if I pass it the word yes, then I want to do the 
following. I want to generate the MEANS procedure from the random data 
set I just created, and I want to print the mean and standard deviation 
of my variable y.

Likewise, if I change the plot parameter from no to yes, then I want to
generate SGPLOT procedure. Again, on my random dataset I just created. 
So here I'll create a histogram of the variable y I've simulated, and 
I'll change the bin width to 1. And I'll also overlay a kernel density
estimate as well. And finally, I'll stop with the %MEND to conclude 
the creation of my macro. If I submit the macro, nothing should happen
in the log. Now I just have access to use it.

In Part F, I just want to make sure my parameter validation is working.
So notice I'm not changing the distribution argument, which is required. 
So let's run Part F. So here the macro of programs stopped processing 
because it hit the %RETURN statement, and it printed to the log Dist is
a required argument. So my parameter validation is working. Now in Part
G, let's go ahead and use the macro. I'm going to generate geometric 
distributed data with a parameter of 0.2.

I'll leave the second parameter as null, as there isn't one needed for 
the geometric distribution. And this time I'm going to change stats from 
no to yes. So I want to generate my MEANS procedure. I want to find the 
mean and standard deviation of this simulated geometric data. And as you
can see, it prints the Mean of my variable y, which is 4.6 and about 
4.1. As a best practice when you're learning macro programming, you might
want to use the OPTIONS MPRINT statement. This is going to print the 
actual code generated and compiled to the SAS log. This will help you 
find errors in your code more easily.

I'll turn this on and then run the following macro program with the 
parameters listed. Here, I'm simulating from a normal distribution with
parameters 100 and 10. And I'll change the number of simulated values 
to 1,000. I'll ignore the MEANS procedure this time, and generate a plot
of the histogram and kernel density estimate using PROC SGPLOT. So 
here we only generated the histogram and kernel density estimate. We 
didn't run the MEANS procedure.

And if we check the log we'll notice the compiled code. So notice here 
you don't see any macro statements in the code, you only see my DATA 
step and PROC step. And also, all the parameters are resolved inside 
these DATA and PROC steps. So data random, drop equals i. Do i equals 
1 to 1,000 as opposed to ampersand n and so on. So if you have an error,
it's really easy to diagnose it when you use the OPTIONS MPRINT statement.
*;