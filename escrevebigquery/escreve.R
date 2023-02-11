

library(tidyverse)
library(bigrquery)

library(DBI)

options(gargle_oauth_cache = ".secrets")


con <- dbConnect(
    bigrquery::bigquery(),
    project = "bigquerycrotman",
    dataset = "football",
    billing = "carteira_crotman"
)


dbListTables(con)

events <- read_csv("escrevebigquery/dados/events.csv")

events_int <- events |> 
    mutate(
        across(
             .cols = where(is.numeric),
             .fns = as.integer
             
        )
    )

games <-  read_csv("escrevebigquery/dados/ginf.csv") |> 
    mutate(
        across(
            .fns = as.integer,
            .cols = c(season, fthg, ftag ) 
        )
    )





dbWriteTable(con, "events", events_int)



dbWriteTable(con, "games", games)




