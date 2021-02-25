/*SP4R06d07*/

/*Part A*/
proc logistic data=sp4r.ameshousing plots(only)=(effect oddsratio roc);
   class fireplaces(ref='0') lot_shape_2(ref='Regular') / param=ref;
   model bonus(event='1') = basement_area fireplaces lot_shape_2 
      / clodds=wald;
   units basement_area = 100;
   estimate 'my estimate' intercept 1 basement_area 1000 
      fireplaces 1 0 lot_shape_2 1 / e alpha=.05 ilink;
   output out=sp4r.out p=pred;
   store mymod;
run; 

proc print data=sp4r.out (obs=5);
   var bonus basement_area fireplaces lot_shape_2 pred;
run;

/*Part B*/
proc plm restore=mymod;
   score data=sp4r.newdata_ames_logistic out=sp4r.pred_newdata 
      predicted lclm uclm /ilink;
run;

/*Part C*/
proc print data=sp4r.pred_newdata;
   var bonus basement_area fireplaces lot_shape_2 predicted lclm uclm;
run;


*
Demo: Logistic Regression
In this demonstration, let's practice logistic regression. Of course,
I'll do this in the LOGISTIC procedure. Again, I'm going to be working
with the ameshousing data set. And here's another option for the 
PLOTS= option. In parentheses, I can specify ONLY and set that equal 
to a list. I'll say I only want the plots' effect, odds ratio, and ROC.
Again, definitely check out the PLOTS= option for each procedure you're
working with.

In the CLASS statement, I'm going to specify two variables, fireplaces,
with a reference level of 0, and lot_shape_2, with a reference level 
of regular. And remember, the only other level is irregular. In my 
MODEL statement, again, I'll be predicting the probability of a 
bonus-eligible home. I'll set the event equal to 1 just to make sure I
know which level I'm predicting, and I'll set that equal to 
basement_area and my two classification variables, fireplaces and 
lot_shape_2.

And as an option, I want to bring back confidence limits for those odds
using the Wald statistic. I'll also use the UNIT statement to change 
the odds ratio comparison for basement_area equal to 100. And next in
the ESTIMATE statement, I want to predict the probability of a 
bonus-eligible home that has a basement area of 1,000 square feet, one 
fireplace, and an irregular lot shape. So I'm specifying my intercept, 
basement area, fireplaces, and lot shape coefficients, respectively.

Remember your E option to make sure you've specified them correctly, and 
you can also change alpha if you like. But of course, when you're just 
estimating a single home price and you're not taking the difference of
effects, you don't really need to. And most importantly, I'm using the 
ILINK option, so this predicts data on the original data scale. So when
I use the ESTIMATE statement, it's going to predict on the logit scale, 
but I want to predict on the probability scale, so I can have a more
meaningful estimate, so I use the ILINK option.

Next, I'll use the OUTPUT statement, save a new SAS data set called 
out, and I'm only saving the predicted values, and I'll show you why 
shortly. And finally, I'll save this model with a STORE statement. 
Let's run this LOGISTIC procedure.

So here are my model information. I'm using Fisher's scoring optimization 
technique. You'll notice I only have 299 observations used, so one of
these values has missing information. I have 44 bonus-eligible homes 
and 255 non-bonus-eligible homes. Remember, the probability model is 
bonus equal to 1. I use the EVENT option to do that. My class level 
information. Make sure in any optimization procedure, your model 
convergence status is satisfied. Here it is, so we can use the model.

I have my model fit statistics, AIC, SC, and log likelihood. I can also
test the global null hypothesis, similar to an overall F value from the 
previous tables. Here we have likelihood ratio score in Wald. So are 
there any parameters that are significantly different from 0? Of course, 
this says there are. Type 3 analysis of effect. So if I want to 
estimate the significance of classification levels jointly, for example,
there are two levels for fireplaces. If I want to test those jointly,
I can use the Type 3 analysis of effects. And here it's not significant 
at the 0.05 level, but basement_area and lot_shape_2 are.

Then I get my parameter estimates table. Again, basement_area and 
lot_shape_2 are significant. The level for fireplace is 1. It is almost
significant at 0.05 level, and fireplaces 2 is not significant. Here 
we have the association of predicted probabilities table, which we've 
talked a little bit about. We see we have a 93% concordant, 7% discordant 
out of 11,220 possible pairs. So this is a good model fit in this case.

My odds ratios for each variable. Again, basement_area was changed
to units of 100, so my estimate in this case is 2.1, similar to before.
Comparing fireplaces 1 to 0 is an odds ratio estimate of 2.4, so
more than two times the odds for a bonus-eligible home with a fireplace.
And we actually have a value less than 1 when we're comparing fireplaces 
2 versus 0. And finally, comparing the irregular versus regular lot 
shape, odds ratio is 6.7, so a very large odds ratio.

So it appears that the probability of being bonus eligible is much 
higher for homes with an irregular lot shape. And we have the same exact
information in the graphic, but here you're looking to see if the 
value covers this vertical black line of a value of 1. If it does, 
then we'd say it's not significant. So here, basement_area, fireplaces 
1 versus 0, and the lot_shape_2 odds ratios are significant.

I also requested the receiver operator curve to identify additional
model fit output. Of course, if the area under this blue line was one, 
we'd have a perfect model fit, probably overfitted, actually. But here
we have a very similar value to the percent concordant at 0.93. And here
is my estimate coefficients using the E option and the ESTIMATE 
statement to make sure I specified my coefficients correctly. Here I 
have 1, 1000, 1, and 1, so, yes.

You'll notice I have my ESTIMATE statement. It first predicts on the 
logit scale. It also gives me standard errors, p-values, and confidence 
limits. And then because I used the ILINK option, it then predicts on
the original data scale. So my mean here is the prediction for a 
bonus-eligible home with a basement area of 1,000, one fireplace, and 
a regular lot shape. The probability of being bonus eligible, according 
to this model, is 0.2966, so a much more meaningful prediction than the
logit, and it also gives you standard errors and confidence limits here.

Again, SAS gives us relevant statistical graphics like the following 
plot, my predicted probabilities for bonus 1. So here we can see how 
the probability changes as the basement area increases from 0 to the 
maximum value for each of the cross levels for fireplaces and lot_shape_2. 
So here, you can see in green, we have one fireplace, an irregular lot 
shape level, and the predicted probabilities are the largest as basement 
area increases.
*;