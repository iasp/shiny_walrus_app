
library(shiny)
library(shinythemes)

# UI
ui <- fluidPage(
        theme = shinythemes::shinytheme("journal"),  
        titlePanel(h1("Are there walruses in your text?", align = "center")), 
        fluidRow(
                column(6, offset = 1,  
                       wellPanel(
                               textAreaInput("text_input", "Enter your text:", rows = 5, placeholder = "Type some text here, perhaps with a walrus or two if you like The Beatles...")
                       ),
                       br(),
                       h4("Word Frequency", align = "center"),
                       tableOutput("word_frequency")
                ),
                
                column(4,  
                       h3("Analysis Results", align = "center"),
                       br(),
                       htmlOutput("char_count"),
                       htmlOutput("word_count"),
                       br(),
                       htmlOutput("walrus_count"),
                       br(),
                       uiOutput("sing_button"),
                       br(),
                       uiOutput("lyrics")
                )
        )
)