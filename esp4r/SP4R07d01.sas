/*SP4R07d01*/

/*Part A*/
proc iml;
   items       ={'Groceries','Utilities','Rent','Car Expenses',
                   'Fun Money','Personal Expenses'};
   weeks       ={'Week 1','Week 2','Week 3','Week 4'};
   amounts     ={ 96  78  82  93,
                    61  77  62  68,
                    300 300 300 300,
                    25  27  98  18,
                    55  34  16  53,
                    110 85  96  118};
   weeklyIncome={900 850 1050 950};
   print items amounts weeklyIncome;
   print items, amounts, weeklyIncome;

/*Part B*/
   reset noname;
   weeklyTotals=amounts[+,];
   print "Total Expenses for Each Week", weeklyTotals [colname=weeks format=dollar8.2];

/*Part C*/
   itemTotals=amounts[,+];
   print "Total Expenses for Each Item", itemTotals[rowname=items format=dollar8.2];

/*Part D*/
   weeklyPercentage=amounts/weeklyIncome;
   print "Percentage of income spent on each item, by week",
     weeklyPercentage[rowname=items colname=weeks format=percent7.2];

/*Part E*/
   monthlyIncome  =weeklyIncome[+];
   itemProportion =itemTotals/monthlyIncome;
   print "Each Item as a Percentage of Monthly Income",
     itemProportion[rowname=items format=percent7.2];
quit;


*
Demo: Working in Interactive Mode in SAS Studio
In this demonstration, I want to show you how to work in interactive
mode for PROC IML and SAS Studio. To enter into interactive mode, I'm 
going to select the arrow going into the box button, here-- Go 
Interactive, and you'll have to select this each time you open a new tab.

Note: When you use interactive mode, it’s like creating a new session. 
You’ll need to redefine the sp4r library to access it in this session.

Now, to get into IML, I'm just going to run the PROC IML statement 
to turn on IML. Now, all my syntax will be in the matrix language. 
Let's assume I'm holding the grades for my students in a vector. So 
I'll create a new variable called grades, and I'll set that equal to 
the column vector (95, 91, 73, 88, and 96), and this is a statement,
so I do need a semicolon.

Now, to make sure I've created it correctly, let's go and use our 
PRINT statement with the variable grades. And I'm going to only run 
these two statements because I'm already in IML in interactive mode, 
so I can run IML syntax interactively, and here is my five by one 
grade's vector.

Now, I'm still in IML. Let's go ahead and use a subscript reduction 
operator to find the mean of this vector. I'll call the variable My 
Mean. I'll set that equal to grades, and I'll use the colon subscript 
reduction operator to find the mean of the matrix, and then again, I'll 
print the new variable, so I can see it.

Again, because I'm in interactive mode, I'll just run these two lines.
So here, my mean is 88.6, and you'll notice, when I'm in interactive 
mode, it saves all the results from the previous runs. Finally, to get 
out of interactive mode, I'm simply going to run the QUIT statement. Now,
I can run whatever SAS syntax I want in subsequent code.


Demo: Basic Matrix Operations by Example
Now that we know how to get into IML and work in interactive mode, let's
practice a longer demonstration with some more syntax. So again, because
this is a new tab, and I want to go into interactive mode for IML, I have 
to click the button again, Go Interactive. Here, in part A, I'm going to
define some vectors and matrices. So I'll go into IML, and then my first 
vector is called Items, and that's going to be the items I spend my money
on in a month: groceries, utilities, rent, car expenses, fun, and
personal expenses.

My second vector, Weeks, will be Week 1 through Week 4, and Amounts will
be a matrix representing the amount of money I spend in a month, so the
columns will be the weeks, and the rows will be the items. And finally, 
weeklyIncome will be a vector specifying how much I made that week, 900 
through 950.

And there are two options to print a set of matrices at once. The first
one, in the PRINT statement, I'll just list the vectors and matrices
(Items, Amounts, and weeklyIncome), and that'll go ahead and try and 
print those on the same line. It will actually look like it's a single 
matrix, but of course, they are different because I define them that
way. Now, if I use commas between the matrices (for example, Items comma
Amounts comma weeklyIncome), it's going to skip a line before printing 
the matrix.

So let's just run part A first. So when I don't use the comma, it joins
Items and Amounts together when it's printed, and also weeklyIncome 
skips a line because it's not the same size. Next, if I use commas between
my matrices, it skips a line, so I have the Items vector, the Amounts
matrix, and the weeklyIncome vector on separate lines.

In part B, I'm going to start with the RESET statement and tell SAS not
to print any default names. Next, I'm going to create the weeklyTotals 
matrix by using a subscript reduction operator on Amounts, so I'm going 
to sum up all the columns, so this will give me a 1-by-4 vector.

Next, I'm going to use the PRINT statement and give it a title, Total 
Expenses For Each Week, followed by a comma to skip a line. Then I'll 
print my new matrix, weeklyTotals, and in braces, I'll give it a few 
extra options. Here, I'll use the COLNAME option to specify that the 
column names are going to be the week's vector, and remember, that's 
just Week 1 through Week 4. I'll also use the FORMAT option and supply
it whatever format that we've already learned about in Chapter 2. Here,
I'm applying the DOLLAR format with a width of eight and a maximum of
two decimal places.

Let's run part B. So, for example, in Week 1, I spent $647, which is the
sum of column one for the Amounts matrix. In Week 2, I spent $601, and so
on. And again, I applied the format, so now I have the dollar signs.

Next, in part C, I'm going to create the itemTotals vector, and this 
time, I'm going to sum the rows of amounts using another subscript
reduction operator. Notice here. I've applied the plus symbol to the 
COLUMNS argument, so in this case, I'm summing up the rows. In the PRINT
statement, I give it another title, Total Expenses for Each Item, 
followed by a comma to skip a line, print the matrix item totals, and 
now I'm using the ROWNAME option and specifying Items. Remember, those
items are groceries, utilities, and so on, and I'll use the same DOLLAR8.
format. So here, I have my title, Total Expenses for Each Item, and I 
spent $349 on groceries that month, $268 on utilities, and so on.

In part D, I'm going to use an implicit loop, so I'm creating the
weeklyPercentage matrix, which is going to be equal to the matrix.
And I'm applying the division operator to each row, so Amounts is a
6-by-4 matrix, and weeklyIncome is a 1-by-4 row vector, so I'm applying
that operation to each row in my Amounts matrix. Then I'll print it, 
again with another title, Percentage of income spent on each item, by 
week. I'll print my new matrix, weeklyPercentage.

Now, I have ROWNAME and COLNAME options, as well as a different format. 
Here, I'm using PERCENT7.2. For example, in Week 1, I spent 10% of my
income on groceries, and Week 4, I spent 12.4% on personal expenses.

In part E, I'm going to find my monthly income, so I'm going to sum up
all elements of that row vector, weeklyIncome, and if there are no 
commas, meaning I only have one argument inside of my braces, it's just
going to apply that operation to every element in your matrix. Next,
I'll find the itemProportion matrix, which is itemTotals divided by my 
scalar, monthlyIncome.

I'm going to print, with a title, my itemProportion, followed by a row
name of items, and the format PERCENT7.2 again, and then I'll run the 
QUIT statement to leave PROC IML. So here is Each Item as a Percentage
of Monthly Income. So I spent 9% of my monthly income on groceries, and
only 4.21% on fun.
*;