/*SP4R06d03*/

proc glm data=sp4r.ameshousing plots=diagnostics;
   class heating_qc (ref='Fa') central_air (ref='N');
   model saleprice = heating_qc|central_air / solution;
   *Alternative MODEL statement syntax;
   *model saleprice = heating_qc central_air heating_qc*central_air;
   lsmeans heating_qc|central_air;
   estimate 'Main Effect EX vs GD' heating_qc 1 -1 0 0 
      heating_qc*central_air .5 .5 -.5 -.5 0 0 0 0/ e;
run;quit;


*
Demo: Two-Way ANOVA
In this demonstration, I want to do a two-way analysis of variance, so 
I'm going to have two classification variables built into my model. 
Again, I'm going to be in PROC GLM using the ameshousing data set, 
and as an option, I'm going to use PLOTS= diagnostics simply telling 
SAS, bring back all the diagnostics plots.

And I strongly encourage you to check out the online doc for each 
modeling procedure that you use. Check the PLOTS= option to see what
plots you can generate.

First, in the CLASS statement, I'll specify two classification 
variables: heating_qc again, with the reference level equal to fair,
and also central_air, which has values Y and N for yes and no. Here 
I'll specify our reference level as N.

Next, in my MODEL statement, I'll set saleprice equal to heating_qc, 
and I'm going to cross all effects with central_air. So this is going
to add in the linear effects for the two variables and also the 
interaction. (An equivalent syntax is given here as a comment.) So you
could specify it as heating_qc, central_air, and then heating_qc 
crossed by central_air with a star operator.

And again, as a best practice, make sure to use the SOLUTION option in
the MODEL statement to print your parameter estimates. I'll also request
least square means for my model for all linear interaction effects. 
Again, I'm using the vertical pipe to simplify the notation.

And finally, I'm going to use the ESTIMATE statement to identify the 
main effect, excellent versus good, for the heating_qc. So here I have
named my estimate "Main Effect EX vs GD." I'm going to specify all the
coefficients where necessary.

First, I'll specify heating_qc, and I need coefficients 1 and minus 1,
as we saw previously. And we also need to specify coefficients for the
interaction effects: heating_qc by central_air. So we need to average
out the effect for central_air for the appropriate heating_qc.

So my coefficients are 1/2, 1/2, and minus 1/2, minus 1/2, And these
coefficients were determined by taking the expected value of the 
difference for the appropriate linear models. And be sure to check the
demo steps to identify where the coefficients came from. Let's run 
the demonstration.

First, we have the class level information. So we have four levels 
and two levels for our two variables. We're using all 300 observations
for the ameshousing data set. Our overall F test is significant so 
that's good. We have a very low R square though.

Here we can see the Type I and Type III sums of squares. Type I, of
course, is sequential, so how are the effects added into the model? 
And Type III are the sums of squares if they were added into the model
last. But I won't worry too much about these tables here.

Next, we get the parameter estimates table, because I used the 
SOLUTION option in the MODEL statement. And here you can see lots of
zeros because we did have an over-parameterized model. So it just 
zeroed out effects where necessary, just like you would see in R.

We also get the diagnostics panel according to the PLOTS= option. Again,
we could try and diagnose outliers where necessary. Again, one of my 
favorite things about SAS, it's always giving you relevant statistical 
graphics. So it knows we're doing a two-way analysis of variance, so 
it automatically goes ahead and gives you an interaction plot.

So here, we can see how saleprice changes as we move across the levels
of heating_qc and central_air. And here, the lines appear to be 
somewhat parallel. So we would assume there is no interaction effect.
And to double-check with our Type III sums of squares table, we can
see that the interaction, heating_qc by central_air, is not significant
here.

I used the least square means statements, so I get the least square
means tables. Here it's for heating_qc, the four levels, and this is
averaging over central_air. It also, by default, gives you the plot, 
which is the same information as the table.

Here, I have the least square means for central_air averaged over 
heating_qc. It looks like there's a huge gap in saleprice between homes
with central air and without-- about $50,000. Again, the same 
information in the graphic.

And finally, we get our simple effects mean. So here we have the 
saleprice mean for the levels: heating_qc equal to Excellent and 
central_air equal to Yes, which is about $156,000. And all the way at
the bottom, you can see when the levels are fair and no central air,
the home prices are lowest on average at about $80,000. Again, we get
the same information in the graphic.

And finally, remember, I used the ESTIMATE statement to estimate the
main effect. This table was generated using the E option just to make
sure I specified my coefficients correctly. So remember, I wanted a 
coefficient of 1 for excellent and minus 1 for good, so that's perfect.

And I also needed to average out the interaction effects where 
necessary. So here, when heating_qc is excellent, I want to average
that effect across central_air (yes and no). So that's what I did. 
And also, I want to subtract out the average for heating_qc where it's
good, and average out central_air.

And when I do so, I get the main effect estimate of about $11,000. 
Here, we have a large standard error and our p-value is not statistically
significant, so in this case, our main effects are not significantly
different.
*;