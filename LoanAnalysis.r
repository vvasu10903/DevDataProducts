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


library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Prediction of Interest Rates for P2P Loans"),
    sidebarPanel(
        sliderInput('fico', 'Enter FICO Score (690-850):', value = 690, min = 690, max = 850, step = 5),
        sliderInput('amount', 'Enter Loan Amount Requested ($1000 - $35000):',
                    value = 10000, min = 1000, max = 35000, step = 100, format="$#,##0", locale="us"),
        sliderInput('income', 'Enter Monthly Income ($500 - $100000):', value = 5500, min = 0, max = 100000, step = 100, format="$#,##0", locale="us"),
        uiOutput("slider1"),
        sliderInput('length', 'Enter Loan Length (months):', value = 42, min = 36, max = 60, step = 1),
        sliderInput('creditLines', 'Enter Number of Credit Lines:', value = 5, min = 2, max = 40, step = 1),
        numericInput('inquiries', 'Enter Number of Credit Inquiries in Last Six Months:', value = 1, min = 0, max = 9, step = 1),
        submitButton('Submit')
    ),
    mainPanel(
        p('Documentation:', a('Loan Analysis Help', href="LoanAnalysisHelp.html")),
        h3('Results of interest rate calculation'),
        h5('You entered:'),
        tableOutput("values"),
        wellPanel(
            span(h5('which resulted in an annual interest rate % of:'),
                 textOutput("rate")))
    )
))
