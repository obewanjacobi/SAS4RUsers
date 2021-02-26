/*SP4R07d08*/

/*Part A*/
proc iml;
   start simpleRegSub(xvals,yvals,n);
      beta0 = 5;
      beta1 = 2;
      xvals = randfun(n,"Uniform");
      xvals = xvals*20;
      error = randfun(n,"Normal",0,5);
      yvals = beta0 + beta1*xvals + error;
   finish;

/*Part B*/
   n = 20;
   reps = 1000;
   beta0 = j(reps,1,.);
   beta1 = j(reps,1,.);
   call randseed(27606);
   startTime = time();

/*Part C*/
   do i=1 to reps;
      call simpleRegSub(x,y,n);

      create sp4r.simulation  var {x y};
      append;
      close sp4r.simulation;

/*Part D*/
      submit;
         ods select none;
         ods output ParameterEstimates=sp4r.params;
         proc reg data=sp4r.simulation;
            model y=x;
         run;
         ods select default;
      endsubmit;

/*Part E*/
      use sp4r.params;
      read all var {estimate} into estimates;
      close sp4r.params;

      beta0[i]=estimates[1];
      beta1[i]=estimates[2];
   end;

/*Part F*/
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
Demo: Sampling Distribution: Iteratively Calling SAS Procedures from IML
In this second demonstration, I want to show you what not to do. This is 
the inefficient method. First, in Part A, I'm going to create a subroutine
to help with my analyses. Here, I'm going to create two matrices, xvals and
yvals, and pass in one input argument, the number of observations to 
simulate. And again, I have the same simple linear regression data, but 
this is going to return my x values and my observations.

In Part B, I'm initializing the simulation again. I'll let n equal to 20
observations per data set. I'll do another 1,000 replications, and I'll 
save everything in the beta0 and beta1 vectors. I'll set a seed, and I'm 
also going to time this simulation using the TIME function. So I'll hold 
the time in a new variable called startTime.

Now, the DO loop in this case is where the inefficiency lies, so I'm going
from i equal 1 to 1,000, and in each iteration, I'm going to generate x 
values and y values. And then I'm immediately going to create a new SAS 
data set called simulation and pass x and y to that data set. Next, I'm 
going to submit the following code.

I'm first going to turn off all results page output with ODS SELECT NONE. 
This will make it just a little bit quicker, and I don't want to see every 
result for every analyzed data set. Next, I'm going to use ODS OUTPUT to
save the parameter estimates table in a data set called params.

Then I'll run the REG procedure on the simulation data set that I just 
created and create the simple linear regression model y equal to x. And 
then just remember to turn back on ODS SELECT DEFAULT. That way, you can 
actually get results printed to your page again.

In Part E, we're still inside the loop. We're going to open up the params 
data set, and we're going to read in all observations for the variable 
estimate. We'll read that into a new IML matrix called estimates and then
save those estimates in the appropriate vector for beta0 and beta1. 
Finally, we'll go ahead and create summary statistics just like we've 
done before on the previous demonstration.

And notice here, I'm also going to print the total time it took. So I'm 
subtracting out the TIME function from the time that I saved earlier. Let's
see the elapsed time. So here, you'll notice we get very similar results
for my beta0 and beta1 sampling distribution, but it took 106 seconds to 
get these results. Let's look at a better way to use SAS procedures in IML
and avoid looping to create a simulation.
*;