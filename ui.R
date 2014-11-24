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
