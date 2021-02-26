/*SP4R07d05*/

/*Part A*/
proc iml;
   call randseed(27606);
   n = 20;
   beta0 = 5;
   beta1 = 2;
   xvals = randfun(n,"Uniform");
   xvals = xvals*20;
   error = randfun(n,"Normal",0,5);
   y = beta0 + beta1*xvals + error;
   x = j(n,1,1)||xvals;
   betaHat = inv(x`*x)*(x`*y);
   print betaHat;

/*Part B*/
   create sp4r.betaData var{xvals y};
   append;
   close sp4r.betaData;

/*Part C*/
   submit;
      ods select fitplot parameterestimates;
      proc reg data=sp4r.betaData;
         model y = xvals;
      run;
   endsubmit;
quit;

*
Demo: Submitting SAS Procedures
In this demonstration, let's go ahead and use the SUBMIT block to submit
the REG procedure directly in IML. And I'm going to generate the same 
simple linear regression data-- set a seed, 20 observations, intercept 
and slope is 5 and 2, uniformly distributed x values between 0 and 20, 
normally distributed error, create my observations and parameter estimates 
the exact same way. Let's go into interactive mode and run Part A first.

This will be the exact same analyses from before-- 4.7 and 2.1. Now, to 
make sure I've actually been doing this right all along, let's go and 
create a new SAS data set called betaData from the variables I've created,
xvals and y. And make sure to append and close your data sets.

Once you create that in Part B, you can then go ahead and run whatever 
procedure you want on that data set in the SUBMIT block. So after the 
SUBMIT statement, I'm going to specify ODS SELECT to print only the fit 
plot and parameter estimates. Then I'm going to run the REG procedure,
just like we saw in Chapter 6. So I'm running PROC REG on betaData, and
my model is simply y equals xvals for my simple linear regression model. 
And finish up with your ENDSUBMIT statement.

So here are my parameter estimates from IML, and here are the same
parameter estimates when I pass the data to the REG procedure. So 
check-- I've done it correctly in this chapter. And you'll notice we 
also get the PROC REG graphics. We get the line, the best fit, confidence 
limits, and prediction limits. Now, of course, if this was the last piece 
of code we were to run in IML, you could have just run the QUIT statement
and then the REG procedure on that new SAS data set, but assume here, you
have lots of other IML code that you want to submit.
*;