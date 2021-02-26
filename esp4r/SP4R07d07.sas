/*SP4R07d07*/

/*Part A*/
proc iml;
   start simpleRegFunc(n,beta0,beta1);
      xvals = randfun(n,"Uniform");
      xvals = xvals*20;
      error = randfun(n,"Normal",0,5);
      y = beta0 + beta1*xvals + error;
      x = j(n,1,1)||xvals;
      betaHat = inv(x`*x)*(x`*y);
      return(betaHat);
   finish;

/*Part B*/
   n = 20;
   reps = 1000;
   beta0 = j(reps,1,.);
   beta1 = j(reps,1,.);
   call randseed(27606);

/*Part C*/
   do i=1 to reps;
      betas = simpleRegFunc(n,5,2);
      beta0[i] = betas[1];
      beta1[i] = betas[2];
   end;

/*Part D*/
   mean0 = mean(beta0);
   sd0 = std(beta0);
   call qntl(percentiles0,beta0,{.025, .975});
   
   mean1 = mean(beta1);
   sd1 = std(beta1);
   call qntl(percentiles1,beta1,{.025, .975});

   out0 = mean0//sd0//percentiles0;
   reset noname;
   print out0[colname="Beta0" rowname={"Mean","Standard Deviation","LCL","UCL"}];

   out1 = mean1//sd1//percentiles1;
   print out1[colname="Beta1" rowname={"Mean","Standard Deviation","LCL","UCL"}];
quit;



*
Demo: Sampling Distribution: Entirely in IML
First, to assist in my analyzes, I'm going to create the SimpleRegFunc 
function, which has three arguments-- the number of observations and
the population parameters, beta 0 and beta 1. Then I go ahead and 
simulate my x values, my error, create my observations, and return my 
parameter estimates, just like I've done before. In Part B, we're going 
to set up the simulation, so I want to simulate 20 observations in each 
data set. I'm going to do 1,000 replications, and I'll initialize two 
vectors to save my data in each iteration-- my beta 0 and beta 1 vector.
So here, these are 1,000 by 1 vectors, and the period denotes a null 
value. And don't forget to set your seed.

In Part C, I'll do the simulation. I'm going to use the DO loop. I'll 
go from i equals 1 to 1,000 reps, and in each iteration, I'm creating 
betas using the Simple Reg Function, passing in the value of 20, 5, and
2. And in each iteration, I'm going to save my parameter estimates, so 
I'm going to pull out the first element of the beta's vector, which is 
the estimate for the intercept, and then I'll pull out the second element
of the beta's vector, which is the estimate for the slope.

After the simulation, I'll go ahead and find some summary statistics of
my sampling distribution. So I'll find the mean and standard deviation,
as well as the percentiles for the 2 and 1/2 and 97 and 1/2 percentile.
I'll do the same thing for Beta 1. I'll create a vector of those results,
and then I'll print it with the following column name and row name options.
Let's run this simulation.

So here, we have estimates from my sampling distribution for beta 0 
in beta 1. So the Mean is about 5, the Standard Deviation is about 2.4, 
and my confidence limits are about 0 and 10. And it's much tighter for
beta 1, so the Mean is 2, the Standard Deviation is about 0.2, and my 
confidence limits are about 1.6 and 2.4. And again, this simulation, we 
did everything directly in IML. We didn't use any other SAS procedures.
*;