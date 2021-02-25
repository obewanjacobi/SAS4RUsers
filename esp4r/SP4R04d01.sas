/*SP4R04d01*/

/*Part A*/
data sp4r.random (drop=i);
   call streaminit(123);
   do i=1 to 10;
      rnorm = rand('Normal',20,5);
      rbinom = rand('Binomial',.25,1);
      runif = rand('Uniform')*10;
      rexp = rand('Exponential')*5;
      output;
   end;
run;

proc print data=sp4r.random;
run;

/*Part B*/
data sp4r.random;
   call streaminit(123);
   set sp4r.random;
   rgeom = rand('Geometric',.1);
run;

proc print data=sp4r.random;
run;

/*Part C*/
data sp4r.doloop (drop=j);
   call streaminit(123);
   do group=1 to 5;
      do j=1 to 3;
         rpois = rand('Poisson',25);
         rbeta = rand('Beta',.5,.5);
         seq+1;
         output;
      end;
   end;
run;

proc print data=sp4r.doloop;
run;

/*Part D*/
data sp4r.quants;
   do q=-3 to 3 by .5;
      pdf = pdf('Normal',q,0,1);
      cdf = cdf('Normal',q,0,1);
      quantile = quantile('Normal',cdf,0,1);
      output;
   end;
run;

proc print data=sp4r.quants;
run;

*
In this demonstration, let's go ahead and generate some random data 
sets. In Part A, I'm going to create a data set called random. And I'm 
going to drop the index variable i. I'm going to use the STREAMINIT 
subroutine to set a seed. And in the DO loop, I'm going from i equals 
1 to 10 to simulate 10 total values.

So first I'm going to reproduce the rnorm function using the RAND 
function, specify the Normal distribution, and the parameters here are 
a mean of 20 and a standard deviation of 5.

Next, I'll reproduce the rbinom function, specify the Binomial 
distribution, give it a probability of success of 0.25, and only one 
single trial. So in this case, I'm generating Bernoulli data. Now, if 
I wanted to generate a Uniform distribution between the values of 0 and 
10, I'll simply use the RAND function, specify the Uniform distribution, 
which only generates values between 0 and 1. And I'm going to multiply 
every value by 10.

This gives me values between 0 and 10. And again, the Exponential 
distribution does not have a rate or mean parameter. If I want to generate 
Exponential values with a mean of 5, I'll simply multiply every value 
by the value 5.

And again, remember your OUTPUT statement to write all values to our 
random data set. And the END statement to finish the DO loop. So I'll 
run this DATA step to create the data table and I'll also print it with 
the PRINT procedure.

So here I have a 10 by 4 table. And I've reproduced the rnorm, rbinom, 
runif-- which you can see is between 0 and 10-- and rexp, which appears 
to have a mean of around 5.

Now, perhaps we actually wanted to add in an additional variable. Well, 
remember, do not use another DO loop. Do not apply it to an existing 
data set. We'll just go ahead and add in the new variable, rgeom to that 
random data set using the SET statement. So we'll overwrite that existing 
data table with our changes. And now we're going to generate geometric 
data with a probability of 0.1 for success. And again, I'll run the DATA 
step and use the PRINT procedure.

So as you can see here, I've simply added in that fifth column-- the 
geometric values. In Part C, I'm going to create a data set called doloop.
I'm going to drop the index variable j. Again, duplicate your results 
with the STREAMINIT subroutine. And first, I'm going to create an index 
variable called group, which goes from 1 to 5. And for each group, I'm 
going to generate three observations.

So this will be a data set with 15 total values. And for each iteration, 
I'm going to generate Poisson data with a mean of 25. And also Beta data 
with parameters 0.5 and 0.5.

And remember, if I'm using a nested DO loop and I want to add a sequence 
to my data set, I'll use the SUM statement. Here, I'm calling the new 
variable seq and using a sequence value of 1. So I'll run this DATA step 
and print the new data.

So here I've created the group variable, which you can see is just a 
classification variable. So this is one way I could simulate ANOVA data 
with a classification variable. So each group has three observations. I 
have randomly distributed data for Poisson and Beta data. And I have my 
sequence as the last column 1 through 15.

And finally, I'll show you how to use the PDF, CDF, and QUANTILE functions. 
Here, I'm creating a data set called quants. And I'm going from q equals 
negative 3 to 3 by an increment of 0.5. And one of the things I really 
like about SAS, is you can actually name your variables the same as the 
function name. So here I'm creating a variable name called pdf and I'm 
also using the PDF function.

So here I want to find the density of a Normal distribution. And I'm 
passing it in those quantiles q. And my parameters will be 0 and 1 for 
a standard Normal distribution. The cdf variable will use the CDF 
function as well. Specify the Normal distribution. And again, pass it 
in the quantile to find the cumulative distribution function based on 
the quantile for the standard Normal distribution.

And finally, I'm going to go all the way back to the original q values. 
So quantile variable here should be the same as the q-index variable. 
I'm passing the QUANTILE function, the Normal distribution, and the 
cumulative density function, which I created in the line before. So 
again, I'll run this DATA step and print the output data.

So here I started with my index variable q which ranges from negative 3 
to 3. I find the density function for a standard Normal distribution, 
which goes from 0 back to 0 because it's symmetric. And my cumulative 
density function, which ranges from about 0 to 1. And finally using the 
quantile function, I got back to the original index variable values.
*;