/*SP4R02d01*/

/*Part A*/
data sp4r.example_data;
   length First_Name $ 25 Last_Name $ 25;
   input First_Name $ Last_Name $ age height;
   datalines;
   Jordan Bakerman 27 68
   Bruce Wayne 35 70
   Walter White 51 70
   Henry Hill 65 66
   JeanClaude VanDamme 55 69
;
run;

/*Part B*/
data sp4r.example_data2;
   length First_Name $ 25 Last_Name $ 25;
   input First_Name $ Last_Name $ age height @@;
   datalines;
   Jordan Bakerman 27 68 Bruce Wayne 35 70 Walter White 51 70
   Henry Hill 65 66 JeanClaude VanDamme 55 69
   ;
run;


*
So here I'm creating a data set called EXAMPLE_DATA. I'm saving it in 
the SP4R library. So it will be saved permanently.

In the input statement I have four variables. First name, which is 
character valued. So I have a dollar sign. Last name is also character 
valued. So I have another dollar sign. And two numeric valued variables, 
age and height. Then I'll specify the data lines and go ahead and type 
in all my data.

So here I have my name, Jordan Bakerman, 27 years old, 68 inches tall, 
and a few of my friends, as well. Remember your semicolon and your RUN 
statement to finish up your DATA step.

Now you'll notice here the last observation has more than eight bytes. 
Jean-Claude is actually 10 characters. So I need to use a LENGTH statement 
to change the number of bytes for the variable. So in the LENGTH statement 
I'll specify first name and last name, and I'll just say, hey, let them be 
up to 25 characters.

So again, I don't need to know the value with the maximum number of 
characters, I'm just specifying upper bounds here.

And we'll run part a.

And in SAS Studio it automatically opens up a new output data set. So here 
we can see that we read it in correctly. So we have a five by four data 
set. Again that's saved in the SP4R library, which is permanent. So that's 
saved to, in this example, S Workshop.

Part B, we're creating another data set. I'll call it EXAMPLE_DATA2. 
And the only difference here is you'll notice I've read in more than one 
observation per line.

So here I have Jordan Bakerman, 27 68, and then immediately following 
it I have the second and third observations.

So to read in this data we need to use what's called a trailing @@ symbol 
in the INPUT statement. That tells SAS to hold the line and continue 
reading in data as new observations. If I didn't use the double trailing 
@@ symbol I would only have two observations in this data set, 
Jordan Bakerman and Henry Hill.

So let's read this in just to make sure it's exactly the same from 
part A. And of course, it is. It's the five by four data table from before.
*;