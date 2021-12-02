library(shiny)
library(ggplot2)
library(dbplyr)
library(tibble)

fluidPage(
  #Navigation Bar
  navbarPage("CFB Data", 
            #First Tab
             tabPanel("Correlation",
                    #Header Panel
                    titlePanel(title = h4("College Football Team Statistics Correlation for Years 2013-2020", align="center")),
                    sidebarLayout(
                    #Sidebar Panel  
                    sidebarPanel(
                      selectInput("xSelection", "Select an X Variable", colnames(cfb), multiple=F, selected="Off.Plays"),
                      selectInput("ySelection", "Select a Y Variable", colnames(cfb), multiple=F, selected="Off.Rank"),
                      radioButtons("color", "Select the color of the scatter plot", choices=c("Orange", "Blue", "Red", "Purple"), selected="Orange")
                    ),
                    #Main Panel
                    mainPanel(
                      plotOutput("scatter"),
                      wellPanel(textOutput("correlation"))  
                    )
                    )         
                    ),
           #Second Tab
            tabPanel("About", tags$div("This site allows you to explore the correlation between a large number of team statistic for FBS college football over the last 8 seasons.", 
                                       tags$br(), " ", tags$br(),
                                       "For more information on how to use this app, please refer to the tutorial tab.", 
                                       tags$br(), " ", tags$br(),
                                       "This app was created as part of an assigment for the course DS 501 at Worcester Polytechnic Institute in Worcester, Massachusetts.",
                                       tags$br(), " ", tags$br(),
                                       "The data collected for this application was obtained from https://www.kaggle.com/jeffgallini/college-football-team-stats-2019. This was a group of data sets, 
                                       one for each of the last eight college football seasons that contained over 140 different team statistics for nearly all division one FBS teams.",
                                       tags$br(), " ", tags$br(),
                                       "This topic was interesting and important to me because I've played football for the past 13 years, and it's something that I'm really passionate about. I love 
                                       learning more about the game, so this felt like a natural choice to go ahead with a data set that would allow me to explore college football statistics and see 
                                       what kind of correlations I could find. I also am interested in becoming a coach in the future, so these insights into what kind of team stats can correlate heavily 
                                       with success indicators are valuable knowledge for me.",
                                       tags$br(), " ", tags$br(),
                                       "To begin analyzing this data, I first had to clean up the data that I collected. I eliminated any variables that only had stats recorded for some years but not all.
                                       I then combined the dataframe for each individual year into one overall dataframe for easier use, since I wanted to look at the data as a whole over the past 8 years.
                                       From here, I moved into some exploratory data analysis, testing a set of various cases that I was interested in by creating a scatter plot and calculating correlation between
                                       pairs of statistics. The results from this exploration showed that some combinations did have strong correlation while others that I would've expected to be highly correlated
                                       didn't. I felt this proved that an application allowing users to explore these correlations for themselves on any combination of two stats was necessary. I'm sure coaches
                                       specifically could make use of this by confirming hypotheses about correlation and at times gaining insight that statistics they thought were strongly correlated actually aren't.
                                       To move forward, I created my shiny application using the shiny and ggplot2 r packages, accessing user inputs on x variable, y variable, and plot color as reactive data and utilizing
                                       this reactive data to generate the appropriate scatter plot and correlation coefficient calculation.",
                                       tags$br(), " ", tags$br(),
                                       "While exploring the data, I was able to find some interesting results. I found that there wasn't as strong of a correlation between number of offensive plays run and offensive
                                       rank as I thought there would be. There's definitely a connection, but it seems that once you get past a certain point in number of plays, it doesn't have as strong of a correlation
                                       with how well your offense performs. I suppose this makes sense as the game has evolved to adapt to up-tempo offense. The Chip Kelly style of high-octane maximum number of offensive
                                       plays doesn't stun opposing defense as much as it used. Of course there's a balance there where you dont want to move so slow that you're in the bottom tier in terms of number of plays
                                       run, but it is not as imperative to lead the country in that area to be a top offense now that most teams are achieving a similar high threshold of offensive plays run. Another stat I 
                                       explored that had a surprising result was the correlation between penalty and time of possession rank. This was something I expected to have a relatively strong correlation but actually
                                       turned out to have the lowest correlation by a decent margin of any of the cases I explored. Penalties, especially when on offense, are commonly thought of as potential drive killers,
                                       and they also tend to be seen as critical errors that extend opposing drives on defense. I think most people in the football world would expect penalties and time of possession to have
                                       a relatively high correlation, but it turns out that for the most part this isn't actually the case. This means that the teams that are resilient and can endure the penalties will still
                                       be able to be successful in maintaining possession. On the converse side, out of the initial group of relations I explored, the relation that had the highest correlation was opponent 3rd
                                       down percentage and defense rank. This confirms and supports the thinking that getting off the field on third down is critical to a successful defense. To be a great defense, you need to
                                       be at your best on 3rd down when it matters the most. This cuts drive short and gets the ball back to your offense to go out and score. These were just a few of the insights that can be
                                       gained from the exploration of this data.",
                                       tags$br(), " ", tags$br(),
                                       "Author: Ryan Michaud - WPI '21",
                                       tags$br(), " ", tags$br(),
                                       "The corresponding code for this assignment and app can be found at: https://github.com/RMichaud53/DataProductDS501"
                                       )
                    ),
           #Third Tab
           tabPanel("Tutorial", tags$div("This app allows you to dive into a set of 146 different variables containing team statistics for FBS college football teams over the last eight seasons. You are able
                                         to select any two of these variables and immediately be presented with a scatterplot of the two statistics in the color of your choice along with the calculcated
                                         correlation coefficient corresponding to the two selected variables.",
                                         tags$br(), " ", tags$br(),
                                         "The user inputs are all located in the side panel on th left hand side of the screen. In the first drop-down menu, you will be selecting which variable will be plotted
                                         on the x-axis. Following up in the second drop-down directly below, you will be selecting which variable will be plotted on the y-axis. The very first option in the drop-down
                                         menu is 'Team'. This was just the team name for every row in the original dataset. You can select it as the variable if you'd like still, but this is the only character variable
                                         in the dataset and won't produce a correlation coefficient if plotted. After the two drop-down menus, there are four bubbles where you can select what color you would like the
                                         points in the scatter plot to be presented in. The scatter plot will appear in the main panel of the application to the right of the user inputs, and the correlation coefficient
                                         will apear directly below the scatter plot. As a note, negative correlation means that one variable decreases while the other increases. This will happen at times, likely if you
                                         have selected any of the 'rank' statistics, since a lower rank is better, i.e. 1st place.",
                                         tags$br(), " ", tags$br(),
                                         "Now you have the basics of how the app works and how you can interact with it. You're free to explore the data as you please.",
                                         tags$br(), " ", tags$br(),
                                         "What kind of offensive statistics have the largest impact on touchdowns scored?", tags$br(), "Does 'bend don't break' defense actually exist?", tags$br(), 
                                         "Does running more plays each game correlate with more touchdowns?", tags$br(), "Does a stronger pass or run defense correlate to more wins?", tags$br(), "What about special teams?", 
                                         tags$br(), " ", tags$br(),
                                         "The possibilities here are nearly endless, so have fun exploring the data!"
                                          )
                    )
             )
)