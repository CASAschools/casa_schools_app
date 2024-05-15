update_tab_name <- function(school) {
  
  renderUI({
    # make sure there's a selection, outputting a message if there is none
    if (!is.null(school) && school != "") {
      h3(tags$strong(school), style = "font-size: 20px")
    } else {
      h3(tags$strong("Select a school", style = "font-size: 20px"))
    }
  })
}