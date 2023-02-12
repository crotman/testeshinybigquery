
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
    billing = "bigquerycrotman"
)


games <- tbl(con, "games") |> 
    group_by(country) |> 
    summarise(
        across(
            .cols = starts_with("odd"),
            .fns = mean
        )
    ) |> 
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
