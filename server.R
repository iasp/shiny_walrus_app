# Server
server <- function(input, output) {
        analyzeText <- reactive({
                text <- input$text_input
                words <- unlist(strsplit(tolower(gsub("[^[:alnum:] ]", "", text)), "\\s+"))
                words <- words[words != ""]
                char_count <- nchar(text)
                word_count <- length(words)
                word_frequency <- sort(table(words), decreasing = TRUE)
                walrus_count <- sum(words == "walrus")
                
                list(
                        char_count = char_count,
                        word_count = word_count,
                        word_frequency = word_frequency,
                        walrus_count = walrus_count  
                )
        })
        output$char_count <- renderUI({
                HTML(paste("<strong style='color: black;'>Number of characters:</strong>", analyzeText()$char_count))
        })
        output$word_count <- renderUI({
                HTML(paste("<strong style='color: green;'>Number of words:</strong>", analyzeText()$word_count))
        })
        output$word_frequency <- renderTable({
                word_freq <- analyzeText()$word_frequency
                data.frame(
                        Word = names(word_freq),
                        Frequency = as.integer(word_freq),
                        row.names = NULL
                )
        })
        output$walrus_count <- renderUI({
                walrus_count <- analyzeText()$walrus_count
                HTML(paste("<strong style='color: purple;'>Walrus counter:</strong>", walrus_count))
        })
        
        output$sing_button <- renderUI({
                walrus_count <- analyzeText()$walrus_count
                if (walrus_count >= 1) {
                        tagList(
                                h4("Would you like to sing a chorus?", align = "center"),
                                radioButtons("sing", label = NULL, choices = c("Yes", "No thanks, I already sang yesterday."), selected = "No", inline = FALSE)
                        )
                }
        })
        
        output$lyrics <- renderUI({
                if (!is.null(input$sing) && input$sing == "Yes") {
                        HTML("<p style='color: darkred; font-size: 18px; text-align: center;'>I am the eggman/They are the eggmen/I am the walrus/Goo goo g' joob g' goo goo g' joob!</p>")
                }
        })
}

