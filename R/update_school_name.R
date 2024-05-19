update_school_name <- function(school) {
  
  # update school name underneath the tab title for each hazard
  renderUI({
    # make sure there's a selection, outputting a message if there is none
    if (!is.null(school) && school != "") {
      h3(tags$strong(school), style = "font-size: 20px")
    } else {
      h3(tags$strong("Select a school", style = "font-size: 20px"))
    }
  })
  
}