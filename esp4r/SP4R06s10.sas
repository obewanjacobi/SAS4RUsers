/*SP4R06s10*/

/*Part A*/
proc sgplot data=sp4r.washer;
   vline store  / group=brand stat=mean response=sales;
run;

/*Part B*/

/*Part C*/
proc mixed data=sp4r.washer method=reml;
   class brand store;
   model sales=brand / ddfm=kr2;
   random store brand*store;
run;

/*Part D*/
proc mixed data=sp4r.washer method=reml;
   class brand store;
   model sales=brand / ddfm=kr2;
   random store brand*store;
   estimate 'brand A vs brand B' brand 1 -1;
run;

/*Part E*/
proc mixed data=sp4r.washer method=type3;
   class brand store;
   model sales = brand;
   random store brand*store;
   estimate 'brand A vs B' brand 1 -1;
run;

