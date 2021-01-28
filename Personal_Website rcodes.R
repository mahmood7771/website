sessionInfo()
install.packages("blogdown")
blogdown::install_hugo()
blogdown::update_hugo()
blogdown::hugo_version()

#to use knitr use this way to upload photo

#```{r, echo=FALSE,fig.cap="caption",fig.show='hold',fig.align='center'}
#knitr::include_graphics('/about_files/figure-html/installationsandspcost_for_data.png')
#``` 


options(blogdown.ext = '.Rmd', blogdown.author = 'Mahmood Hasan')
blogdown::new_post("Data Visualization With Software R")
blogdown::new_post("Time Series Projects")
blogdown::new_post("Plots with Software STATA")
blogdown::new_post("Plots with Software Tableau")
blogdown::new_post("Hypothesis Testing Using Bootstrap in R")
blogdown::new_post("Knowledge Mobilization")
blogdown::new_post("Machine Learning: Support Vector Machines")
getwd()
  
blogdown::build_site()
blogdown::serve_site()
servr::daemon_stop
