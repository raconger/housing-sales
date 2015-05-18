library(shiny)
shinyServer( 
        function(input, output) {
                output$enddate <- renderPrint({input$date})
                output$startdate <- renderPrint({input$date - input$years*365})
                output$newScatter <- renderPlot({
                        data <- read.csv("sales_data.csv")
                        data$'Date' <- as.Date(as.character(data$'Date'), "%Y%m%d")
                        dfr <- data.frame(data$'Date', data$Buildings.Sq..Ft., data$'Adjusted.Sale.Price')
                        dfr[dfr == 0] <- NA
                        newdfr <- na.omit(dfr)
                        with(newdfr[newdfr$data.Date > {input$date - input$years*365},], plot(data.Buildings.Sq..Ft., data.Adjusted.Sale.Price, xlim = range(0:{input$sqft}), ylim = range(0:{input$price})))   
                        })
        } 
)