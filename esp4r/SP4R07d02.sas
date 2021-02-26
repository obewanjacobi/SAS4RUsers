/*SP4R07d02*/

/*Part A*/
proc iml;
   call randseed(27606);
   n = 20;
   beta0 = 5;
   beta1 = 2;

   xvals = j(n,1,0);
   call randgen(xvals,"Uniform");
   xvals = xvals*20;

   error = j(n,1,0);
   call randgen(error,"Normal",0,5);

   y = beta0 + beta1*xvals + error;
   print y beta0 beta1 xvals error;

/*Part B*/
   x = j(n,1,1)||xvals;
   xpx = x`*x;
   print x, xpx;

/*Part C*/
   call svd(u,q,v,xpx);
   xpxSVD = u*diag(q)*v`;
   print u q v xpxSVD;

/*Part D*/
   qInv = 1/q;
   qInvDiag = diag(qInv);
   print q qInv qInvDiag;

/*Part E*/
   betaHat = (v*qInvDiag*u`)*(x`*y);
   print betaHat;
quit;


*
Demo: Simple Linear Regression From Scratch
So in this demonstration, I want to simulate some simple linear regression 
data, and then I want to use some modules to actually analyze it and find 
my parameter estimates. Of course, I could pass this data PROC REG but 
let's do it in IML.

So again, our parameter estimates for BetaHat are the intercept and slope,
which is a 2 by 1 vector and I find that by doing x transpose x inverse x 
transpose y. Again x is my design matrix, y is my vector of observations. 
I'm going to do it a little bit differently. In order to invert my x 
transpose x matrix, I'm going to use the singular value decomposition tool
as a help. So when I apply the singular value decomposition to x transpose
x, I get back UDV transpose. And that's much easier to invert. To invert 
this I simply take the transpose of v, take the inverse of d, which is a
diagonal matrix, so that's easy. And then multiply it by u transpose. So
here I'm trying to make sure my inverse is much more stable. But of course,
in a simple linear regression model, you probably won't have to worry about
it. But this will give us a chance to look into the singular value
decomposition subroutine and see some more syntax. If you wanted you could 
actually use the INV or SOLVE functions just like you would in R to take 
an inverse.

The first thing I'm going to do here is go into interactive mode. In Part
A, I'm going to run PROC IML statement, and then I'm going to use the 
RANDSEED subroutine to set a seed. So the same function as set.seed in R. 
Here I'm applying the seed 27606. And for this simple Linear Regression 
Model, I want a total number of observations to be 20. I want my population
parameters for beta0, my intercept, and beta1, my slope, to be 5 and 2. 
I'm going to use the J function to initialize a matrix xvals which is 20
by 1. And then I'm going to fill that xvals vector with the RANDGEN 
subroutine with uniform data. So this is going to be uniformly distributed 
between 0 and 1. And to get it between 0 and 20, I'll just multiply that 
vector by 20. Next, I'm going to create the error. Again, I'm going to 
initialize a vector, which is 20 by 1. I'll use the RANDGEN subroutine, 
pass it my error vector, and simulate normal data with a mean of 0 and 
a standard deviation of 5. Now to put it all together to get y, my 
observation, I have beta0, which is a scalar, plus beta1, which is a 
scalar, times xvals plus error, which are both 20 by 1 vectors.

Let's print the matrices we've created here in Part A. So first I have 
my y observations, my population parameters 5 and 2, my x values, and
error that I simulated.

In Part B, I'm going to create the design matrix called x. So I'm going 
to create a column of 1's that's a 20 by 1 vector with every element as 
one. And I'm going to column bind using the two vertical pipes operator 
to the xvals vector. So again, that's a vector of 1's and my predictor 
values. Next, I'll transpose x with the grave accent, use the matrix 
multiplication operator star times x again. So that's going to give me 
x transpose x, or xpx for x prime x . And I'll print those two matrices.
So here I have my design matrix and x transpose x.

In Part C, I'm going to do the singular value decomposition. Again, 
that's a subroutine, so we'll execute it with a CALL statement. You'll 
notice I'm only passing one argument, xpx. And I'm creating three
matrices, u, q, and v. Now, to make sure I know exactly how it's 
decomposed, I'm going to put it back together. So I'll call this xpxSVD.
Which should be the exact same as x transpose x. So here I have u times 
the diagonal matrix for q, my singular values. And DIAG is the same 
function as R. So it just diagonalizes a vector to a matrix. Multiply
it by v transpose. And I'll print these newly created matrices and my 
x transpose x matrix again.

So here I have the u matrix, my singular values for q, and my v matrix.
And I put it all back together, so it should be exactly the same as x 
transpose x. Now to take the inverse, I'm going to create the vector 
qInv, which will be equal to 1 divided by q. And again, q is a 2 by 1 
vector, so it's just simply going to flip every element of the vector.
Then I'll take the DIAG function applied to qInv. And now I have everything
I need to take the inverse. Let's print these matrices first. So here I 
have my singular values from before. I inverted each element and created 
the diagonal 2 by 2 matrix.

Finally, I'm going to find my parameter estimates betaHat. So again I
have to do x transpose x inverse times x transpose y. I use the singular
value decomposition to make this more stable, in case I was doing a much
larger problem. So here I have v times qInvDiag times u transpose, and I
multiply that by x transpose y. And then I'll finally print my parameter 
estimates. And here you see my beta0 Hat estimate is 4.7, and beta1 Hat 
is 2.1. Very close to my population parameters 5 and 2.
*;
