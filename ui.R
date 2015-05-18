library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Housing Sales on Upper Kingsbury"),
        sidebarPanel(
                h3('Date range'),
                sliderInput('years', 'Duration of period in years',value = 10, min = 0.25, max = 15, step = 0.25,),
                dateInput("date", "End date:"),
                h3('Axis scaling'),
                sliderInput('sqft', 'Maximum Square Footage',value = 3000, min = 500, max = 7500, step = 100,),
                sliderInput('price', 'Maximum Sales Price',value = 1000000, min = 100000, max = 2000000, step = 10000,)
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel("Sale price versus square footage",
                                 h3('Sale price as a function of square footage'),
                                 plotOutput('newScatter')
                                 #                                 h4('Start date'),
                                 #                                 verbatimTextOutput("startdate"),
                                 #                                 h4('End date'),
                                 #                                 verbatimTextOutput("enddate")
                        ),
                        tabPanel("Dollars per square foot over time", plotOutput('timePlot')),
                        tabPanel("Multi-scatter plot", plotOutput('multiScatter')),
                        tabPanel("Data summary", 
                                 verbatimTextOutput("summary")
#                                 tableOutput('table'))
                        )
                        
                )
        )
))