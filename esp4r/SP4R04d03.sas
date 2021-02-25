/*SP4R04d03*/

/*Part A*/
data sp4r.sales;
   call streaminit(123);
   do month=1 to 12;
      revenue = rand('Normal',10000,1000);
      revenue_2 = rand('Normal',13000,500);
      output;
   end;
run;

/*Part B*/
proc sgplot data=sp4r.sales;
   series x=month y=revenue / legendlabel='Company A'
      lineattrs=(color=blue pattern=dash);
   series x=month y=revenue_2 / legendlabel='Company B'
      lineattrs=(color=red pattern=dash);

   title 'Monthly Sales of Company A and B for 2015';
   xaxis label="Month" values=(1 to 12 by 1);
   yaxis label="Revenue for 2015";
   inset "Jordan Bakerman" / position=bottomright;
   refline 6.5 / transparency= 0.5 axis=x;
   refline 11000 / transparency= 0.5;
run;
title;

/*Part C*/
proc sgplot data=sp4r.sales;
   series x=month y=revenue / legendlabel='Company A' name='Company A'
      lineattrs=(color=blue pattern=dash);
   scatter x=month y=revenue / markerattrs=(color=blue
      symbol=circlefilled);
   series x=month y=revenue_2 / legendlabel='Company B' 
      name='Company B' lineattrs=(color=red pattern=dash);
   scatter x=month y=revenue_2 / markerattrs=(color=red 
      symbol=circlefilled);

   title 'Monthly Sales of Company A and B for 2015';
   xaxis label="Month" values=(1 to 12 by 1);
   yaxis label="Revenue for 2015" min=8000 max=14000;
   inset "Jordan Bakerman" / position=bottomright;
   refline 11000 / transparency= 0.5;
   refline 6.5 / transparency= 0.5 axis=x;
   keylegend 'Company A' 'Company B';
run;
title;

*
In this demonstration, I'll show you how to enhance the plot with lots 
of different statements and options right in the SGPLOT procedure. First, 
I'm going to create a data set called sales. Again, I'll set my seed. And 
then I'm going to go from month equals 1 to 12, and create two different 
variables.

First revenue, which is normally distributed with a mean of 10,000 and a 
standard deviation of 1,000. And then revenue_2, which is again, normally 
distributed with a mean of 13,000 and a standard deviation of 500. So here 
I'm specifying two different revenues for perhaps two different companies. 
And let's run this data so I have access to use it.

In Part B I'm going to use the SGPLOT procedure to create a series plot 
so I'll use two different SERIES statements for the different revenues 
in my sales data set. x is going to be equal to month, y is going to be 
equal to revenue, and as an option I'm going to specify my legendlabel as 
Company A and because I'm using the SERIES statement I can use the LINE 
ATTRIBUTES option. I'll set that equal to, in parentheses. I'll specify 
color equal to blue. And I'll change the pattern and set it equal to dash.

I'll do the same thing in the next SERIES statement. Here I have revenue_2. 
I'm going to set the legendlabel to Company B, and I'll change the line 
attributes. Color will be red, and pattern will be dash. And there's lots 
and lots of different attributes you can play around with in SAS. Again, 
definitely check the doc page for different colors, patterns, and other 
options you might want to use.

To add a title to our plot we'll just use the TITLE statement. So here 
I'm calling it "Monthly Sales of Company A and B for 2015". And whenever 
you use the TITLE statement immediately following your procedure, run the 
TITLE statement by itself as is. This will turn off the title. Otherwise 
that title will persist through all the other plots you generate subsequently.

Next I'm going to use the XASIS statement. I'll use the LABEL option to 
give it a label of "Month". And the values let me change the tick marks. 
And I provide syntax very similar to my DO loop. So I'll go from 1 to 12 
with an increment of 1.

I'll change the yaxis label to "Revenue for 2015". And I'm going to use 
the INSET statement to put my name on the plot and as an option I'll give 
it the position of the bottom right corner of the plot. The refline is 
very similar to the abline function in R.

Here I'm giving a reference line of 6.5, and as an option I'm going to 
specify the xaxis, otherwise it would default to the yaxis. And transparency 
can be between 0 and 1. Zero meaning you cannot see it and one is dark black. 
So 0.5 is a mid-grey. And I'll give it a second reference line of 11,000 to
be my horizontal reference line. And again, the same transparency of 0.5.

So here is a much nicer looking plot than we've shown in the previous 
demonstration. So now I have a nice title, my name, my legendlabel is 
"Company A" and "Company B". I have a different pattern for the lines. 
I've changed the color, nice labels, reference line, so I can see how 
the company revenues are split up, 6.5 about halfway through the year, 
and so on.

Now what if I want to go ahead and add in the points to those plots? So 
for example, I want to add the points on to the existing series lines. 
Well, I'm just going to add in multiple SCATTER statements. So my first 
SCATTER statement, I'll set x equal to month, I'll set y equal to revenue, 
and now because I'm using the SCATTER statement I need to use the MARKER 
ATTRIBUTES option, not the LINE ATTRIBUTES option.

And here I'm changing the color to blue, and the symbols will be circle 
filled. And similarly for the next SCATTER statement I'm changing the 
marker attributes with a color of red and a symbol of circle filled. And 
I've done one other thing in the SERIES statements. You'll notice I've 
added in the NAME option in both SERIES statements. So name equal to 
"Company A" and and name equal to "Company B" in the second one. This lets 
me control the legend. So if I don't want legend labels for all PLOTTING 
statements in SGPLOT procedure, I'll use the NAME option. So instead of 
having four legends this will let me have only two.

And then on the bottom in the KEYLEGEND statement I'll specify the same 
legend names-- "Company A" and "Company B". And those will correspond to 
the SERIES statements that I've used the NAME option in. I've used the same 
TITLE statement, the same xaxis label,

I've added on minimum and maximum values to the yaxis label just to 
control exactly how it plots. And the inset and REFINE statements are 
identical. But again, to keep SAS from plotting a legend label for all 
four SERIES and SCATTER statements, I use the KEYLEGEND statement. So now 
I have added circle filled points onto the lines and I only have "Company 
A" and "Company B" in my legend.
*;