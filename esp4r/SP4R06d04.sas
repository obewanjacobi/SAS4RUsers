/*SP4R06d04*/

proc sql;
   select mean(gr_liv_area) into :gr_mean from sp4r.ameshousing;
quit;

proc glm data=sp4r.ameshousing plots=diagnostics;
   class heating_qc (ref='Fa');
   model saleprice = heating_qc|gr_liv_area / solution clparm;
   lsmeans heating_qc / at gr_liv_area=&gr_mean pdiff adjust=tukey cl;
   estimate 'My Estimate' intercept 1 heating_qc 1 0 0 0 
      gr_liv_area &gr_mean heating_qc*gr_liv_area &gr_mean;
run;quit;


*
Demo: ANCOVA
In this demonstration, we'll do an analysis of covariance. And the first
thing I'm going to do is use SQL to create a new macro variable. And this
method I'm showing you is a little bit different than we saw in Chapter 5.

I'm going to select and I'll use the keyword MEAN, and in parentheses,
specify the variable, ground living area, meaning I want to select the
mean for gr_liv_area, and put that into-- with a keyword-- a new macro
variable called gr_mean. And again, I have to say from ameshousing data
set.

So this is a little bit different. Here, I'm using a keyword to specify 
a summary statistic. I could also use median, standard deviation, but 
there only a few keywords I can actually use. So the reason I showed you
the previous way in Chapter 5 was so you could query any data set and 
create any macro variable. But again, this is another option.

So let's run this and see what the mean for gr_liv_area is, and the mean 
is 1,130. And I'll use this value in my subsequent PROC step. So again,
I'm in PROC GLM working on the ameshousing data set. I have the same 
PLOTS= option.

In the CLASS statement, I only have one classification variable: this 
time just heating_qc with the same reference level. In the MODEL 
statement, I'm setting saleprice equal to heating_qc and crossing it 
with a continuous variable, gr_liv_area. So this is my analysis of variance
model. As an option, I'm going to use SOLUTION as before, and also CLPARM
to find confidence limits for my parameter estimates.

Next, in my least square means table, I'll specify heating_qc. And as an
option, I'm going to use the keyword AT and set the continuous variable
gr_liv_area equal to a specified value. In this case, it's gr_mean. So 
I'm using that macro variable I created in PROC SQL here in the (least 
square means) LSMEANS statement.

I also used the PDIFF option to request the p-values for differences in
effects. I'll do a multiple, simultaneous comparison with a Tukey 
adjustment, and also request confidence limits for my least square means
individually.

Next, in the ESTIMATE statement, I want to estimate the home price for
a home with excellent heating condition and the average ground living
area. So, in this case, I'm not taking a difference of effects. So I have
to use the keyword INTERCEPT and specify a coefficient of 1.

Previously, when I was taking differences, those values would just 
cancel out. Next, I'll specify my heating_qc first coefficient as 1,
the rest is 0. And for my next two variables, gr_liv_area and the 
interaction term, I'm specifying that macro variable &gr_mean. Again, 
that is a value of 1,130 square feet. Let's run this procedure.

Here are my levels, the number of observations I use, my ANOVA tables, 
overall significance. My R square is still low. My Type I and Type III 
sums of squares, my parameter estimates table, and remember, I added in
the CLPARM option to get confidence limits for each parameter, and here,
it appears the gr_liv_area is highly significant-- my same diagnostics 
panel.

And again, SAS knows I'm doing an analysis of covariance, so it gives me
the analysis of covariance plot. Here we see the slope adjustments for
each level in the heating_qc: excellent, good, average, and fair. And you
notice, they're all parallel with each other, meaning I probably don't
have a significant interaction.

And just to double-check with our estimates in the table above, we see the
interaction effect is not significant. But again, SAS knew it was an 
analysis of covariance and generated that graphic for us, which is extremely
convenient.

Here we have some least square means for heating_qc. And also I used the
PDIFF option to request the following table. Here are the p-values for 
the differences in those effects, so comparing excellent to good, which 
is 1 and 2, excellent to average, which is 1 and 3, and so on.

I also use the CL option to request the confidence limits for those least
square means. And remember, I use the Tukey adjustment to do simultaneous
comparisons. So here I'm comparing Level 1 and Level 2 using my Tukey 
adjustment, which is a difference of about $13,000, and so on.

And we get the same information and the least square means graphic. So 
here it says, "Fair is significantly different from excellent and excellent
is significantly different from good and average." The rest are not 
significantly different.

And finally, we're trying to estimate the sale price of a home with 
excellent heating condition and the average ground living area here in
Ames, Iowa. And that home price is estimated to be about $146,000.

It also gives you a p-value-- not the most helpful here because, of 
course, we're not comparing it to a value of 0. But we also get our 
confidence limits here at about $140,000 through $152,000.
*;