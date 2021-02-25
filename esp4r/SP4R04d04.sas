/*SP4R04d04*/

/*Part A*/
data sp4r.multi;
   call streaminit(123);
   do Sex='F', 'M';
      do j=1 to 1000;
         if sex='F' then height = rand('Normal',66,2);
         else height = rand('Normal',72,2);
         output;
      end;
   end;
run;

/*Part B*/
proc sgpanel data=sp4r.multi;
   panelby sex;
   histogram height;
   density height / type=normal;
   title 'Heights of Males and Females';
   colaxis label='Height';
run;
title;

/*Part C*/
ods layout Start rows=1 columns=3 row_height=(1in) column_gutter=0;

ods region row=1 column=1;
proc sgplot data=sp4r.multi (where= (sex='F'));
   histogram height / binwidth=.5;
   title 'Histogram of Female Heights';
run;
title;

ods region row=1 column=2;
proc sgplot data=sp4r.multi (where= (sex='F'));
   density height / type=kernel;
   title 'Density Estimate of Female Heights';
run;
title;

ods region row=1 column=3;
proc sgplot data=sp4r.multi (where= (sex='F'));
   hbox height;
   title 'Boxplot of Female Hieghts';
run;
title;

ods layout end;

*
In this demonstration, we'll use the SGPANEL procedure and the ODS LAYOUT 
statement separately. First, I'm going to create a data set called multi.
I'll set a seed, and this time in my DO loop, I'm going to specify the 
classification variable Sex and give it a character list, So the values 
it can take are F for female and M for male, and I'm separating them with 
a comma, and for each level of Sex, I'm going to simulate 1,000 observations.

And now I'm going to create values conditionally based on the Sex variable.
So if Sex is equal to F, then my new variable, height, will be normally 
distributed with a mean of 66 and a standard deviation of 2. Otherwise,
using my ELSE statement, I'll set height equal to the RAND function, which 
is normally distributed with a mean of 72 and a standard deviation of 2. 
Again, remember your OUTPUT and END statements.

I'll use PROC SGPANEL to create a panel of plots for the Sex variable. So
I'll use the PANELBY statement and pass it that classification variable.
And next, I'll specify the HISTOGRAM statement to create a histogram of 
the height variable. I'll also overlay a density estimate with my DENSITY 
statement, and I'll use the TYPE=NORMAL option. I'll also add in a title,
which is Heights of Males and Females. I'm going to change the Y axis 
label with the COLAXIS statement, and the LABEL= option. Sspecify it as 
'Height', and again, remember to turn off your title after you use it.

So here I've plotted histograms for the separate levels of the 
classification variable Sex. So my first plot is the histogram for the 
variable Sex equal to female, and the second plot is the variable Sex 
equal to male. And of course, you'll notice that female mean is about 66, 
and male height mean is about 72, exactly the way we simulated it. Next,
I'm going to reproduce the PAR(MFROW) function in R. So I want to initialize
a new window, and then fill that window with different types of plots. So 
I'll use the ODS LAYOUT START statement, and I want my plots in one row
and three columns. So I'll be generating three separate plots. And I'm 
going to have my row heights be equal to 1 inch. You can also use cm for 
centimeters.

I'll use the ODS REGION statement and specify the next plot will be 
printed in the row one, column one position. And in SGPLOT, I'm going 
to create a histogram of heights, and as an option, I'll specify the 
binwidth as 0.5. And my title will be Histogram of Female Heights. And to
do this, I'll use the WHERE option in the PROC SGPLOT statement. So I'll 
say WHERE= and then provide it an expression, so where my Sex variable is 
equal to F. So it's the exact same syntax as we've seen before with the
WHERE statement, I've just placed it as a WHERE option in the PROC SGPLOT
statement.

Next, in row one, column two, I'll create a density estimate of the
heights for, again, only the female observations. And I'll use a kernel 
density estimate with the TYPE= option. And finally, my last plot in row
one, column three, again, I'll only use female observations from my data
set. And I'll create a horizontal box plot of the heights and provide it 
an appropriate title. And remember to turn off ODS LAYOUT with the ODS 
LAYOUT END statement. Again, this is like setting the PAR(MFROW) back to
its default in R.

So here we've created a window and filled it with three separate plots. 
I have my histogram of female heights, my density estimate of female 
heights, and, of course, my box plot as well. You can change the size 
of the plots with the ROW_HEIGHT and COLUMN_HEIGHT options in the ODS 
LAYOUT START statement, and you can create whatever window you would like
and fill it with whatever plots you want as well.
*;