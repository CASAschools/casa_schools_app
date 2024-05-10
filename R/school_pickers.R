# Explore your hazards picker drop down 
# -------------- Drop down picker for City selected --------------------
city_pickers <- function(inputId){
  
 pickerInput(inputId = inputId, label = "Choose a city:",
             choices = unique(school_points$City))
}

# -------------- Drop down picker for School District selected ---------
district_pickers <-function(inputId){
  
  pickerInput(inputId = inputId,label = "Choose a district:",
                            choices = unique(school_points$DistrictNa),
              width = 5)
}
  
# -------------- Drop down picker for School District selected ---------
schoolname_picker <-function(inputId){
  
  pickerInput(inputId = inputId,label = "Choose a School:",
              choices = unique(school_points$SchoolName))
}
  
