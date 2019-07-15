
source("insights_plots2.R")

# create the server functions for the dashboard  
server <- function(input, output, session) { 
  
  
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    
    vars <- names(df)
    nums <- df[sapply(df,is.numeric)]
    cats <- df[sapply(df,is.factor)]
    print(names(nums))
    print("#####")
    print(names(cats))
   
    updateSelectInput(session, "input_axis","numerical Variable", choices = names(nums))
    updateSelectInput(session, "axis","categorical Variables", choices = names(cats))
    makeReactiveBinding("df")
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
    
  })
  
  
  data <- reactive({
    
    read.csv(input$file1$datapath,
             header = input$header,
             sep = input$sep,
             quote = input$quote)
  })
  
  output$numstats <-renderPlot(
    {
      df <- data()
      print("dataframe is:")
      #print(head(df))
      numerical_histogram(input,df)
    }
  )
  
  
  output$box_plot <-renderPlot(
      {
        df <-data()
        numerical_boxplot(input,df)
      }
    
  )


  output$pie_chart <- renderPlot(
    
    {
      df <-data()
      categorical_piechart(input,df)
      
    }
    
  )
  
  output$bar_plot <- renderPlot(
    {
      df<- data()
      categorical_barplot(input,df)
      
    }
    
  )

  
  
}