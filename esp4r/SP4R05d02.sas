/*SP4R05d02*/

/*Part A*/
ods trace on;
proc univariate data=sp4r.ameshousing;
   var saleprice;
   qqplot saleprice / normal(mu=est sigma=est);
run;
ods trace off;

/*Part B*/
ods select basicmeasures qqplot;
proc univariate data=sp4r.ameshousing;
   var saleprice;
   qqplot saleprice / normal(mu=est sigma=est);
run;
