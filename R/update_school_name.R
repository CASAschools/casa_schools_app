update_school_name <- function(school) {
  
  # update school name underneath the tab title for each hazard
  renderUI({
    # make sure there's a selection, outputting a message if there is none
    if (!is.null(school) && school != "") {
      h2(tags$strong(school), style = "font-size: 30px")
    } else {
      h2(tags$strong("Select a school", style = "font-size: 20px"))
    }
  })
  
}