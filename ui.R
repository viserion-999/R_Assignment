## app.R ##
library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
library(ggmap)
library(devtools)
library(sp)
library(mapview)

register_google(key = "AIzaSyA_Lh0dPf2loqgG2nXekk50DiaqVEe6Rrk")
source("server.R")

ui <- dashboardPage(
  
  dashboardHeader(),
  
  dashboardSidebar(),
  dashboardBody()
  
)

#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Univariate Analysis")  

#Sidebar content of the dashboard
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Upload", tabName = "upload", icon = icon("train", lib = "font-awesome")),
    menuItem("Numerical", tabName = "numerical", icon = icon("train", lib = "font-awesome")),
    menuItem("Categorical", tabName = "categorical", icon = icon("train", lib = "font-awesome")),
    menuItem("Get the code!", icon = icon("send",lib='glyphicon'), 
             href = "https://www.google.com")
  )
)
## Title Panel to display information about the project

frow2 <- fluidRow( 
  
  box(
    title = "Upload files",
    status = "primary",
    solidHeader = TRUE,
    collapsible = TRUE,
    background = "aqua",
    fileInput("file1", "Choose CSV File",
              accept = c(
                "text/csv",
                "text/comma-separated-values,text/plain",
                ".csv")),
    # Horizontal line ----
    tags$hr(),
    
    # Input: Checkbox if file has header ----
    checkboxInput("header", "Header", TRUE),
    
    # Input: Select separator ----
    radioButtons("sep", "Separator",
                 choices = c(Comma = ",",
                             Semicolon = ";",
                             Tab = "\t"),
                 selected = ","),
    
    # Input: Select quotes ----
    radioButtons("quote", "Quote",
                 choices = c(None = "",
                             "Double Quote" = '"',
                             "Single Quote" = "'"),
                 selected = '"'),
    
    # Horizontal line ----
    tags$hr(),
    
    # Input: Select number of rows to display ----
    radioButtons("disp", "Display",
                 choices = c(Head = "head",
                             All = "all"),
                 selected = "head")
    
  ),
  
  box(
    title = "Dataframe:",
    status = "primary",
    solidHeader = TRUE,
    collapsible = FALSE,
    background = "aqua",
    #tableOutput("contents")
    
    div(style = 'overflow-x: scroll', tableOutput('contents'))
    
    
  )
)
frow3 <- fluidRow( 

  box(
    title = "Select the X-Axis for the histogram",
    status = "primary",
    solidHeader = TRUE,
    collapsible = TRUE,
    background = "aqua",
    width = 12,
    selectInput('input_axis', 'numerical Variable',choices = NULL)
    
  )
 

)

frow4 <- fluidRow(
  
  box(
    title = "Histogram for Numerical vars"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,column(width = 12, plotOutput("numstats", height = "500px"))
  ),
  box(
    title = "Boxplot for Numerical vars"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,column(width = 12, plotOutput("box_plot", height = "500px"))
  )
  
  
)


frow5 <- fluidRow( 
  
  box(
    title = "Select the X-Axis for the Bar plot",
    status = "primary",
    solidHeader = TRUE,
    collapsible = TRUE,
    background = "aqua",
    width = 12,
    selectInput('axis', 'categorical Variables',choices = NULL)
    
  )
  
  
)
frow6 <-  fluidRow(
  
  
  
  box(
    title = "Pie for Categorical vars"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,column(width = 12, plotOutput("pie_chart", height = "500px"))
    
    
  ),
  box(
    title = "Bar Chart for Categorical vars"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,column(width = 12, plotOutput("bar_plot", height = "500px"))
    
    
  )
)
  
# combine the two fluid rows to make the body
body <- dashboardBody(
  tabItems(
    tabItem(tabName = "upload",
            #h2("Can add heading here if we want to"),
            frow2
    ),
    
    tabItem(tabName = "numerical",
            #h2("Can add heading here if we want to"),
            frow3,
            frow4
            
    ),
    
    tabItem(tabName = "categorical",
            frow5,
            frow6
            
            
    )
  )
  
  
)

#Second  Tab -Predictions rows & graphs




#completing the ui part with dashboardPage
ui <- dashboardPage(title = 'Generate Basic Graphs', header, sidebar, body, skin='yellow')

