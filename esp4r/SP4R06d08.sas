/*SP4R06d08*/

/*Part A*/
proc sgplot data=sp4r.crab;
   histogram satellites;
   density satellites / type=kernel;
run;

proc means data=sp4r.crab;
   var satellites width weight;
run;

proc freq data=sp4r.crab;
   tables satellites color spine;
run;

/*Part B*/
proc genmod data=sp4r.crab plots=resraw;
   class color(param=ref ref='1') spine(param=ref ref='1');
   model satellites = width weight color spine 
      / dist=poi link=log type3;
   estimate 'my estimate' intercept 1 width 25 weight 2.5 
      color 1 0 0  spine 1 0 / e exp alpha=.05;
   output out=sp4r.out p=pred resraw=res;
run;

proc sgplot data=sp4r.out;
   scatter y=res x=pred;
run;

/*Part C*/
proc genmod data=sp4r.crab plots=resraw;
   class color(param=ref ref='1') spine(param=ref ref='1');
   model satellites = width weight color spine 
      / dist=negbin link=log type3;
   estimate 'my estimate' intercept 1 width 25 weight 2.5 
      color 1 0 0  spine 1 0 / e exp alpha=.05;
   output out=sp4r.out p=pred resraw=res;
   store mymod;
run;

/*Part D*/
data sp4r.newcrab;
   input Color Spine Width Satellites Weight;
   datalines;
2 2 25 0 2.5
;run;

proc plm restore=mymod;
   score data=sp4r.newcrab out=sp4r.scores / ilink;
run;

proc print data=sp4r.scores;
run;


*
Demo: GENMOD Procedure
In this demonstration, I want to model the crab data set using PROC 
GENMOD. First, let's look a little bit further into the crab data set
using SGPLOT, MEANS, and FREQ procedures. So here in SGPLOT, I'm going
to create a histogram of the number of satellites-- our response-- 
and I'm going to overlay a kernel density estimate as well.

In PROC MEANS, I'm going to analyze satellites' width and weight, and 
in PROC FREQ, I'm going to analyze the variable satellites' color and 
spine. Let's run part A.

So here we have Poisson data, or count data. You'll notice we have
lots of values of 0, so we do have a skewed right distribution as 
expected. The mean number of satellites-- or male crabs nesting near 
a female horseshoe crab-- is about 3. The mean width and weight of a 
female horseshoe crab is about 26 and 2.4.

Here we can see the number of satellites ranges from 0 to 15, and 
there's a frequency of 62 corresponding to 0 satellites, followed by 
16 for 1, all the way up to 15 satellites nesting near, in this case,
1 female horseshoe crab. So again, a very skewed distribution here.

Finally, for color, it appears that a value of 2 (medium brown) has 
the most at 95, and for spine, a value of 3 is the largest at 121. That
is, both spines worn or broken unfortunately.

All right. Let's go ahead and create a model now in PROC GENMOD. In my
CLASS statement, I'm going to specify a color, and I'll give it a 
reference level of 1, which is light medium, and spine will be reference
level of 1 as well. That's both spines are good. In the MODEL statement,
I'll specify the response satellites. I'll set that equal to all four 
of my variables in my crab data set: width, weight, color, and spine. 
And as an option, I'm going to tell SAS this is a Poisson distribution 
with a DIST= option.

It does use the log link as a default. I like to throw it in just to 
remind myself. So I like to say LINK=LOG. And finally, in the MODEL 
statement, I'll use the Type 3 option. This uses the likelihood ratio 
statistic to test values jointly.

Next, in the ESTIMATE statement, I want to predict the number of 
satellites for a crab with a width of 25, a weight of 2.5, a color 
that's medium brown, and a spine that is 1 (worn or broken). So I 
specify all those coefficients appropriately including my intercept. 
Again, I'm using the E option to make sure I've specified the coefficients
correctly. And remember before in PROC LOGISTIC, I was using the ILINK
option. That was to predict on the original data scale.

Well, because I'm using the LOG LINK function, I can actually just 
use the EXP option to exponentiate my estimates. Now you really don't 
need to remember which to use. If you want, you can just go ahead and
always use the ILINK option, but I just wanted to show you the EXP 
option in this case,

and finally, I'll save my predicted values.

So here, we're using 173 observations. My link function is the log. 
My distribution is Poisson. Parameter information' criteria for 
assessing goodness of fit. We have lots of different statistics here. 
Let's make note of one, the AICC, which is a 921. We'll come back to 
that value. Algorithm converged, which is good. Now I can go ahead and
use my model,

my parameter estimates, confidence limits, and so on. So here we see
only weight and two levels of color are significantly different from 0.
The rest are not significant at the 0.05 level.

Here is the table generated from the TYPE3 option in the MODEL statement,
so I'm testing for significance jointly for classification variables. 
For example, I'm testing all levels of color and spine, which has 3 and 
2 degrees of freedom respectively.

So here, the classification variable for color is significant at 0.02
but not for spine, which we would expect from that parameter estimate's
table. And again, weight is significant, but width is not.

Unfortunately, in PROC GENMOD, the E option isn't the most helpful. 
Here are the coefficients that I specified in my ESTIMATE statement, but 
it doesn't actually use the name of the coefficient. It just says param 1,
param 2 and so on, so you do have to actually match it up with your
parameter estimates table.

So, for example, param 1 corresponds to the first effect in the parameter 
estimates table intercept. Param 2 corresponds to width. Param 3 corresponds 
to weight and so on. But looking at my estimates, we can see we have the
original estimate on the original data scale is 0.88. And if we 
exponentiate that or use the ILINK option, the estimate is 2.41.

So we estimate that on average, there are 2 and 1/2 crabs near a female 
horseshoe crab with a width of 25, weight of 2.5, a color that's medium 
brown, and 1 worn or broken spine. And our confidence limits here are
between 1.6 and 3.5.

Now remember, the Poisson distribution in general has a single parameter, 
most often called lambda. This value is the mean and variance of the 
distribution, so the mean and variance actually cannot vary freely. And 
this is actually one of those classic data sets that experiences 
over-dispersion, meaning it would be best if the mean and variance could
vary freely.

So unfortunately, when we use the Poisson distribution, we were 
underestimating our standard errors for the parameter estimates, meaning
we were overestimating its significance. So we want to change the 
distribution from Poisson to negative binomial, again to allow the mean 
and variance to vary freely. So the only thing different in part C is 
I've changed the DIST= option to negative binomial. Let's go ahead and 
run part C.

So we have a lot of the same information, but remember, I said make note
of the AICC of 921. Here, when I use the negative binomial distribution,
I get a value of 764, and of course, smaller is better. So this model 
fits better than the previous one when comparing AICC, and you could also
compare the other goodness-of-fit measures.

But if you were to look through the rest of the tables, you'd see quite a 
few changes. There are actually no parameters significant at the 0.05 level
now. Before, we had a few, and my estimate changes slightly from 2.41 to 
2.34.

But the main point here was to just show you how easy it is to change your 
distribution just like you would in R. Again, all I did was change the DIST= 
option to negative binomial.

And I just want to show you one more thing here in Section 6.2. Imagine 
you want to create a new data set for scoring. How would you do it? You'd
use your DATA step. I'm calling it newcrab. And you need to make sure 
the variable names that you're creating for your new SAS data set are 
the exact same variable names used in the data set to create your model.

So here, my inputs are color, spine, width, satellites, and weight (the 
exact same names as the crab data set). Then I'll go ahead and give it 
some values: color of 2, spine of 2, width of 25 (It doesn't matter 
what number I put in for the number of satellites because that's my 
response and I'm going to be scoring this data set.), and a weight of 
2.5.

Most likely, you would add a bunch of different observations. Otherwise,
you could just go ahead and specify these coefficients in your ESTIMATE
statement. But just wanted to make sure you knew the variable names in
your new data set have to be the same as the variable names in your 
original model data set.

So we'll create this data set. I saved the model from part C with the 
STORE statement, so that was under the negative binomial distribution.
I used PROC PLM to restore that model, and I'm scoring the new data 
set I just created called newcrab.

I'll save a new SAS data set with this information called scores. And 
as an option, just like I've used before with LOGISTIC and PROC GENMOD,
use the ILINK option to score data sets on the original data scale. 
And finally, print your new SAS data set.

So this will be the same value from my ESTIMATE statement, just showing
you how to create a new SAS data set to read into PROC PLM in this 
case. So the predicted value here is 2.34, given these regressors.
*;