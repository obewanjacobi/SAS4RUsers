/*SP4R06d05*/

/*Part A*/
%let cont_vars = lot_area gr_liv_area garage_area basement_area deck_porch_area age_sold;
%let cat_vars = heating_qc central_air fireplaces lot_shape_2;

proc glmselect data=sp4r.ameshousing2 plots=all seed=802;
   class &cat_vars;
   model saleprice = &cont_vars &cat_vars / selection=lasso(choose=validate stop=none);
   partition fraction(validate=0.5);
   store mymod;
run;

/*Part B*/
proc plm restore=mymod;
   score data=sp4r.newdata_ames_reg out=sp4r.pred_newdata 
      predicted;
run;

/*Part C*/
proc print data=sp4r.pred_newdata;
   var saleprice predicted;
run;

*
Demo: Stepwise Selection with PROC GLMSELECT
In this demonstration, we're going to use the LASSO effect selection 
process. First, in part A, I'm going to create two macro variables for 
continuous variables and categorical variables I'll use in my model.

Here we have lot_area through age_sold for continuous. And heating_qc, 
central_air, the number of fireplaces, which will be categorical, and 
lot_shape_2, which has two levels, regular and irregular lot shape. 
First, in PROC GLMSELECT, I'm going to set the PLOTS= option to ALL.

This is a great keyword to use if you want to bring back all possible 
graphics the procedure can generate. And I'll come back to the SEED 
option in just a minute. In my CLASS statement, I'll go ahead and throw
in that macro variable for the categorical variables. And in my MODEL 
statement, I'm going to set saleprice equal to both the continuous variables
and categorical variables. And here I'm not crossing any of them, so I'm 
just using the linear effects.

Now, as an option, I'm going to use the SELECTION=LASSO option, and in 
parentheses, I'm going to use the CHOOSE= option and specify VALIDATE,
so this is going to choose the best model according to a validation data 
set.

And I'll also use the STOP=NONE option to continue adding effects into 
the model even though the validation average squared error may be 
increasing, but it will still choose the model with the best average 
squared error according to a validation data set.

Now because I haven't specified a new validation data set, I need to use
the PARTITION statement and the FRACTION option and tell it, I want 50% 
of the data to be for validation, and of course, the remaining 50% for 
training.

And finally, I'm going to save my model with the STORE statement. I'll
call it mymod so I can then go ahead and score new data after I create 
the model. So this procedure, in general, it's going to add predictors 
into the model at each step according to the validation average squared 
error.

So it starts with the null model and then it adds in the predictor, 
which reduces the average squared error the most and continues this 
process until the average squared error is no longer reduced. And recall,
we're using the LASSO effect selection method, so we are applying a 
penalty to the likelihood and shrinking our parameter estimates during 
this process.

So let's run part A. So here we have some model information. I'm 
actually using a different ameshousing data set, ameshousing2, but I'm 
using the sale price of the dependent variable, LASSO. My choose criteria
is validation ASE. And I set a random seed of 802 in the PROC GLMSELECT
statement so it knows exactly what 50% of the data I choose each time.
This way I can duplicate my results.

In this new ameshousing data set, I actually have 1,361 observations
and I use 1,358. So three of them had missing information. So just using 
some more information than the subset 300 from the original ameshousing 
data set.

Here we have the class level information, which we've already talked
about. So here, fireplaces can have values 0, 1, 2, or 3. And we're 
considering 11 total effects, and effects after split, so splitting in
the classification levels. We have 20 possible effects.

And here is our Selection Summary according to LASSO. And here ASE 
stands for Training Average Squared Error. On the other hand, we have 
Validation Average Squared Error.

It starts with the intercept and then it adds in age_sold. So this
reduced the validation average squared error the most, from 134 down to
130. Then basement_area was added into the model, then gr_liv_area, and
so on, all the way until we get to our last effect, fireplaces_1. And 
you'll notice, the optimal value here is actually at step 13. That is 
when the validation average squared error is reduced the most. So I'd 
want this model to be all parameter estimates from steps 1 through step 
13. And one thing you'll notice, it actually adds in levels of 
classification variables separately.

So it doesn't need to add in the entire classification variable. Here 
it added in the level of fireplaces_0. And then finally, it added in 
fireplaces_3. And if you wanted, you could take additional steps before
you created your model to go ahead and standardize data. But here, I'm
just showing you the LASSO method.

And remember, I used the PLOTS=ALL option, a great option when you're
doing effect selection. The first plot is the coefficient progression
for saleprice. So how did the effects change over time? And this is the
standardized coefficient. We can see the progression of age_sold, the 
first parameter that was entered into the model.

And you can see this parameter for age_sold increases and then levels
off as more parameters are added into the model. And you can look at the
same thing for each parameter. But again, these are standardized coefficients.

We also have the validation average squared error. So how did it progress
as parameters were added into the model? Of course, it took a deep dive
as we added more parameters into the model until we got to the 13th step.
And then, on the 14th step, the ASE actually increased. So this solid,
black vertical line indicates the final step in the process.

We have some other model fit statistics that it records, the AIC, AICC,
and so on, just to look at how they progress, as well. So we can see 
here that, actually, all these model fit statistics have the best value
at step 13, just like our validation average squared error.

And we have the progression of average squared error for both training
and validation data sets. And I did sample from the entire data set to 
split this data, so here we see they are very similar, so the lines
pretty much overlap.

Finally, it specifies the given model intercept, lot_area, and so on.
This is the same model specified by the selection process before and 
then reruns the model. So we have our analysis of variance assuming the
model with these effects, additional model fit statistics, and finally,
our parameter estimates for this final model after the selection process.

So remember, this is the model that I saved with the STORE statement 
and then I could go ahead and score new data with. So let's do that.
Let's use PROC PLM and we'll use the RESTORE option to restore mymod.

And in the SCORE statement, I'm going to score the newdata_ames_reg 
data set. I'll save this in pred_newdata and I'll pull back just predicted
values. And finally, I'll print those predicted values along with 
saleprice. So the key thing to remember here is it's only using the 
effects entered into the model according to the selection process. 
Nothing else.

Here we have the PLM procedure information as well as the saleprice 
and predicted values. So it looks like it had a little bit of trouble 
on the higher home value prices, but we can go ahead and add in more 
predictors in our model cross terms and find a better predictive model 
if we wanted to.
*;
