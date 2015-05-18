library(shiny)
library(zoo)

data <- read.csv("data/sales_data.csv")
data$'Date' <- as.Date(as.character(data$'Date'), "%Y%m%d")
dfr <- data.frame(data$'Date', data$Buildings.Sq..Ft., data$'Adjusted.Sale.Price')
dfr[dfr == 0] <- NA
newdfr <- na.omit(dfr)

shinyServer( 
        function(input, output) {
                output$enddate <- renderPrint({input$date})
                output$startdate <- renderPrint({input$date - input$years*365})
                output$newScatter <- renderPlot({
                        with(newdfr[(newdfr$data.Date > {input$date - input$years*365}) & (newdfr$data.Date < input$date),], plot(data.Buildings.Sq..Ft., data.Adjusted.Sale.Price, xlim = range(0:{input$sqft}), ylim = range(0:{input$price})))   
                })
                output$multiScatter <- renderPlot({
                        with(newdfr[newdfr$data.Date > {input$date - input$years*365} & (newdfr$data.Date < input$date),], plot(newdfr))
                })
                output$timePlot <- renderPlot({
                        with(newdfr[newdfr$data.Date > {input$date - input$years*365} & (newdfr$data.Date < input$date),], plot(data.Date, data.Adjusted.Sale.Price/data.Buildings.Sq..Ft.))
                })
                output$table <- renderTable({
                        with(newdfr[newdfr$data.Date > {input$date - input$years*365},], newdfr)
                })
                output$summary <- renderPrint({
                        summary(newdfr)
                })
                output$boxplot <- renderPlot({
                       # with(newdfr[newdfr$data.Date > {input$date - input$years*365},], 
                             boxplot(data.Adjusted.Sale.Price/data.Buildings.Sq..Ft.~as.yearqtr(data.Date),data= newdfr,
                                     varwidth=TRUE, col="lightblue", main="Quarterly Boxplots of Dollars per Square Foot", ylab="Dollars per Square Foot", las = 2)
                        #     )
                })
                output$yboxplot <- renderPlot({
                        boxplot(data.Adjusted.Sale.Price/data.Buildings.Sq..Ft.~as.numeric(format(newdfr$data.Date, "%Y")),data= newdfr,
                                varwidth=TRUE, col="lightblue", main="Yearly Boxplots of Dollars per Square Foot", ylab="Dollars per Square Foot")
                })
        } 
)