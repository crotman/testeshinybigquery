#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DBI)
library(reactable)

options(
    gargle_oauth_cache = ".secrets",
    gargle_oauth_email = TRUE
)


con <- dbConnect(
    bigrquery::bigquery(),
    project = "bigquerycrotman",
    dataset = "football",
    billing = "carteira_crotman"
)


games <- tbl(con, "games") |> 
    collect()


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    
    reactableOutput(
        outputId = "tabela"
    )
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$tabela <- renderReactable({
        
        reactable(games)
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
