/*SP4R02d03*/

data employees;
   input name $ bday :mmddyy8. @@;
   datalines;
   Jill 01011960 Jack 05111988 Joe 08221975
   ;
run;

proc print data=employees;
run;

data employees;
   input name $ bday :mmddyy8. @@;
   format bday mmddyy10.;
   label name="First Name" bday="Birthday";
   datalines;
   Jill 01011960 Jack 05111988 Joe 08221975
   ;
run;

proc print data=employees label;
run;

*
So at this point, you might be asking yourself, do I really need to 
know the number of days since January 1st 1960 to actually work with 
SAS date formats? Well, the answer, of course, is no. That would be 
way too much of a pain. We use, what are called, informats, meaning 
your data is already in the appropriate format.

So here I'm creating a data set called EMPLOYEES. And I only have two 
variables, name, which is character, and birthday. And you'll notice 
here I'm applying an informat. So I'm using the colon to tell SAS that 
data I'm reading in is already in the specified format. It's already 
in mmddyy8. format.

And if you go down to the DATALINES, you'll see I have my name, in 
this case Jill, and then a date, in this case 01011960, and Jack, 
05111988. So that way I don't have to actually calculate the number 
of days.

And of course, I'm reading in more than one observation per line. So 
remember you're trailing @@ symbol. And I'm going to read in this data 
set and immediately print it with the PRINT procedure.

What you'll notice is it actually converts it to a SAS date value. So 
that's actually the number of days since January 1st 1960. 0, 10,358, 5,712.

So to actually keep the display of labels and formats I'm going to 
use the LABEL and FORMAT statements in my DATA step when I read in 
the data.

So I have the exact same DATA step as above. The only difference is 
now I have LABEL and FORMAT statements. I'm reading in the birth date 
variable with the mmddyy8. format again, and I'm immediately applying 
a different format, the mmddyy10. format. So I read it in with the 
width of 8, and now I want it displayed with a width of 10. And I also 
want to change the display of my column headings with the LABEL 
statement. So I'll change name to First Name and b-day to Birthday.

Most SAS procedures apply the stored labels and formats automatically, 
but PROC PRINT is a little different. It applies the formats 
automatically, but it will only apply labels if you specify the LABEL 
option on the PROC PRINT statement.

Now, if I read in this data and print it we'll notice the appropriate 
displays of labels and formats.

Here I have the labels and I also have the SAS date formats, and I 
didn't have to use the FORMAT statement in the PRINT procedure. They're 
automatically applied when I use them in my DATA step.
*;