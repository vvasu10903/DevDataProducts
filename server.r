library(shiny)
library(UsingR)
shinyServer(
    function(input, output) {
        # Reactive expression to compose a data frame containing all of the values
        sliderValues <- reactive({
            # Compose data frame
            data.frame(
                Name = c("FICO Score", "Amount Requested", "Income", "Amount Funded",
                         "Number of Credit Lines", "Number of Inquiries", "Loan Length"),
                Value = as.character(c(input$fico, input$amount, input$income,
                                       input$funds, input$creditLines,
                                       input$inquiries, input$length)))
        }) 
        
        interestRate <- function(f1, a1, i1, f2, c1, i2, l1) {
            425.5 - 63.36 *log(f1) + 0.00005364 * a1 - 0.2956 * log(i1) +
                0.0001139 * f2 - 0.8542 * log(c1) + 0.3925 * i2 + 0.1313 * l1
        }
        
        
        output$rate <- renderText({
            interestRate(input$fico, input$amount, input$income, input$funds,
            input$creditLines, input$inquiries, input$length)})
        
        output$slider1 <- renderUI({
            amnt <- input$amount
            sliderInput('funds', 'Enter Amount Funded:', value = 10000, min = 0, max = amnt, step=100, format="$#,##0", locale="us") 
        })
        
        
        # Show the values using an HTML table
        output$values <- renderTable({
            sliderValues()
        })
    
    }
)