rm(list=ls())
bootstrap1<-function(y,X,vtest=2,B=99,prm=1){
  # Perform hypothesis testing for a single variable (not a constant) using Bootstrapping
  
  # Input:
  # y: dependent variable
  # X: matrix of independent variables (including constant if required)
  # vtest: which independent/explanatory variable is to be tested for statistical significance
  # B: number of Bootstrap replications
  # prm: parametric (1) or non-parametric (0) bootstrap
  
  # Output:
  # A list that contains the following:
  # (1) Regression output (actual data, under H1)
  # (2) Value of the respective test statistic, based on actual data
  # (3) Empirical distribution function based on boostrapping
  # (4) Boostrap p-value
  

  #---------------------------------------------------------------  
  # Preliminaries

  n<-length(y) # Sample Size
  k<-ncol(X) # Number of variables (including constant if present)
  
  
  # Create matrix with variables, excluding the one to be tested for statistical significance 
  # (Required for Bootstrap DGP)
  X1<-X[,-(vtest+1)]


  
  # Estimate Regressions
  
  # Under the alternative (H1): include all independent variables
  h1est1<-lm(y~X-1)
  # Save summary 
  h1est_sum<-summary(h1est1)
  # Obtain value for test statistic
  that<-coef(h1est_sum)[,"t value"][[vtest+1]]
  
  # Under the null hypothesis (H0): exclude variable of interest 
  h0est1<-lm(y~X1-1)
  # Save summary
  h0est_sum<-summary(h0est1)
    #Save residuals
  utilde<-h0est1$residuals
  # Create Efficient Residuals
  utilde_1<-sqrt(n/(n-k-1))*(utilde-mean(utilde))
    # Save coefficients (parameter estimates)
  betatilde<-h0est1$coefficients
    # Save Residuals Standard Error (estimate for the standard deviation of innovations)
  sigmatilde<-h0est_sum$sigma
  

  #----------------------------------------------------------------
  
  # Boostrap Processs
  # Create vector to store simulated test statistics
  tstar<-rep(0,B)
  
  for (b in 1:B){
  # Generate dependent variable using the DGP under the null
    
  # Get Innovations
  # Parametric (if selected)
  if (prm==1){  
   ustar<-sigmatilde*rnorm(n,0,1)
      }
  else
  # Non-parametric (if selected)
  {
ustar<-sample(utilde_1,n,replace=TRUE)
  }
  
  # Generate simulated dependent variable  
  
    
  ystar<-ustar
  
  for (j in 1:(k-1)){
    ystar<-ystar+X1[,j]*betatilde[[j]]
      }
  
 
    
  # Estimate Regression
    
    # Under the alternative (H1): include all independent variables
    h1est1star<-lm(ystar~X-1)
    # Save summary 
    h1eststar_sum<-summary(h1est1star)
    # Obtain value for test statistic
    that_temp<-coef(h1eststar_sum)[,"t value"][[vtest+1]]  
      tstar[b]<-that_temp
    
  }
 
# Calculate p-value for two-tailed test
  pval=sum(rep(1,B)[abs(tstar)>abs(that)])/B
   
# Return a list with output items
  
    list(regh1res=h1est_sum, that=that,tstar=tstar,pvalue=pval)
  

}

X<-matrix(c(Variables$dlgdp,Variables$dlypd,Variables$dlhpi,Variables$dldj),,4)
X<-cbind(1:1,X)
y<-matrix(Variables$dlcc,,1)

bootstrap1(y,X,2,B=999,prm=1)



X5<-X[,c(-4,-2)]



























