putdocx begin, header(head)
putdocx paragraph, toheader(head) font(,12)
putdocx text ("Zayd Abdalla")
putdocx pagenumber
putdocx paragraph, style(Heading1)
putdocx text ("Github Repository and Summary")
putdocx paragraph
putdocx text ("1. https://github.com/zaabdall/RDD")
putdocx paragraph
putdocx text ("2. The research question: What is the effect of harsher punishments and sanctions on curbing driving under the influence?. Hansen had reviewed administrative records on 512964 DUI BAC tests from Washington courts from 1995 to 2011. He focused specifically on data between 1999 to 2007 since January 1st, 1999 marked Washington's decision to define a threshold of 0.08 for determining a DUI along with a threshold of 0.15 for an aggravated DUI. Hansen also studied data on recidivism within four years of an initial BAC test, observing drivers who were of the state's legal drinking age. The method used is a regression discontinuity design. This method tests the effect of the punishments imposed at BAC thresholds on future drunk driving. The conclusion he drew was that harsher punishments and sanctions tied to higher BAC limits are associated with reducing future drunk driving. Notably, having a BAC above the DUI or even Aggravated DUI thresholds is associated with short term and longterm reductions in recidivism.. Specifically, these estimates then suggest that a BAC over the 0.08 threshold corresponds with a 2 percentage point decline in repeat offenses over the next four years. Similarly, having a BAC over the 0.15  threshold is associated with an additional 1 percentage point decline in repeat offenses. Lastly, he calculated an elasticity which claims that a ten percent increase in sanctions and punishments is associated with a 2.3 percent decline in future drunk driving. ")
putdocx paragraph, style(Heading1)
putdocx text ("Reproducing somewhat Hansen’s results but just follow directions")
putdocx paragraph
putdocx text ("3. Create a dummy")
gen arrest = 0
replace arrest = 1 if bac1 >= 0.08
sum arrest
putdocx table arrest = rscalars
putdocx paragraph
putdocx text ("4. Evidence of manipulation")
hist bac1, xline(.08) xline(.15)
graph export Graph1.png, replace
putdocx image Graph1.png, height(5 in)
putdocx paragraph
putdocx text ("If individuals could manipulate their blood alcohol content, we could use a McCrary density test to check if that's happening. I don't find any evidence for sorting on the running variable and this is consistent with Hansen’s results. Visually, this makes sense because there doesn't seem to be a discontinuity in the data around the cutoff point (i.e there's no change in behavior due to the running variable).")

putdocx paragraph
putdocx text ("5. Recreate Table 2 Panel A")
putdocx text ("The covariates are balanced at the cutoff. Had they not been, we would see very different values for the coefficients of the predetermined characteristics depending on DUI thresholds.")
regr recidivism white male aged acc
putdocx table results1 = etable
regr recidivism white male aged acc arrest
putdocx table results2 = etable

putdocx paragraph
putdocx text ("6. Recreate Figure 2 panel A-D")
cmogram acc bac1 if bac1<0.2, cut(0.08) scatter line(0.08) lfitci
graph export Graph2.png, replace
putdocx image Graph2.png, height(5 in)
cmogram acc bac1 if bac1<0.2, cut(0.08) scatter line(0.08) qfitci
graph export Graph3.png, replace
putdocx image Graph3.png, height(5 in)
cmogram male bac1 if bac1<0.2, cut(0.08) scatter line(0.08) lfitci
graph export Graph4.png, replace
putdocx image Graph4.png, height(5 in)
cmogram male bac1 if bac1<0.2, cut(0.08) scatter line(0.08) qfitci
graph export Graph5.png, replace
putdocx image Graph5.png, height(5 in)
cmogram aged bac1 if bac1<0.2, cut(0.08) scatter line(0.08) lfitci
graph export Graph6.png, replace
putdocx image Graph6.png, height(5 in)
cmogram aged bac1 if bac1<0.2, cut(0.08) scatter line(0.08) qfitci
graph export Graph7.png, replace
putdocx image Graph7.png, height(5 in)
cmogram white bac1 if bac1<0.2, cut(0.08) scatter line(0.08) lfitci
graph export Graph8.png, replace
putdocx image Graph8.png, height(5 in)
cmogram white bac1 if bac1<0.2, cut(0.08) scatter line(0.08) qfitci
graph export Graph9.png, replace
putdocx image Graph9.png, height(5 in)
putdocx paragraph
putdocx text ("I attained fairly similar results to Hansen in that these demographic characteristics are stable across DUI thresholds. Otherwise, the regression lines ought to change based on the threshold which may potentially indicate some level of discrimination.")

putdocx paragraph
putdocx text ("7. Replicate Table 3, column 1, Panels A and B")
***Panel A
gen bac1_c = bac1 - 0.08
gen bac1_c2 = bac1_c^2
**Column 1
reg recidivism bac1 if bac1>=0.03 & bac1<=0.13, robust
estimates store linearly1, title(model1)
**Column 2 (Interaction)
xi: reg recidivism i.arrest*bac1_c if bac1>=0.03 & bac1<=0.13, robust
estimates store lcoff1, title(model2)
**Column 3 (Interaction)
xi: reg recidivism arrest##(c.bac1_c c.bac1_c2) if bac1>=0.03 & bac1<=0.13, robust
estimates store lcoffquad1, title(model3)
***Panel B
**Column 1
reg recidivism bac1 if bac1>=0.055 & bac1<=0.105, robust
estimates store linearly2, title(model1)
**Column 2
xi: reg recidivism i.arrest*bac1_c if bac1>=0.055 & bac1<=0.105, robust
estimates store lcoff2, title(model2)
**Column 3
xi: reg recidivism arrest##(c.bac1_c c.bac1_c2) if bac1>=0.055 & bac1<=0.105, robust
estimates store lcoffquad2, title(model3)
estout linearly1 lcoff1 lcoffquad1
estout linearly2 lcoff2 lcoffquad2
gen bac1_c = bac1 - 0.08
gen bac1_c2 = bac1_c^2
reg recidivism bac1 if bac1>=0.03 & bac1<=0.13, robust
estimates store linearly1, title(model1)
xi: reg recidivism i.arrest*bac1_c if bac1>=0.03 & bac1<=0.13, robust
estimates store lcoff1, title(model2)
xi: reg recidivism arrest##(c.bac1_c c.bac1_c2) if bac1>=0.03 & bac1<=0.13, robust
estimates store lcoffquad1, title(model3)
reg recidivism bac1 if bac1>=0.055 & bac1<=0.105, robust

estimates store linearly2, title(model1)

xi: reg recidivism i.arrest*bac1_c if bac1>=0.055 & bac1<=0.105, robust

estimates store lcoff2, title (model2)

xi: reg recidivism arrest##(c.bac1_c c.bac1_c2) if bac1>=0.055 & bac1<=0.105, robust

estimates store lcoffquad2, title (model3)

estout linearly1 lcoff1 lcoffquad1

estout linearly2 lcoff2 lcoffquad2



putdocx paragraph
putdocx text ("8. Recreate the top panel of Figure 3") 
putdocx textblock end
cmogram recidivism bac1 if bac1 < 0.15, cut(0.08) scatter line(0.08) lfit
graph export Graph10.png, replace
putdocx image Graph10.png, height(5 in)
cmogram recidivism bac1 if bac1 < 0.15, cut(0.08) scatter line(0.08) qfit
graph export Graph11.png, replace
putdocx image Graph11.png, height(5 in)

putdocx paragraph
putdocx text ("9. Discuss what you learned from this exercise. What was the hypothesis you tested and what did you find? How confident are you in Hansen’s original conclusion? Why/why not)")
putdocx text ("I gained more practice with making figures/tables in Stata and learned more about RDD through doing this exercise. The hypothesis tested was if harsher punishments and sanctions are implemented, then these punishments and sanctions ought to curb driving under the influence. I feel pretty confident in Hansen’s original conclusion since there doesn't seem to be room for manipulation of the running variable BAC. Intuitively this makes sense since it would be difficult for one tending towards drunkness to precisely manage their BAC levels—if that's even possible—and the elasticity of an increase in more severe punishment being associated with a reduction in recidivism gives me some comfort that their economic intuition on the relationship between tougher punishments and repeat offenses is supported.")

putdocx save RDDfinaldraft, replace