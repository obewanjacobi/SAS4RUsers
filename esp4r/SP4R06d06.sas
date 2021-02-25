/*SP4R06d06*/

/*Part A*/
proc glmselect data=sp4r.paper outdesign=sp4r.des;
   effect amount_pol = polynomial(amount / degree=5);
   model strength = amount_pol / selection=forward select=sl sle=.05 
      hierarchy=single;
run;quit;

/*Part B*/
proc print data=sp4r.des;
run;

proc reg data=sp4r.des;
   model strength = &_glsmod;
run;quit;



*
Demo: Polynomial Regression with the GLMSELECT Procedure
In this demonstration, I want to analyze the paper data set again using 
polynomial regression, except this time in PROC GLMSELECT. So first, 
I'll run PROC GLMSELECT on the paper data set and I'll use the OUTDESIGN 
option to save a new SAS data set, des.

I'll use the EFFECT statement to help me create regressors. I'm going to
call this set of regressors amount_pol for polynomial. Here I'll set it
equal to the keyword, polynomial. Again, you could also use splines. 
I'll give it the variable amount, which is in my paper data set, and 
I'll say create variables up to degree equal to 5. So amount_pol is going
to represent amount all the way through the amount to the fifth power.

Next, in my MODEL statement, I'll set strength equal to amount_pol 
(the set of variables I just created in my EFFECT statement), and this
time, I'm going to use a selection process.

I'll say, after the forward slash selection equal to forward, I'll 
specify the SELECT= option as sl for significance level, and I'll 
specify sle, significance level for entry, at 0.5.

So, in order for a parameter to enter into the model, it has to have 
a p-value of less than 0.05. Otherwise, it cannot come into my model. 
And finally, I'll specify hierarchy equal to single. So I want to 
enforce hierarchy, meaning if a higher-order term is in the model, all 
its lower-order terms need to be in the model.

For example, if the cubic term is in the model, both linear and quadratic
terms have to be in the model as well. So this forward selection 
process is going to start with a linear term, then add in the quadratic 
term, then the cubic, and so on. And you'll remember from before, I 
only fit up to a cubic model. This time, I'm fitting up to a degree 
equal to 5 model and doing a forward selection. So let's run part A.

So first, we have the forward selection summary. So it starts with the 
null model of the intercept as in the linear term, the quadratic term,
and finally the cubic term. And it stops here. You'll notice it tried 
to add in the amount to the fourth power term, but that p-value was 
certainly greater than 0.05 so the model selection process stopped. And
then it reruns the model with the appropriate terms (amount, amount 
squared, and amount cubed).

Here we have the analysis of variance table, model fit statistics, and
also the parameter estimates for this final model. And remember from
before, we chose to fit a cubic model based on our graphic that we 
created. And here, in the forward selection process, it did the same 
thing. We tried to fit a model up to degree 5 and the selection process
chose a cubic model.

Next, I'm just going to go ahead and print the output data set from the
OUTDESIGN option. And what you'll notice is, it's a new SAS data set 
with the variables that were significant in my selection process 
(amount, amount squared, and amount cubed). So it left out the two 
terms that were not significant: amount to the fourth power and amount
to the fifth power.

I can now use this SAS data set in a different procedure. So I'll run
PROC REG with that des data set. And in my MODEL statement, I'm going
to set strength equal to my macro variable. And again, this macro 
variable, _glsmod, is only going to be for the significant effects 
(the linear, quadratic, and cubic terms).

So if we run this model, we'll get the exact same output that we saw
previously in this chapter. So here we have our parameter estimates
for the cubic model. And remember, I read it in the PROC REG, so it 
gave me additional graphical output-- one of the reasons I like to jump
around from procedures.
*;