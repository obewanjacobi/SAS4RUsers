/*SP4R06d09*/

/*Part A*/
proc sgplot data=sp4r.grass;
   vline variety / group=method stat=mean response=yield;
run;

/*Part B*/
proc mixed data=sp4r.grass method=REML;
   class method variety;
   model yield = method / solution ddfm=kr2;
   random variety method*variety;
   lsmeans method / pdiff;
   estimate 'A vs. B and C' method 1 -.5 -.5;
run;

/*Part C*/
ods select type3;
proc mixed data=sp4r.grass method=type3;
   class method variety;
   model yield = method / solution ddfm=kr2;
   random variety method*variety;
   lsmeans method / pdiff;
   estimate 'A vs. B and C' method 1 -.5 -.5;
run;


*
Demo: Two-Way Mixed Model
In this demonstration, we'll do a two-way mixed model. First, I'm going 
to use PROC SGPLOT to look at the grass data set. I'll use the VLINE 
statement and specify my random effect, variety, and then as an option, 
I'll use the GROUP= option to specify the method, my fixed effect. The 
stat will be the mean, and the response, in this case, is yield. So let's
see what this plot produces.

So here, my Y axis is the mean yield and my X axis is the variety. And 
you'll notice my three lines (blue, red, and green) are the methods. So
how does the yield change for each method as I move across variety? The 
first thing you notice is in blue. Method A has the highest yield for 
all varieties. And also, moving from variety 4 to variety 5 for methods
B and C, there seems to be a little bit of an interaction, so these
lines are not parallel.

In part B, I'll use PROC MIXED on the grass data set, and here I'm saying
METHOD=REML. Again, this is the default. You don't have to specify this
method if you don't want to. Next, in my CLASS statement, I'll specify 
all the classification variables (fixed effects or random effects), so
method and variety. In the MODEL statement, I'm setting yield equal to 
the fixed effects method and I'm using the SOLUTION= option.

And as a best practice, SAS encourages you to use the DDFM=KR2 option. 
So this just applies a small correction to your standard errors if your
data is nonlinear. If you don't do this, you may not control that Type 
I error rate. So regardless, as a best practice, use this option. In the
RANDOM statement, I have my random effects, variety and method-by-variety
interaction. In the least square means, I'll specify my fixed effects
method and I also want the p-values for the differences of effects 
using the PDIFF option.

In the ESTIMATE statement, I'm going to estimate the expected yield for
A versus B and C, so the coefficients for method will be 1, minus 0.5,
and minus 0.5. You'll notice I don't have any coefficients for variety
and method by variety because these are random effects, and the expected
values of those values are 0.

Our estimation method, again, is REML, and we did apply the KR2 
(Kenward-Roger2) option in the MODEL statement to adjust our degrees 
of freedom and standard error under possible nonlinearities. Here my
levels for method are A, B, and C. Variety is 1 through 5. My 
dimensions... I have three covariance parameters, four columns in my X 
design matrix. That's the intercept plus the three method effects. And 
my Z matrix, which is my random effects design matrix, has 20 columns. 
So that's the five variety and the 15 interaction effects (method by 
variety).

There's only 90 observations used in this grass data set. This is an 
iterative optimization algorithm, and here it only took one iteration 
because it had a great starting value and the convergence was met, so we
can go ahead and use our model. My covariance estimates for variety, the
interaction, and the residual are as follows: 0.44, 0.7, and 18.4. It 
appears that an overwhelming majority of the errors is coming from the 
residual, so not much error from the variety and interaction effects, 
which is good.

We also have the fit statistics table, if you want to compare different 
models, the parameter estimates for our fixed effects, using the SOLUTION
option in the MODEL statement, the Type 3 Tests of Fixed Effects, so
testing the fixed effects jointly. Here I have two numerator degrees of 
freedom and eight denominator degrees of freedom, so method is significant
overall. My estimate from the ESTIMATE statement: So A versus both B and
C gives me an estimate of about 6.7. So A is expected to have a yield of 
6.7 greater than B and C, and that is statistically significant.

My least square means for each level of method individually: Again, you 
can see that method A is definitely the highest at 23, and B and C is 
right around 15 and 16, and the differences of those least square means
(A versus B, A versus C) are both statistically significant, and B and 
C appear to be similar.

I just wanted to show you one more option in PROC MIXED. I'm going to
run the exact same model. I'm just going to change the METHOD= option to
TYPE3. So that's a method-of-moments estimation for the variance 
components, and here, I'm only going to return the TYPE3 table with my
ODS SELECT statement. Let's go ahead and run this.

I just wanted to show you that the method-of-moments estimates will
actually produce the expected means squares table, so it actually writes
out the expected mean squares for every level of your table and also 
shows you the appropriate error term if you wanted to test certain 
effects. Why did I think this was neat? Because in school, I had to 
actually go ahead and create this table by hand, but SAS will actually 
do it for you, so if you're familiar with these method of moments and 
these expected mean squares, this might be very helpful to you.
*;