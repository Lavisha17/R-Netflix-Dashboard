library(shiny)
library(shinydashboard)

shinyUI(
  dashboardPage(
    dashboardHeader(title = tags$img(src='netflixlogo.jpg',height = '40', width = '50',alt='Netflix') , 
                    dropdownMenuOutput("msgOutput"),
                    # dropdownMenu( type = "message",
                    #               messageItem(from = "Finance update",message = "we are on threshold"),
                    #               messageItem(from = "Sales update",message = "we are on 65%",icon = icon("bar-chart"),time = "22:00"),
                    #               messageItem(from = "Sales update",message = "sales meeting at 6 PM on Monday",icon = icon("glyphicon glyphicon-pencil"),time = "25-03-2024") )
                    dropdownMenu(type = "notifications",
                                 notificationItem(
                                   text = "2 tabs added to the dashboard",
                                   icon = icon("dashboard"),
                                   status = "success"
                                 ),
                                 notificationItem(
                                   text = "Server is currently running at 95% load",
                                   icon = icon("warning"),
                                   status = "warning"
                                 )),
                    dropdownMenu(type = "tasks",
                                 taskItem(
                                   value = 80,
                                   color = "blue",
                                   "New Update for Netflix made Available"
                                 ),
                                 taskItem(
                                   value = 54,
                                   color = "red",
                                   "Maintenance work completed"
                                 ),
                                 taskItem(
                                   value = 97,
                                   color = "green",
                                   "Completion of R Project"
                                 ))
                  ),
    dashboardSidebar(
      sidebarMenu(
        sidebarSearchForm("searchText","buttonSearch","search"),
      menuItem("Home",tabName = "home",icon = icon("home")),
      menuItem("Dashboard",tabName = "dashboard",icon = icon("dashboard")),
        menuSubItem("Dashboard Userbase",tabName = "userbase" ),
        menuSubItem("Dashboard Sales",tabName = "sales"),
      menuItem("Detailed Analysis",icon = icon("list-alt"),badgeLabel = "New" , badgeColor = "red"),
      menuItem("Raw Data",icon = icon("table"),tabName = "datatab") 
    )),
    dashboardBody(
      tabItems(
        tabItem(tabName = "home",
                fluidRow(
                  box((HTML('<iframe width="880" height="415" src="https://www.youtube.com/embed/GV3HUDMQ-F8?si=aGYMa6FFCTdfBrW5" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>')),
                    width = 12,background = "black"
                  )
                ),
                fluidRow(
                  box(HTML('<iframe width="440" height="315" src="https://www.youtube.com/embed/OsIohljR4WY?si=9m2IoiOYu68C59a_" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'),
                  HTML('<iframe width="420" height="315" src="https://www.youtube.com/embed/_jMIULxyT4w?si=fdbtUm_EOLbl0PMw" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>'),
                      width = 12 , background = "black"
                  )
                )
        ),
        tabItem(tabName = "dashboard" , 
                column(width=12 ,fluidRow(
                  infoBox("Netflix Brand",
                          subtitle = "Netflix started as DVD rentals, and now they have an audience of over 150m people",
                          icon = icon("bullhorn"),
                          color = "red",
                          width = 6
                          ),
                  valueBoxOutput("revenuerequested",width = 6)
                )),
                column(width = 12 ,fluidRow(box(plotOutput("barplot"),title = "Application operated on Devices",status = "danger",solidHeader = T,background = "black"),
                                            box(plotOutput("pie3D"),title = "Pie Chart based on Subscription Type",status = "danger",solidHeader = T,background = "black")
                                            ))
                ),
        tabItem(tabName = "userbase" , 
                h1("Userbase Dashboard"),
                column(width = 12 ,fluidRow(box(plotOutput("stack")),
                                            box(plotOutput("histogram"))))
                ),
        tabItem(tabName = "sales" , 
                h1("Sales Dashboard"),
                column(width = 12 ,fluidRow(box(plotOutput("pie")),
                                            box(plotOutput("jitter"))))                
                ) ,
        tabItem(tabName = "datatab",
                h1("Fetch Data"),
                fluidRow(
                  tabBox(
                    tabPanel("Data",tableOutput("Netflix_Userbase")),
                    tabPanel("Summary",verbatimTextOutput("summ")),width = 12
                    )
                )
                )
      ),
      
      tags$head(tags$style(HTML('
        .content-wrapper {
          background-color: #000101 !important;
        }
        h1 {
           color: #F7F7F7;
           text-align:center;
        }
        .skin-blue .main-header .logo {
                              background-color: #000101;
                              }

        .skin-blue .main-header .logo:hover {
                              background-color: #000101;
                              }
        .skin-blue .main-header .navbar {
                              background-color: #181918;
                              font-color:#F7F7F7;
                              }        
        .skin-blue .main-sidebar {
                              background-color: #181918;
                              font-color: #F7F7F7;
                              }
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
                              background-color: #000101;
                              }

        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
                              background-color: #181918;
                              }
        .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
                              background-color: #111111;
                              font-color:#111111;
                              }
        .skin-blue .main-header .navbar .sidebar-toggle:hover{
                              background-color: #000101; }')))
    )
  )
)