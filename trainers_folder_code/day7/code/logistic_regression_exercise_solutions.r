# Here we will have the solutions to the exercise for the Logistic Regresion daya
#setwd("H:/Pwani_Collabo/stats_2015/") # amend as required
onchall <- read.csv("data/onchall.csv")


# Exercise 1
# Using R as a calculator
# Prevalence/Risk for Savannah
281/548
# Prevalence/Risk for Forest
541/754
# Odds of mf infection for Savannah
281/267
# Odds of mf infection for Forest
541/213
# Log odds of disease Savannah
log(281/267)
# Log odds of disease Forest
log(541/213)

# Odds ratio
(541/213)/(281/267) # --> log odds ratio of
log((541/213)/(281/267))


# Practical 1
ond15p <- read.csv("data/ond15p.csv")           # read in the data from the stata csv file
View(ond15p)                                  # take a quick look at the data 
ondmftab <- table(ond15p$ond,ond15p$mfpos)    # create  atable object    
ondmftab                                      # show that
chisq.test(ond15p$ond,ond15p$mfpos)           # test the association between mfpos and disease 
prac1mod <- glm(ond~mfpos,data=ond15p,family=binomial)  # fit a logistic model
summary(prac1mod)
exp(coef(prac1mod))
exp(confint(prac1mod))
femalesondis <- subset(ond15p,subset=sex=="Female")  # create a subset of the date with just females
prac1mod_f <- glm(ond~mfpos,data=femalesondis,family=binomial)  # fit the logistic model
summary(prac1mod_f)
exp(coef(prac1mod_f))
exp(confint(prac1mod_f))

# Exercise 2
# Working from left to right of the table and top to bottom
# Calculate the log odds of infection for the age group 10-19 
log(0.83)

# Odds ratio of infection for 20-39 age group compared to reference
# group (5-9) year olds
2.392/0.29  # or more precisely
2.393/(46/156)
exp(.872) # or take the antilog ie exponentiate .872

# log odd ratio of infection in 20-38 compared to baseline
log(2.392/(46/156))

# odds of infection in those greater than 40
378/80

# log odds of infection in those over 40
log(378/80)

# log odds ratio of infection for those over 40 compared to those 5-9
log((378/80)/(46/156))

# Practical 2
prac2mod1a <- glm(ond~mfpos + sex,data=ond15p,family=binomial)
summary(prac2mod1a)
exp(coef(prac2mod1a))
exp(confint(prac2mod1a))
prac2mod1b <- glm(ond~mfpos + as.factor(agegrp),data=ond15p,family=binomial)
summary(prac2mod1b)
exp(coef(prac2mod1b))
exp(confint(prac2mod1b))

prac2mod2 <- glm(ond~mfpos + sex + as.factor(agegrp),data=ond15p,family=binomial)
summary(prac2mod2)
exp(coef(prac2mod2))
exp(confint(prac2mod2))
anova(prac2mod1a,prac2mod2,test="LRT") # test whether adding agrgrp improves fit


# Practical 3
# Fit the model with both area and agegrp as main effects
prac3mod1<-glm(mf ~ area + as.factor(agegrp), data=onchall,family=binomial)
summary(prac3mod1)
# Now the model with the interaction term for the combination of the two exposure variables
prac3mod2<-glm(mf ~ area * as.factor(agegrp), data=onchall,family=binomial)
summary(prac3mod2)
# test for the interaction
anova(prac3mod1,prac3mod2,test="LRT")

forest<-subset(onchall,area==0)
savannah <-subset(onchall,area==1)

modsav <- glm(mf~as.factor(agegrp),data=savannah,fam=binomial)
modfor <- glm(mf~as.factor(agegrp),data=forest,fam=binomial)

summary(modsav)
summary(modfor)