library(shiny)
library(shinydashboard)
library(plotrix)
library(dplyr)

function(input, output, session) {
  colors <- c('#221f1f', '#b20710', '#e50914', '#f5f5f1')
  output$histogram <- renderPlot({
    hist(df$Age,
         main="Most Userbase according to Age",
         xlab="Age",
         ylab=" ",
         col=colors,
         breaks=5,
         ylim = c(0,570))
  })
  
  output$pie3D <- renderPlot({
    subc <- data.frame( df %>% 
                          group_by(df$SubscriptionType) %>% 
                          summarise(count = n()))
    pie3D(subc$count,labels = subc$df.SubscriptionType,
          explode=0.05,
          col = colors,theta = pi/4,radius = 0.85, height = 0.15)
  })
  
  output$stack <- renderPlot({
    cgstck <- data.frame(df %>%
                           group_by(df$Country,df$Gender) %>%
                           summarise(count = n()))
    ggplot(cgstck, aes(x = cgstck$df.Country,
                       y = cgstck$count, fill = cgstck$df.Gender)) +
      geom_bar(stat = "identity", position = "stack",width = 0.7) + 
      xlab("Country")+ ylab("Count") + 
      theme_classic() + labs(fill = "Gender") + 
      ggtitle("Country Gender Population Counts") +
      scale_fill_manual(values = c('#e50914', '#221f1f'))
  })
  
  output$barplot <- renderPlot({
    devicecount <- data.frame( df %>% 
                                 group_by(df$Device) %>% 
                                 summarise(count = n()))
    barplot(devicecount$count, names.arg = devicecount$df.Device,
            col = colors, 
            xlab = "Devices", 
            ylab = " ", 
            ylim = c(0, 700))
  })
  
  output$pie <- renderPlot({
    mr_sub <- df %>%
      group_by(df$SubscriptionType) %>%
      summarise(count = n())
    pie(mr_sub$count,labels = mr_sub$`df$SubscriptionType`,
        radius = 1.0,col = colors , angle = 45 ,edges = 500 ,
        clockwise = TRUE,
        main="Revenue from different Subscriptions")
  })
  
  output$jitter <- renderPlot({
    mr_coun <- df %>%
      group_by(df$Country) %>%
      summarise(revcount = n())
    ggplot(mr_coun , aes(x = mr_coun$revcount,
                         y = mr_coun$`df$Country`)) +
      geom_jitter()+   
      ggtitle("Revenue each Country generates") +
      theme_minimal()+ ylab("Country")+ xlab(" ")
  })
  
  output$msgOutput <- renderMenu({
    msgs <- apply(read.csv("msgs.csv"),1,function(row){
      messageItem(from = row[["from"]],message = row[["message"]],
                  icon = icon(row[["icon"]]) , time = row[["time"]])
    })
    
    dropdownMenu(type = "messages", .list = msgs)
  })
  
  output$revenuerequested <- renderValueBox({
    totr <- sum(df$MonthlyRevenue)
    valueBox(totr,"Total Revenue Collected",icon = icon("usd"),color = "red")
  })
  
  output$Netflix_Userbase <- renderTable({
    read.csv("Netflix_Userbase.csv")
  })
  
  output$summ <- renderPrint({
    summary(read.csv("Netflix_Userbase.csv"))
  })
}
