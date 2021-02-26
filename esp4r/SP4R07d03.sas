/*SP4R07d03*/

/*Part A*/
proc iml;
   start simpleRegFunc(xvals, yvals);
      n = nrow(xvals);
      x = j(n,1,1)||xvals;
      y = yvals;

      betaHat = inv(x`*x)*(x`*y);
      return(betaHat);
   finish;

/*Part B*/
   call randseed(27606);
   n = 20;
   beta0 = 5;
   beta1 = 2;
   xvals = randfun(n,"Uniform");
   xvals = xvals*20;
   error = randfun(n,"Normal",0,5);
   y = beta0 + beta1*xvals + error;

   betas = simpleRegFunc(xvals,y);
   print betas;

/*Part C*/
   start simpleRegSub(betaHat, sigmaHat, xvals, yvals);
      n = nrow(xvals);
      x = j(n,1,1)||xvals;
      y = yvals;

      betaHat = inv(x`*x)*(x`*y);
      pred = x*betaHat;
      sse = sum( (y-pred)##2 );
      sigma2Hat = sse / (n-1);
      sigmaHat = sqrt(sigma2Hat);
   finish;

/*Part D*/
   call simpleRegSub(betas,sHat,xvals,y);
   print betas sHat;

/*Part E*/
   reset storage=imlcat;
   store;
   show storage;
quit;



*
Demo: Creating Functions and Subroutines
In this demonstration, I want to create functions and subroutines to 
assist in my analyses of the simple linear regression data set from 
before. But first, go into interactive mode. In Part A, I'm going to 
create the simpleRegFunc function, which has two arguments, xvals and 
yvals. I'll let n be the number of rows in the xvals argument, and I'll 
create the design matrix x. So I'll concatenate a column of 1's to those 
x values. And here, I'm just changing the name of yvals.

My parameter estimate is betaHat. I'll do a little bit differently than 
before. I'll just use the INV function. So x transpose x inverse, x 
transpose y, and because it's a function, I have to use the RETURN 
statement. Let's run Part A. Next, in Part B, I'm going to generate some 
data. I'm first going to set a seed with a RANDSEED subroutine, and then 
I'm going to generate the same data as before. So I have 20 observations,
my intercept is five, my slope is 2. This time I'm not using the RANDGEN
subroutine. I'm using the RANDFUN function to vectorize my code.

So my x values are uniformly distributed between 0 and 20. My error is
normally distributed with a mean of 0 and a standard deviation of 5. And 
my observations are beta0 plus beta1 x plus my error. I'm then going to 
use my SIMPLEREG function and pass it in the x values that I've simulated 
and my y observations. And I'll print my parameter estimates. So here I 
use the function to find those parameter estimates, 4.7 and 2.1.

Now what if I wanted more than one matrix to be created? Well, of course,
with the function I can only return a single matrix. So let's create a 
subroutine to assist. Here, I'm calling it simpleRegSub, and I'm going 
to create two matrices, my betaHat vector and sigmaHat, my estimate for 
the root mean squared error. And I'll have the same two input arguments,
xvals and yvals. Inside the subroutine, I'll find the number of 
observations, create the design matrix, and change the name y again.

Next, I'm going to find betaHat the same as my function. And this time, 
I'm going to create predicted values, which is just my design matrix,
x, times my parameter estimates, betaHat. I'll find my sum of squared 
error, which will be y minus my predicted values. I'll square every 
element in that vector, and then sum up all the elements. And then 
sigma2Hat will be equal to my sum of squared error divided by n minus 
1. And sigmaHat will just be the square root of that value.

Finally, I'll pass the x values and y values to my simpleRegSub
subroutine that I generated in Part B. And I'm creating betas and sHat. 
Let's print those results. So here I have the same betas vector, 4.7 
and 2.1, and now my root mean squared error estimate is about 6.49. So
here I've created two separate matrices. And in Part E, I just wanted 
to show you how to create and use a catalog. So I'm creating the IMLCAT 
catalog in my work directory, and I'm using the STORE statement as is.
So I'm storing everything that I've done in this session.

And finally, I'll use the SHOW STORAGE statement to see exactly what's 
in that catalog. So here it prints the contents of the catalog, IMLCAT.
Here, I have all my matrices that I've created, and also the modules, 
simpleRegFunc and simpleRegSub. You'll notice it also has the RANDFUN 
function, which is a built in function, but I used it here in the workspace.
*;
