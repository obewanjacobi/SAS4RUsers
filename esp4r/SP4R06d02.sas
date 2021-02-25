/*SP4R06d02*/

/*Part A*/
proc print data=sp4r.paper;
run;

/*Part B*/
proc sgplot data=sp4r.paper;
   reg  x=amount y=strength / legendlabel="Linear";
   reg  x=amount y=strength / degree=2 legendlabel="Quadratic";
   reg  x=amount y=strength / degree=3 legendlabel="Cubic";
   title 'Polynomial Plot';
run;
title;

/*Part C*/
data sp4r.paper;
   set sp4r.paper;
   amount_sq = amount*amount;
   amount_cub = amount*amount*amount;
run;

proc reg data=sp4r.paper;
   model strength = amount amount_sq amount_cub;
run;quit;

*
Demo: Polynomial Regression
In this next demonstration, I want to do a polynomial regression in 
PROC REG. Here we have a new data set we're going to be working with,
the paper data set, and I'll go ahead and print it so we can view it.

So a researcher is interested in studying the effect of a chemical 
additive on paper strength. The independent variable of interest is the
amount of chemical additive, and the dependent variable is the amount 
of force required to break the paper, the strength.

So I want to do a polynomial regression, because amount is ordinal: 1 is
weaker than 2, 2 is weaker than 3, and 5 is the strongest amount.

Before I go ahead and use PROC REG, I want to view the linear quadratic
and cubic effects in SGPLOT, and to do so, I'll use the REG statement.
I'll specify the amount as the X axis variable and strength as the Y 
axis variable. And as an option, in my first REG statement, I'm going 
to give the LEGENDLABEL linear, and in the next two REG statements, I'm
going to overlay quadratic and cubic effects.

So here, I'm specifying degree equal to 2 and degree equal to 3, and 
I'll give it a title Polynomial Plot, so let's see how this data fits 
best.

So here in blue, we have the linear term. Does not appear to fit very 
well. In red, we have the quadratic term, which certainly fits a little
bit better, and finally, in green, we have the cubic term, which 
appears to go right through the center of each distribution for amounts
1 through 5. So I would assume, just on this plot, it's probably a 
cubic model, but let's use PROC REG to make sure.

The first thing I'm going to do is add in the quadratic and cubic effects
into my paper data set. So here, I have amount squared and amount cubed.
Then, I can go ahead and use those effects in PROC REG in the MODEL 
statement.

So again, in PROC REG, in my MODEL statement, I have my dependent 
variable strength. Set it equal to amount, amount squared, and amount
cubed, and we'll run Part C.

And again, we have an overall significant F test with an R-square value 
of 0.73. You'll notice my parameter estimates are not significant for 
the linear and quadratic effect at the 0.05 level.

But the cubic effect is significant, and here, if we were to enforce 
hierarchy, meaning we want lower-order terms in the model before 
higher-order terms can be entered in the model, you'd probably assume 
this is a cubic model.

Here we have the diagnostics panel. You can use this, again, to diagnose 
outliers, and of course, the Residual by Regressors for Strength.
*;


