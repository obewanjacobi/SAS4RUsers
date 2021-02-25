/*SP4R06d01*/

/*Part A*/
proc sgscatter data=sp4r.ameshousing;
   plot saleprice * (gr_liv_area age_sold) / reg;
run;

/*Part B*/
ods select anova fitstatistics parameterestimates residualplot;
proc reg data=sp4r.ameshousing;
   model saleprice = gr_liv_area age_sold;
   output out=sp4r.out predicted=pred residual=res rstudent=rstudent;
run;quit;

/*Part C*/
proc sgplot data=sp4r.out;
   scatter x=pred y=res;
   refline 0 / axis=y;
run;

/*Part D*/
ods select basicmeasures histogram qqplot;
proc univariate data=sp4r.out;
   var res;
   histogram res / normal kernel;
   qqplot res / normal(mu=est sigma=est);
run;

/*Part E*/
proc reg data=sp4r.ameshousing;
   model saleprice = gr_liv_area age_sold;
   store mymod;
run;quit;

proc plm restore=mymod;
   score data=sp4r.newdata_ames_reg out=sp4r.pred_newdata predicted;
run;

/*Part F*/
proc print data=sp4r.pred_newdata;
   var saleprice gr_liv_area age_sold predicted;
run;


*
Demo: Multiple Linear Regression
So here we'll practice creating a model using PROC REG, and in some sense, 
this course is meant to build on itself. So we've seen how to read in our
data, and then do summary statistics, as well as a few graphics.

So before we go ahead and model our data, let's use PROC SGSCATTER. We'll
create a panel of scatter plots with saleprice as our response. So here 
in my PLOT statement, I have saleprice and I'm crossing it by two 
variables: gr_liv_area and age_sold, and as an option, I'm using REG to 
add in the line of best fit. So let's see if gr_liv_area and age_sold is
linearly associated with saleprice.

So as you'd expect, saleprice is linearly associated with gr_liv_area 
and age_sold, and there's a positive relationship with gr_liv_area. So as
the ground living area increases, the sale price is expected to increase,
and on the other hand, if the age of the house is old, the sale price 
decreases.

Now that we know these two variables are linearly associated with 
saleprice, let's go ahead and create a model with PROC REG. First, I'm 
going to use ODS SELECT to select the anova, fitstatistics, 
parameterestimates, and residualplot, so I'm only printing that output.

Then I'll go into PROC REG with my ameshousing data set, and in the MODEL
statement, I'll set saleprice equal to both gr_liv_area and age_sold.
And I'm also going to use the OUTPUT statement to save some model 
information, so I'll save a new data set called out, and I'm going to 
save the predicted values with the name pred, residual values with the 
name res, and the R studentized values with the name rstudent.

So let's run part B. Of course, the first thing we see is our analysis of 
variance table, and we do have an overall significant F test. Our R-square
is not too large, only 0.67, and our parameter estimates are significant
for both variables, so gr_liv_area and age_sold are both significant,
and of course, the parameter estimate is positive for gr_liv_area and 
negative for age_sold.

Also by default, we get the residual by regressors for the dependent 
variable, saleprice. So here we have the residual by gr_liv_area, as well
as residual by age_sold, and you can use these plots to see if your 
variability is growing as the variable value grows, as well, and if it
does, it might violate model assumptions.

Now let's use PROC SGPLOT to create a residual-by-predicted plot. So 
again, I save that model information with the OUTPUT statement in the 
out data set. So here I'll use PROC SGPLOT. I'll use the SCATTER statement 
to create a scatter plot of the predicted values and the residuals.

And I'm also going to go ahead and add in a reference line at a value 
of 0 for the AXIS= to Y. Here we see our residual-by-predicted values for
saleprice, and it's possible there are a few outliers, but it doesn't 
appear that the variability is growing overall.

Next, I'm going to analyze the residuals a little bit further. Again, I 
want to see if these residuals violate any assumptions. So here I'm going
to use ODS SELECT. I'll select only the basic measures: table and the 
histogram and Q-Q plot graphics.

So I'll only analyze the res residual values. I'll overlay the normal and 
kernel density estimates on my histogram, and also create a Q-Q plot and 
compare it to a normal distribution with estimated parameters.

So here the mean is 0, which is good. The median is a little bit smaller 
though, so it may be skewed, and the histogram indicates maybe a slight 
skew, but both the normal density and kernel density estimates are very 
similar. And of course, my Q-Q plot indicates that the residuals appear 
to be normal with maybe a couple outliers, or maybe a slight skew at the
tails.

Next, I'm going to go ahead and run the exact same model I ran in part B.
This time I'm going to go ahead and add in the STORE statement and save 
the model information as mymod. And I could have done this before, but I
just wanted to separate the problem. So again, running the exact same 
model, this time saving the model information.

So now that I stored it, I can go ahead and read in that model into PROC
PLM with the RESTORE= option, set it equal to the name mymod. And in the
SCORE statement with the DATA= option, I'm going to tell it the new SAS
data set that I'm going to score.

So I want to score the newdata_ames_reg data set, and I'll save the 
predicted values in a data set called pred_newdata with the OUT= option. 
And here I just use the keyword PREDICTED to request those predicted values.

And finally, I'll go ahead and print the variables saleprice, gr_liv_area,
age_sold, and the predicted values from my model using PROC PLM.

So we first have the PLM procedure table output. Again, this is just 
using the mymod model from the STORE statement in PROC REG. And the 
response, of course, is saleprice and the model effects are the intercept,
gr_liv_area, and age_sold.

And in this data set, I was only scoring five data values. So you can 
compare the saleprice versus the predicted value. Of course, it's probably 
not going to do the best job in this case. I could've used a lot more 
variables to create a more predictive model.

But again, just showing you how to use the STORE statement and then read
in the model in a new data set into PROC PLM for scoring.
*;
