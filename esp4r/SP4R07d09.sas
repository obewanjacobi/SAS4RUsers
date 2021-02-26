/*SP4R07d09*/

/*Part A*/
proc iml;
   startTime = time();
   simulations = 1000;
   sampleSize = 20;

/*Part B*/
   simulationNumber = 1:simulations;
   each = j(simulations,1,sampleSize);
   simulationNumber = repeat(simulationNumber,each)`;

/*Part C*/
   call randseed(27606);
   total = simulations*sampleSize;
   beta0 = 5;
   beta1 = 2;
   xvals = randfun(total,"Uniform");
   x = xvals*20;
   error = randfun(total,"Normal",0,5);
   y = beta0 + beta1*x + error;

/*Part D*/
   create sp4r.simulation  var {simulationNumber x y};
   append;
   close sp4r.simulation;

/*Part E*/
   submit;
      ods select none;
      ods output ParameterEstimates=sp4r.params;
      proc reg data=sp4r.simulation;
	     by simulationNumber;
         model y=x;
      run;
	  ods select default;
   endsubmit;

/*Part F*/
   use sp4r.params;
   read all var {estimate} where (variable='Intercept') into beta0;
   close sp4r.params;

   use sp4r.params;
   read all var {estimate} where (variable='X') into beta1;
   close sp4r.params;

/*Part G*/
   mean0 = mean(beta0);
   sd0 = std(beta0);
   call qntl(percentiles0,beta0,{.025, .975});
   
   mean1 = mean(beta1);
   sd1 = std(beta1);
   call qntl(percentiles1,beta1,{.025, .975});

   out0 = mean0//sd0//percentiles0;
   reset noname;
   print out0[colname="Beta0" 
      rowname={"Mean","Standard Deviation","LCL","UCL"}];

   out1 = mean1//sd1//percentiles1;
   print out1[colname="Beta1" 
      rowname={"Mean","Standard Deviation","LCL","UCL"}];

   total = time() - startTime;
   print total[colname="Elapsed Time"];
quit;


*
Demo: Sampling Distribution: Calling SAS Procedures with the BY Statement
This demonstration shows you the efficient way to do a simulation and 
use other SAS procedures. We will avoid the use of the DO loop. First, 
I'm going to time my simulation. I'm going to do 1,000 simulations just
like before, and again, each data set will have 20 observations. And 
Part B is where the magic happens.

First, I'm going to create simulation number vector, which is going to 
be a sequence from 1 to 1,000. Next, each is going to be a 1,000 by 1 
vector with each element as the sample size of 20. And finally, I'm going
to create a new variable called simulationNumber, and I'm going to use
the REPEAT function to repeat the simulation number. That's a sequence 
from 1 to 1,000.

I'll repeat each element 20 times. So I have a value of 1 repeated 20 
times, then I have a value of 2 repeated 20 times, and so on. So I have
a 20,000 by 1 vector indicating the simulation number. This is what I'm 
going to pass to the BY statement in my procedure.

Next, I'm going to go ahead and simulate all the data for all samples, 
so I'll specify the number total, which is simulations by sample size. 
That's 1,000 by 20 for 20,000. And now, I'm going to simulate all the 
data, so I'm passing that total variable into the RANDFUN function. So 
I'm simulating 20,000 x values and 20,000 errors. And now, my observation
vector y is 20,000 by 1 as well.

Next, in Part D, I'll create a new SAS data set called simulation, and
I'll append the variables simulationnumber x and y. So this will be a 
20,000 by 3 data set. In Part E, I'll submit the following code. Again,
I'll use ODS SELECT NONE to avoid writing any results to the results 
page, and with the ODS OUTPUT statement, I'm going to save the parameter 
estimates tables in a data set called params.

In PROC REG, I'll specify the data set as simulation. I have the same
MODEL statement for my simple linear regression data, y equal to x, and 
now in the BY statement, I'm passing it the simulationnumber variable. 
So I'm telling PROC REG how to analyze this data. So I'm saying analyze 
each data set separately, and SAS will do this much more efficiently 
than if you were to call PROC REG each time individually. And finally, 
put ODS SELECT back to its default, so you can print to the results page 
again.

Then in Part F, I'm going to read in that params data set from ODS 
SELECT's statement. I'm going to read in all the observations from the 
variable estimate, where the variable is equal to intercept, and I'll show 
you in just a minute where these two names came from in the params data 
set. And I'll read all that into a new matrix called beta 0. Next, I'm 
going to read in all the observations for the variable estimate where the 
variable is equal to x, and again, I'll read that into a matrix 
called beta 1.

Then in Part G, I'll go ahead and find the same summary statistics and 
also print the elapsed time. Let's run this demo. Again, we get very 
similar results for the sampling distribution, but look how much quicker 
this simulation ran. Less than 3 seconds, and the previous demonstration 
took over 100 seconds. So again, much more efficient to use a BY statement
in your procedure than calling the procedure iteratively in a DO loop.

And I wanted to show you one last thing. Remember, I saved all the 
results for each simulated data set, so I'm going to go into my SP4R 
library and open up the PARAMS data set. You'll notice, first, I have the 
simulation number, so for example simulation number 1, output 2 results. 
Simulation 2 had 2 results and so on. And it's stored two variables for my 
model-- the intercept and x variable-- and these are the terms I used when 
I was reading it back into IML in my READ statement.

And here are my estimates for each data set. So my first intercept 
estimate was 2. My first slope estimate was 2.1. And then in my second 
data set, my estimates were 4.05 and 2.02 and so on. So this is the data 
set I was reading back into IML to find the summary statistics, but you 
could also use PROC MEANS to analyze the sampling distribution if you wanted.
*;