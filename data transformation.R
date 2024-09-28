
#------------------------------------- Chapter 1. Data Visualization -------------------------------------------
#tidyverse package is the core and ggplot2
install.packages("tidyverse")
library(tidyverse)

install.packages("palmerpenguins")  #palmerpenguins package, which includes the penguins dataset 
install.packages("ggthemes")  #offers a colorblind safe color palette.
library(palmerpenguins)
library(ggthemes)
penguins #part of data shown in the console
View(penguins)
glimpse(penguins) #shows the data transposed


##################################scatter plots########################################

#displaying the relationship between flipper lengths and body masses of these penguins
#Creating a ggplot
ggplot(data = penguins,mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +geom_point() #builds a scatter plot and shows the relation

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color =
  species)) + geom_point() #adds colors for the different species

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)) + 
  geom_point() + geom_smooth(method = "lm") #adds smoothing line to each species by linear model method

ggplot(
  penguins,aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(color = species)) +
  geom_smooth(method="lm") #with color specified in geom_point give a single lm

ggplot(
  penguins,aes(flipper_length_mm, body_mass_g)) +
  geom_point(aes(shape = species, color=species)) +
  geom_smooth(method="lm") #gives the data points shape too

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) + geom_point(aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(title = "Body mass and flipper length", subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo
Penguins", x = "Flipper length (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) + scale_color_colorblind() # the last layer gives more clear colors

# alternatively
depth <- ggplot(penguins, aes(bill_depth_mm, bill_length_mm))
depth + geom_point(aes(color=species)) + geom_smooth(method="lm") #builds scatter plot

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color =island)) +
  geom_point() + geom_smooth(se = FALSE)  #eliminates the error band

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) + geom_point() + geom_smooth() #result 1

ggplot() +
  geom_point(penguins,
  mapping=aes(flipper_length_mm,body_mass_g)) +geom_smooth(
  penguins,mapping=aes(flipper_length_mm,body_mass_g)) #same as result 1

penguins |>
  ggplot(aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point() #using a pipe operator to get a scatter plot


##########################Visualizing Distributions#########################
#Categorical variable
ggplot(penguins, aes(x = species)) + geom_bar() #a bar graph with vertical bars
ggplot(penguins, aes(y = species)) + geom_bar() #a bar graph with horizontal bars
ggplot(penguins, aes(x = fct_infreq(species))) + geom_bar()#reorders the bars in order after making spices a factor
ggplot(penguins, aes(x = species)) + geom_bar(color = "Red") #red to the boundaries of bars
ggplot(penguins, aes(x = species)) + geom_bar(fill = "Red") #red to the bars

ggplot(penguins, aes(x = island, fill = species)) +geom_bar(position = "fill")
ggplot(penguins, aes(x = species, fill = island)) +geom_bar(position = "fill")

#A Numerical Variable
ggplot(penguins, aes(x = body_mass_g)) + geom_histogram(binwidth = 200) #histogram
#--------------------------------------
ggplot(penguins, aes(x = body_mass_g)) + geom_histogram(binwidth = 20) #binwidth is very vital for a proper display of the data
ggplot(penguins, aes(x = body_mass_g)) + geom_histogram(binwidth = 2000)
#-------------------------------------

#A density plot an alternative for a histogram
ggplot(penguins, aes(x = body_mass_g)) +  geom_density() #density plot


##Visualizing Relationships
#A Numerical and a Categorical Variable
#Using box plots
ggplot(penguins, aes(x = species, y = body_mass_g)) +  geom_boxplot() #vertical
ggplot(penguins, aes(x =body_mass_g , y = species)) +  geom_boxplot() #horizontal

#Using density plot
ggplot(penguins, aes(x = body_mass_g, colour = species)) +geom_density(linewidth = 0.75) 
ggplot(penguins, aes(x = body_mass_g, color = species, fill =
  species)) + geom_density(alpha = 0.5) #adds fill and alpha is the thickness of the fill btwn 0-1

#Bar charts for two categorical variables
ggplot(penguins, aes(x = island, fill = species)) +  
  geom_bar() #frequencies of each species of penguins on each island
ggplot(penguins, aes(x = island, fill = species)) +  geom_bar(
  position = "fill") #the second fill gives percentages and a better sense of interpretation

#Two Numerical Variables, scatter plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +  geom_point() #scatter plot
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = island))#more variables into a plot by mapping them to additional aesthetics but less intuition

ggplot() +geom_point(mpg, mapping=aes(displ,hwy)) +
  geom_smooth(mpg,mapping=aes(displ, hwy),method = "lm") #nothing the ggplot()

#facet_wrap
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island) #facet_wrap gives different plots according to the specified categorical


#saving plots
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)
ggsave("facet_wrap plot.png") #saves the most recently created plot


#---------------------------------- Chapter 3.Data Transformation ---------------------------------------------

install.packages("nycflights13")
library(nycflights13)
library(tidyverse)
#_________________________
View(flights) #flights data set from nycflights package
glimpse(flights)
print(flights, width = Inf)
flights
#-------------------------
#the pipe operator
flights |>
  filter(dest == "IAH") |> group_by(year, month, day) |>
  summarize(arr_delay = mean(arr_delay, na.rm = TRUE))


#################### ROWS #####################

# filter()
flights |> filter(dep_delay > 120) # filters out flights that departed more than 120 minutes
flights |> filter(month == 1 & day == 1)  ## Flights that departed on January 1st
flights |> filter(month == 1 | month == 2) #Flights that departed in January or February
jan1 <- flights |> filter(month == 1 & day == 1) #save the filtered out data frame as jan1
View(jan1)
flights |> filter(arr_delay == 120)
flights |> filter(dest == "IAH" & dest == "HOU") # flew to IAH or HOU

#arrange(), changes the order of the rows based on the value of the columns
flights |> arrange(year, month, day, dep_time) 
flights |>arrange(desc(dep_delay)) #desc() - descending order

#distinct() - finds all the unique rows in a dataset
flights |> distinct() # Removes duplicate rows, if any
flights |> distinct(origin, dest) # Finds all unique origin and destination pairs
jan2 <- flights |> distinct(origin, dest, .keep_all = TRUE)# keeps all columns to object jan2
flights |> count(origin, dest, sort = TRUE) # counts the number of occurrences


########################## COLUMNS ##############################

# mutate() - adds new columns calculated from existing ones
flights |>
  mutate(gain = dep_delay - arr_delay,
  speed = distance / air_time * 60) # adds new columns, gain and speed to the right of the data set
flights |>
  mutate(gain = dep_delay - arr_delay,speed = distance / air_time * 60,
  .before = 1) # adds the new columns to the left of the data set using .before
flights |>
  mutate(gain = dep_delay - arr_delay,speed = distance / air_time * 60,
  .after = day) # .before and .after used with variable name too not only a position
flights |>
  mutate(gain = dep_delay - arr_delay,hours = air_time / 60,
    gain_per_hour = gain / hours,.keep = "used") # .keep - keeps used columns

# select() - selects a subset of variables(columns)
flights |> select(year, month, day) # selects the variables by name
flights |> select(year:day) # gets columns between year and day (inclusive)
flights |> select(!year:day) # gets columns except those from year to day (inclusive)
flights |> select(where(is.character)) # gets all columns that are characters
flights |> select(where(is.integer)) 
flights |> select(tail_num = tailnum) # selects and re-names a variable
flights %>%  select(dep_time, dep_delay,arr_time,arr_delay,dep_delay) 

# rename() - maintains all variables and just renames
flights |> rename(tail_num = tailnum)

# relocate() -  moves variables to the front
flights |> relocate(time_hour, air_time)
flights |> relocate(year:dep_time, .after = time_hour) #gives .after time_hour
flights |> relocate(starts_with("arr"), .before = dep_time)

# The pipe ( %>% ) -  its real power arises when you want to combine multiple functions
flights |>
  filter(dest == "IAH") |> mutate(speed = distance / air_time * 60) |>
  select(year:day, dep_time, carrier, flight, speed) |>
  arrange(desc(speed))

arrange(select(mutate(filter(flights,
    dest == "IAH"),speed = distance / air_time * 60),
    year:day, dep_time, carrier, flight, speed),desc(speed)) #alternatively

flights1 <- filter(flights, dest == "IAH")
flights2 <- mutate(flights1, speed = distance / air_time * 60)
flights3 <- select(flights2, year:day, dep_time, carrier, flight,speed)
arrange(flights3, desc(speed)) # alternatively with a bunch of intermediate objects

######################## Groups ########################

# group_by() -  divide your dataset into groups
flights %>% group_by(month) # groups the data by month
View(flights)
flights |> group_by(month) |>
  summarize(delay = mean(dep_delay, na.rm = TRUE)) # gives means of delay in each month 

flights |> group_by(month) |>summarize(delay = mean(
  dep_delay, na.rm = TRUE),n = n()) # adds the count for observations in each month

# The slice_ Functions
df |> slice_head(n = 1) # Takes the first row from each group
df |> slice_tail(n = 1) # Takes the last row in each group
df |> slice_min(x, n = 1) # Takes the row with the smallest value of column x
df |> slice_max(x, n = 1) # Takes the row with the largest value of column x
df |> slice_sample(n = 1) # takes one random row, n can take on proportions

#code below finds the flights that are most delayed upon arrival at each destination
flights |>group_by(dest) |>slice_max(arr_delay, n = 1) |>
  relocate(dest) # groups by dest, takes max value from arr_delay, makes it 1st column

flights |>group_by(dest) |>slice_max(arr_delay, 
  n = 1,with_ties = FALSE) |> relocate(dest) # gives exactly one row per group

# Grouping by Multiple Variables
daily <- flights |> group_by(year, month, day)
daily
daily_flights <- daily |>summarize( n = n(), .groups = "drop") # drop - drops groups, keep - otherwise
daily_flights

# grouping using .by with summarize()
flights |>summarize(.by = c(month,origin, dest))
flights |>summarize(delay = mean(dep_delay, na.rm = TRUE),
    n = n(),.by = month) # .by also gives the means grouped by months

flights |>summarize(mean=mean(dep_delay, na.rm = TRUE),
    n = n(),.by = c(month,origin, dest)) # multiple groups

# Ungrouping
# using summarize() and ungroup()
daily |>ungroup()  # ungroups the daily dataframe

daily |>ungroup() |>summarize(avg_delay = mean(dep_delay, na.rm = TRUE),
    flights = n()) #gives a single value


# exercise
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K"))
df
df |> group_by(y,n())
df |> arrange(y)
df |> group_by(y) |>summarize(mean_x = mean(x))
df |> group_by(z) |>summarize(mean_x = mean(x))
df |> group_by(y, z) |>summarize(mean_x = mean(x))
df |> group_by(y, z) |>summarize(mean_x = mean(x), .groups = "drop")
df |> group_by(y, z) |>summarize(mean_x = mean(x))
df |> group_by(y, z) |>mutate(mean_x = mean(x))

# Aggregates and Sample Size
# sum(), mean(), count(), max(), min(), median(), sd(), var()
# summarize() can do the aggregations
install.packages("Lahman")
library(Lahman)
View(Batting)
glimpse(Batting)
batters <- Lahman::Batting |>
  group_by(playerID) |>
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  ) # mutate() alternatively for summarize()
batters
ggplot(batters,aes(n,performance))+geom_point()+geom_smooth()

batters |>filter(n > 100) |>ggplot(aes(x = n, y = performance)) +
 geom_point(alpha = 1 / 10) + geom_smooth(se = FALSE)

batters |> arrange(desc(performance))
View(batters)
view(batters)

#---------------------------- Chapter 4. Workflow: Code Style ----------------------------------

install.packages("styler")
library(styler)  # ctrl + shift + P
library(tidyverse)
library(nycflights13)
flights |> mutate(
    speed = distance / air_time,
    dep_hour = dep_time %/% 100,
    dep_minute = dep_time %% 100)

# Strive for
flights |>
  filter(!is.na(arr_delay), !is.na(tailnum)) |>
  count(dest)
# Avoid
flights|>filter(!is.na(arr_delay), !is.na(tailnum))|>count(dest)

# code structures
flights |>
  group_by(month) |>
  summarize(
    delay = mean(arr_delay, na.rm = TRUE)
  ) |>
  ggplot(aes(x = month, y = delay)) +
  geom_point() +
  geom_line()  # code structuring

flights |>
  group_by(dest) |>
  summarize(
    distance = mean(distance),
    speed = mean(distance / air_time, na.rm = TRUE)
  ) |>
  ggplot(aes(x = distance, y = speed)) +
  geom_smooth(
    method = "loess",
    span = 0.5,
    se = FALSE,
    color = "Blue",
    linewidth = 4
  ) +
  geom_point()  # code structure recommended

# examples of a pipeline command follow
flights|>
  filter(carrier=="UA",dest%in%c("IAH","HOU"),sched_dep_time>0900,sched_arr_time<2000)|> 
  group_by(flight)|>
  summarize(delay=mean(arr_delay,na.rm=TRUE),cancelled=sum(is.na(arr_delay)),n=n())|>
  filter(n>10) 

flights|>
  filter(dest=="IAH")|>
  group_by(year,month,day)|>
  summarize(n=n(),delay=mean(arr_delay,na.rm=TRUE))|>
  filter(n>10)

# styler,  ctrl+shift+P
styler:::style_selection()
# Using style transformers `styler::tidyverse_style()`
# And don’t forget about the styler package: it’s a
# great way to quickly improve the quality of poorly styled code

#____________________________ Chapter 5. Data Tidying ------------------------------------------

library(tidyverse)

# functions for pivoting data - pivot_longer() and pivot_wider

############################ pivoting data long ##########################

view(billboard) # dataset 
# pivot_longer()
billboard1 <- billboard |>
  pivot_longer(cols = starts_with("wk"),
    names_to = "week",values_to = "rank")
view(billboard1)

billboard2 <- billboard |>
  pivot_longer(cols = starts_with("wk"),names_to = "week",values_to = "rank",
    values_drop_na = TRUE) # eliminates the missing values
view(billboard2)

# values of week from character strings to numbers using parse_number within mutate()
billboard_longer <- billboard |>
  pivot_longer(cols = starts_with("wk"),names_to = "week",
    values_to = "rank",values_drop_na = TRUE) |>
  mutate(week = parse_number(week)) # extracts the first number from week variable 
view(billboard_longer)

billboard_longer |>
  ggplot(aes(x = week, y = rank, group = track)) +geom_line(alpha = 0.25) +
  scale_y_reverse()  # line graph grouped by track

# How pivoting works
df <- tribble(
  ~id, ~bp1, ~bp2,
  "A", 100, 120,
  "B", 140, 115,
  "C", 120, 125)  # create a simple dataset

df |> pivot_longer(cols = bp1:bp2,names_to = "measurement",
    values_to = "value") # make the data to be longer

# Many Variables in Column Names
view(who)
glimpse(who)

# separating out the names in a single column name
view(who2)
glimpse(who2)
who3 <- who2 |> pivot_longer(cols = !(country:year),
    names_to = c("diagnosis", "gender", "age"), names_sep = "_",
    values_to = "count") # names_sep = names_pattern for complicated scenarios
view(who3)

# Data and Variable Names in the Column Headers
view(household)
household1 <- household |> pivot_longer(
    cols = !family,names_to = c(".value", "child"),
    names_sep = "_",values_drop_na = TRUE)
view(household1)

########################### pivoting data wide ##########################

# pivot_wider() -  increasing columns and reducing rows 
view(cms_patient_experience)
glimpse(cms_patient_experience)
cms <- cms_patient_experience |> distinct(measure_cd, 
       measure_title, n=n()) # distinct gets out duplicate rows
view(cms)

cms_patient_experience |> pivot_wider(names_from = measure_cd,
    values_from = prf_rate) # widens the measure_cd giving it corresponding prf_rate value

cms_patient_experience |> pivot_wider(id_cols = starts_with("org"),
    names_from = measure_cd,values_from = prf_rate
    ) # widens column org_nm that uniquely identifies each row

# How Does pivot_wider() Work
df <- tribble(
  ~ id, ~ measurement, ~ value,
  "A", "bp1", 100,
  "B", "bp1", 140,
  "B", "bp2", 115,
  "A", "bp2", 120,
  "A", "bp3", 105) # long dataset which is to be widen

df |> pivot_wider(names_from = measurement,values_from = value)

# the process
df |> distinct(measurement) |> pull() # gets new column names
df |> select(-measurement, -value) |> distinct()
df |> select(-measurement, -value) |> distinct() |> mutate(x = NA, y = NA, z = NA)

df_wider <- df |> pivot_wider(names_from = measurement,values_from = value) # to wide form
df_wider
df

df1 <- tribble(
  ~id, ~measurement, ~value,
  "A", "bp1", 100,
  "A", "bp1", 102,
  "A", "bp2", 120,
  "B", "bp1", 140,
  "B", "bp2", 115
)

df1 |>
  group_by(id, measurement) |>
  summarize(n = n(), .groups = "drop") |>
  filter(n > 1)

#----------------------- Chapter 6. Workflow: Scripts and Projects -------------------------------

# instructs RStudio not to preserve your workspace between sessions
install.packages("usethis")
library(usethis)
usethis::use_blank_slate()^2

# saving a graph to a folder in the directory
library(tidyverse)
install.packages(hexbin)
library(hexbin)
view(diamonds)
glimpse(diamonds)
ggplot(diamonds, aes(x = carat, y = price)) + geom_hex()
ggsave("diamonds.png") # saves the graph in the directory 
write_csv(diamonds, "dataset/diamonds.csv") # exports the data frame to folder dataset in the working directory

#-------------------------------- Chapter 7. Data Import ---------------------------------------

students <- read_csv("https://pos.it/r4ds-students-csv") # imports data from the web
view(students)

write.csv(students, "dataset/students.csv") # export the data
students <- read_csv("dataset/students.csv", na = c("N/A", "")) # imports and makes R know the missing variables
view(students)
students |> rename(student_id = `Student ID`,full_name = `Full Name`) # renames the variable names with spaces

# janitor package - cleans variable names to what R prefers - alternatively
install.packages("janitor")
library(janitor)
students |> janitor::clean_names()  # renames the variables
students |> janitor::clean_names() |> mutate(meal_plan = factor(meal_plan)) # changes meal_plan to factor from character
students <- students |> janitor::clean_names() |> mutate( meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age))) # parse_number - picks numbers from characters
view(students)

#--------------- Other Arguments - read_csv() --------------
library(tidyverse)
read_csv( "a,b,c
          1,2,3
          4,5,6") # reads text strings that you’ve created and formatted like a CSV file

read_csv(
  "The first line of metadata
The second line of metadata
x,y,z
1,2,3",
  skip = 2) # helps to skip the first 2 lines

read_csv(
  "# A comment I want to skip
x,y,z
1,2,3",
  comment = "#") # skips the line beginning with #

read_csv(
  "1,2,3
4,5,6",
  col_names = FALSE) # incase data has no column names

read_csv(
  "1,2,3
4,5,6",
  col_names = c("x", "y", "z")) # alternatively names the columns

read_csv2() # reads semicolon-separated files
read_tsv() # Reads tab-delimited files
read_delim() # Reads in files with any delimiter, automatically guessing delimiter if not specified 
read_fwf() # Reads fixed-width files. You can specify fields by their widths
fwf_positions() # by their positions 
read_log() # Reads Apache-style log files
read_table() # Reads a common variation of fixed-width files where columns are separated by whitespace

read_csv("a,b\n1,2,3\n4,5,6")
read_csv("a,b,c\n1,2\n1,2,3,4")
read_csv("a,b\n\"1")
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3")

#__________ Controlling Column Types ----------

# CSV file doesn’t contain any information about the type of each variable
read_csv("
logical,numeric,date,string
TRUE,1,2021-01-15,abc
false,4.5,2021-02-15,def
T,Inf,2021-02-16,ghi
")

read_csv("
logical,numeric,date,string\nTRUE,1,2021-01-15,abc\nfalse,4.5,2021-02-15,def\n
T,Inf,2021-02-16,ghi") # alternatively

# Missing Values, Column Types, and Problems
# column types
col_logical() # reads logicals
col_double() # reads real numbers
col_integer() # reads integers
col_character() # reads strings
col_factor() # creates factors
col_date() # creates dates
col_datetime() # creates date-times
col_number() # permissive numeric parser useful for currencies
col_skip() # skips a column and not included in the result
cols_only() # reads in only the columns you specify

#------------- Reading Data from Multiple Files ---------------

sales_files <- c(
  "https://pos.it/r4ds-01-sales",
  "https://pos.it/r4ds-02-sales",
  "https://pos.it/r4ds-03-sales") # reads the data from web
read_csv(sales_files, id = "file") # combines them into a dataframe from the web, id-identifies the file the data came from

sales_downloaded <- read_csv(c("01-sales.csv","02-sales.csv","03-sales.csv")) # downloaded to the directory
view(sales_downloaded) # shows the datasets appended

sales_files <- list.files("dataset", pattern = "sales\\.csv$", full.names = TRUE)
sales_files

# writing to a file
write.csv(students, "dataset/students.csv") # variable type information is lost when you save to CSV
read_csv("dataset/students.csv") # seen when u read back the data hence all characters

write_rds(students, "students1.rds") # saves the data in .rds form
read_rds("students1.rds") # reloads the object back in the same format you stored it

# alternatively for RDS - arrow package- faster than RDS
install.packages("arrow")
library(arrow)
write_parquet(students, "students2.parquet")
read_parquet("students2.parquet")

#----------- Data Entry ----------

# tibble() works by column
tibble(x = c(1, 2, 5),y = c("h", "m", "g"),z = c(0.08, 0.83, 0.60))

# column headings start with ~ and entries are separated by commas
tribble(~x, ~y, ~z,1, "h", 0.08,2, "m", 0.83,5, "g", 0.60)

#---------------------- Chapter 8. Workflow: Getting Help ------------------------------------

# making the code reproducible, reprex package
install.packages("reprex")
library(reprex)

y <- c(1:5)
mean(y)
reprex::reprex({install.packages("reprex")
  library(reprex)
  y <- c(1:5)
 mean(y)})# gives a reproducible code-text is formatted in a special way, called Markdown

# including a dataset in  a reprex
dput(mtcars) # after you copy the out in the console and paste it in the reprex({})


#--------------------------- Part II. Visualize ---------------------------------------------

######################### Chapter 9. Layers ##############################

library(tidyverse)

#--------------- Aesthetic Mappings ------------------
mpg
view(mpg)

# scatterplot of displ and hwy while categorical variable mapped to shape or color
ggplot(mpg, aes(x = displ, y = hwy, color = class)) + geom_point() # mapped to color
ggplot(mpg, aes(x = displ, y = hwy, shape = class)) + geom_point() # mapped to shape (maxima of 6 shapes)

# alternatively though not advised
ggplot(mpg, aes(x = displ, y = hwy, size = class)) + geom_point() # mapped to size
ggplot(mpg, aes(x = displ, y = hwy, alpha = class)) + geom_point() # mapped to alpha

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color = "Blue") # makes all points blue
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(color = "Blue", shape = 14, size = 1) # more aes() on the points

#----------------- Geometric Objects -------------------
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy, shape = drv)) + geom_smooth() # different line for each drv
ggplot(mpg, aes(x = displ, y = hwy, linetype = drv)) + geom_smooth() # different line for each drv

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  geom_smooth(aes(linetype = drv)) # colors the points with  different drv lines

ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth(aes(group = drv))
ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth(aes(color = drv))
ggplot(mpg, aes(x = displ, y = hwy)) + geom_smooth(aes(group = drv, colour = drv)) # combines

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() +
  geom_point(data = mpg |> filter(class == "2seater"),color = "Red" ) +
  geom_point(data = mpg |> filter(class == "2seater"),
    shape = "circle open", size = 3, color = "Red")

ggplot(mpg, aes(x = hwy)) + geom_histogram(binwidth = 1, color = "Black", fill = "White")
ggplot(mpg, aes(x = hwy)) + geom_density(colour = "Red", fill = "Green", alpha = 0.1)
ggplot(mpg, aes(x = hwy)) + geom_boxplot(color = "Black", fill = "White")

# ggridges package for ridgeline plots,visualizing the density of a numerical variable for different levels of categorical variable
install.packages("ggridges")
library(ggridges)
ggplot(mpg, aes(x = hwy, y = drv)) + geom_density_ridges() # example

ggplot(mpg, aes(x = hwy, y = drv, fill = drv, color = drv)) +
  geom_density_ridges(alpha = 0.5, show.legend = FALSE) # example with details

ggplot(mpg, aes(displ,hwy, colour = drv)) + geom_point() + geom_smooth(se=F) # exercise

#------------------ Facets -----------------------
#  splits a plot into subplots that each display one subset of the data based on a categorical variable.
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + 
  facet_wrap(~cyl) # gives a wrap of variable cyl
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + 
  facet_grid(drv ~ cyl) # gives a grid with drv on rows and cyl on columns

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() +
  facet_grid(drv ~ cyl, scales = "free") # free allow scales adjustments
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() +
  facet_grid(drv ~ cyl, scales = "free_x") # allows free scales on rows
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() +
  facet_grid(drv ~ cyl, scales = "free_y") # allows free scales on columns

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) + facet_grid(class ~ .) # grids are row-wise
ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) + facet_grid(. ~ class) # grids are column-wise

ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  facet_wrap(~ class, ncol=3) # ncol and nrow controls number of columns and rows to appear
ggplot(mpg, aes(x = displ)) +geom_histogram() +facet_grid(drv ~ .)
ggplot(mpg, aes(x = displ)) + geom_histogram(binwidth = 0.5, color="Black", fill="White") +
  facet_grid(. ~ drv) # facet grids the histograms

#----------------- Statistical Transformations --------------------
view(diamonds)
ggplot(diamonds, aes(x = cut)) + geom_bar(color="Black",fill="White")

diamonds |> count(cut) |> ggplot(aes(x = cut, y = n)) + 
  geom_bar(stat = "identity") # overrides the default stat_count() that gives count on y-axis giving the raw values for each category

ggplot(diamonds, aes(x = cut, y = after_stat(prop), group = 1)) + geom_bar() # gives proportions

ggplot(diamonds) + stat_summary(aes(x = cut, y = depth),fun.min = min,fun.max = max,fun = median)

#-------------------- Position Adjustments ------------------------
ggplot(mpg, aes(x = drv, color = drv)) + geom_bar() # looks poor 
ggplot(mpg, aes(x = drv, fill = drv)) + geom_bar() # looks better with fill

ggplot(mpg, aes(x = drv, fill = class)) + geom_bar() # stacks the class variable within the bars of drv

# position uses "identity", "dodge", or "fill" but identity is default
ggplot(mpg, aes(x = drv, fill = class)) + geom_bar(alpha = 1/5, position = "identity")
ggplot(mpg, aes(x = drv, color = class)) + geom_bar(fill = NA, position = "identity")

ggplot(mpg, aes(x = drv, fill = class)) + geom_bar(position = "fill") # good for proportions
ggplot(mpg, aes(x = drv, fill = class)) + geom_bar(position = "dodge") # gives a bar for each fill category

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() # overplots the data
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(position = "jitter") # jitter solves overplotting

ggplot(mpg, aes(x = cty, y = hwy)) + geom_point(position = "jitter")
ggplot(mpg, aes(x = cty, y = hwy)) + geom_point()
ggplot(mpg, aes(x = cty, y = hwy)) + geom_point(position = "dodge")

ggplot(mpg, aes(x = class, y = displ)) + geom_boxplot()

#---------------------- Coordinate Systems --------------------------
# important if you’re plotting spatial data with ggplot2
install.packages("maps")
install.packages("mapproj")
library(mapproj)
library(maps)
view(nz)
nz <- map_data("nz")
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "White", color = "Black") # gives a map
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "White", color = "Black") + coord_map() # a better display
ggplot(nz, aes(x = long, y = lat, group = group)) +
  geom_polygon(fill = "White", color = "Black") + coord_quickmap() # alternatively

# Polar coordinates reveal a connection between a bar chart and a Coxcomb chart
bar <- ggplot(data = diamonds) + geom_bar(mapping = aes(x = clarity, fill = clarity),
    show.legend = FALSE,width = 1) + theme(aspect.ratio = 1)
bar + coord_flip()
bar + coord_polar()

# coord_polar() helps turn stacked bar charts to pie-charts
ggplot(mpg, aes(x = drv, fill = class)) + geom_bar() # stacked bar chart
ggplot(mpg, aes(x = drv, fill = class)) + geom_bar() + coord_polar() # pie-chart
ggplot(mpg, aes(x = drv, fill = class)) + geom_bar() + coord_polar() +
  facet_wrap(~ class) # pie-chart for every category in variable class

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point(position = "jitter") +
  geom_abline() + coord_fixed() # coord_fixed ensures a fixed aspect ratio
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + geom_point() + geom_abline() + coord_fixed()


#--------------------------- Chapter 10. Exploratory Data Analysis ----------------------------

# start our exploration by visualizing the distribution of weights (carat) of
# about 54,000 diamonds from the diamonds dataset

library(tidyverse)
view(diamonds)
ggplot(diamonds, aes(x = carat)) + geom_histogram(binwidth = 0.5) # distribution of carat

smaller <- diamonds |> filter(carat < 3) # diamonds of carat < 3
ggplot(smaller, aes(x = carat)) + geom_histogram(binwidth = 0.01) # their distribution

#----------- Unusual Values(outliers) ---------
ggplot(diamonds, aes(x = y)) + geom_histogram(binwidth = 0.5,
    fill="White", color="Black") # outliers not easily visible

# coord_cartesian() has ylim() and xlim() for zooming into the axes
ggplot(diamonds, aes(x = y)) + geom_histogram(binwidth = 0.5, fill="White", color="Black") +
  coord_cartesian(ylim = c(0, 50)) # outliers visible - zooms through the y-axis
ggplot(diamonds, aes(x = y)) + geom_histogram(binwidth = 0.5, fill="White", color="Black") +
  coord_cartesian(ylim = c(0, 50),xlim = c(0, 50)) # zooms both axes
ggplot(diamonds, aes(x = y)) + geom_histogram( fill="White", color="Black") +
  coord_cartesian(ylim = c(0, 50),xlim = c(0, 50)) # without the binwidth set

unusual <- diamonds |> filter(y < 3 | y > 20) |> 
  select(price, x, y, z)|> arrange(y) # filters out the outliers in y
unusual

# the if_else() function to replace unusual values with NA
diamonds2 <- diamonds |> mutate(y = if_else(y < 3 | y > 20, NA, y)) 
ggplot(diamonds2, aes(x = x, y = y)) + geom_point() # automatically removes missing values and warns 
ggplot(diamonds2, aes(x = x, y = y)) + geom_point(na.rm = TRUE) # automatically removes missing values and doesn't warn 

#-------------- Covariation --------------
# behavior between 2 variables - best way to spot covariation is to visualize the relationship

############ A Categorical and a Numerical Variable ############
# using geom_freqpoly() - not easy to interpret
ggplot(diamonds, aes(x = price)) + geom_freqpoly(aes(color = cut), 
  binwidth = 500, linewidth = 0.75,alpha = 5)
ggplot(diamonds, aes(x = price, y = after_stat(density))) + geom_freqpoly(aes(color = cut), 
  binwidth = 500, linewidth = 0.75) # displays density instead of count on y-axis for better comparison

# simpler plot for exploring this relationship is using side-by-side boxplots
ggplot(diamonds, aes(x = cut, y = price)) + geom_boxplot()

View(mpg) # to know how highway mileage varies across classes
ggplot(mpg, aes(x = class, y = hwy)) + geom_boxplot()

# fct_reorder gives a more informative display as it orders the categorical variables
ggplot(mpg, aes(x = fct_reorder(class, hwy, median), y = hwy)) + geom_boxplot() # vertical
ggplot(mpg, aes(x = hwy, y = fct_reorder(class, hwy, median))) + geom_boxplot() # horizontal
ggplot(mpg, aes(x = fct_reorder(class, hwy, median), y = hwy)) + geom_boxplot() + coord_flip() # alternatively to horizontal
ggplot(diamonds, aes(x = fct_reorder(cut,price,median), y = price)) + geom_boxplot()

install.packages("lvplot")
library(lvplot)
ggplot(diamonds, aes(x = cut, y = price)) + geom_lv()
ggplot(diamonds, aes(x = cut, y = price)) + geom_violin()

install.packages("ggbeeswarm")
library(ggbeeswarm)
ggplot(diamonds, aes(x = cut, y = price)) + geom_jitter()
ggplot(mpg, aes(x = class, y = hwy)) + geom_jitter()

############# Two Categorical Variables ##############
# relies on geom_count()
ggplot(diamonds, aes(x = cut, y = color)) + geom_count() # size of circle gives observations at each combination
diamonds |> count(color, cut) # alternatively
diamonds |> count(color, cut) |> ggplot(aes(x = color, y = cut)) + geom_tile(aes(fill = n))

############# Two Numerical Variables ###############
ggplot(smaller, aes(x = carat, y = price)) + geom_point() + geom_smooth()
ggplot(smaller, aes(x = carat, y = price)) + geom_point(alpha = 1 / 100) # for transparency in the points
ggplot(smaller, aes(x = carat, y = price)) + geom_bin2d()
ggplot(smaller, aes(x = carat, y = price)) + geom_hex()
ggplot(smaller, aes(x = carat, y = price)) +geom_boxplot(aes(group = cut_width(
  carat, 0.1))) # bins one continuous variable to acts like  categorical
ggplot(smaller, aes(x = carat, y = price)) +geom_boxplot(aes(group = cut_width(price,
  0.1, varwidth = TRUE))) # makes the width of the boxplot proportional to the number of points

ggplot(diamonds, aes(x=cut,y=price)) + geom_boxplot() + facet_wrap(~ color)

diamonds |> filter(x >= 4) |> ggplot(aes(x = x, y = y)) + geom_point() + 
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11)) # easier display to see outliers

############### Patterns and Models #################
install.packages("tidymodels")
library(tidymodels)

diamonds <- diamonds |> mutate(log_price = log(price), log_carat = log(carat))
diamonds_fit <- linear_reg() |> fit(log_price ~ log_carat, data = diamonds)
summary(diamonds_fit)
diamonds_fit
diamonds_aug <- augment(diamonds_fit, new_data = diamonds) |> mutate(.resid = exp(.resid))
diamonds_aug
glimpse(diamonds_aug)
ggplot(diamonds_aug, aes(x = carat, y = .resid)) + geom_point()

ggplot(diamonds_aug, aes(x = cut, y = .resid)) + geom_boxplot()


#--------------------------------- Chapter 11. Communication -----------------------------------

install.packages("ggrepel")
install.packages("patchwork")
library(tidyverse)
library(scales)
library(ggrepel)
library(patchwork)

#----------- Labels ----------
mpg
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) + geom_smooth(se = FALSE) +
  labs(x = "Engine displacement (L)",y = "Highway fuel economy (mpg)",
  color = "Car type", title = "Fuel efficiency generally decreases with engine size",
  subtitle = "Two seaters (sports cars) are an exception because of their light weight",
  caption = "Data from fueleconomy.gov") + theme(legend.position = "bottom") # well labelled plot

# mathematical equations instead of text strings - quote() function
df <- tibble(x = 1:10, y = cumsum(x^2)) # simple dataframe
ggplot(df, aes(x, y)) + geom_point() +
  labs(x = quote(x[i]), y= quote(sum(x[i] ^ 2, i == 1, n))) # plot with maths equations on axes

#----------- Annotations ----------
# labeling major components of your plot - geom_text()
label_info <- mpg |> group_by(drv) |> arrange(desc(displ)) |> slice_head(n = 1) |>
  mutate(drive_type = case_when(
      drv == "f" ~ "front-wheel drive",
      drv == "r" ~ "rear-wheel drive",
      drv == "4" ~ "4-wheel drive")) |>
  select(displ, hwy, drv, drive_type)
label_info # object to be used in the plot

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) + geom_text(data = label_info,
  aes(x = displ, y = hwy, label = drive_type),
  fontface = "bold", size = 5, hjust = "right", vjust = "bottom") +
  theme(legend.position = "none") # new data frame used to directly label the three groups 

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point(alpha = 0.3) +
  geom_smooth(se = FALSE) + geom_label_repel(data = label_info,
    aes(x = displ, y = hwy, label = drive_type),fontface = "bold", 
    size = 5, nudge_y = 2) # geom_label_repel adjusts labels so that they don’t overlap

potential_outliers <- mpg |> filter(hwy > 40 | (hwy > 20 & displ > 5)) # object for plot below

# geom_text_repel() highlights certain points on a plot   
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() +
  geom_text_repel(data = potential_outliers, aes(label = model)) +
  geom_point(data = potential_outliers, color = "Red") +
  geom_point(data = potential_outliers,color = "Red", size = 3, shape = "circle open")

# annotate() is useful for adding a few annotation elements to a plot
trend_text <- "Larger engine sizes tend to\nhave lower fuel economy." |> str_wrap(width = 30)
trend_text
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() +
  annotate(geom = "label", x = 3.5, y = 38,label = trend_text,hjust = "left", color = "Red") +
  annotate(geom = "segment",x = 3, y = 35, xend = 5, yend = 25, color = "Red",
    arrow = arrow(type = "closed"))

#------------ Scales -------------
ggplot(mpg, aes(x = displ, y = hwy, color  =class)) +geom_point() # default scales

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  scale_x_continuous() + scale_y_continuous() + scale_color_discrete() # for scale adjustments

######### Axis Ticks and Legend Keys ##########
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5)) # adjusts y-axis scale
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  scale_y_continuous(breaks = seq(15, 40, by = 5)) +
  scale_x_continuous(breaks = seq(1, 10, by = 1))

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  scale_x_continuous(labels = NULL) + scale_y_continuous(labels = NULL) +
  scale_color_discrete(labels = c("4" = "4-wheel", "f" = "front", "r" = "rear"))

# we can add currency and percentages with scale 
ggplot(diamonds, aes(x = price, y = cut)) + geom_boxplot(alpha = 0.05) +
  scale_x_continuous(labels = label_dollar()) # gives dollar signs on x-axis
ggplot(diamonds, aes(x = price, y = cut)) + geom_boxplot(alpha = 0.05) +
  scale_x_continuous(labels = label_dollar(scale = 1/1000, suffix = "K"),
    breaks = seq(1000, 19000, by = 6000)) # alternatively 

ggplot(diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "fill") +
  scale_y_continuous(name = "Percentage", labels = label_percent()) # percentage scale on y-axis

# Another use of breaks is when you have relatively few data points and want to -  
# highlight exactly where the observations occur
view(presidential)
presidential |> mutate(id = 33 + row_number()) |> ggplot(aes(x = start, y = id)) +
  geom_point() + geom_segment(aes(xend = end, yend = id)) +
  scale_x_date(name = NULL, breaks = presidential$start, date_labels ="'%y")

########## Legend Layout ###########
library(ggplot2)
library(tidyverse)
base <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class))
base + theme(legend.position = "right") # the default
base + theme(legend.position = "left")
base + theme(legend.position = "top") + guides(col = guide_legend(nrow = 2))
base + theme(legend.position = "bottom") + guides(col = guide_legend(nrow = 3)) + 
 theme_bw() # guides() controls the appearance of the legend

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme(legend.position = "bottom") +
  guides(color = guide_legend(nrow = 2, override.aes = list(size = 12)))

############ Replacing a Scale #########
ggplot(diamonds, aes(x = carat, y = price)) + geom_bin2d() # relationship
ggplot(diamonds, aes(x = log10(carat), y = log10(price))) + geom_bin2d() # relationship seen easily when logged

ggplot(diamonds, aes(x = carat, y = price)) + geom_bin2d() + scale_x_log10() +
  scale_y_log10() # transformations done by the scale

# The ColorBrewer scales
install.packages("RColorBrewer")
library(RColorBrewer)
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv))
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv, position = "jitter")) +
  scale_color_brewer(palette = "Set1")  # gives better color display

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv, shape = drv)) +
  scale_color_brewer(palette = "Set1")

presidential |> mutate(id = 33 + row_number()) |> ggplot(aes(x = start, y = id, color = party)) +
  geom_point() + geom_segment(aes(xend = end, yend = id)) +
  scale_color_manual(values = c(Republican = "Red", Democratic ="Blue"))

# viridis color scales
# These scales are available as continuous (c), discrete (d), and binned (b) palettes
df <- tibble( x = rnorm(10000), y = rnorm(10000)) # generates random numbers from a normal distribution

ggplot(df, aes(x, y)) + geom_hex() + coord_fixed() + 
  labs(title = "Default, continuous", x = NULL, y = NULL)
ggplot(df, aes(x, y)) + geom_hex() + coord_fixed() + scale_fill_viridis_c() +
  labs(title = "Viridis, continuous", x = NULL, y = NULL)
ggplot(df, aes(x, y)) +  geom_hex() + coord_fixed() + scale_fill_viridis_b() +
  labs(title = "Viridis, binned", x = NULL, y = NULL)

ggplot(mpg, aes(x = displ, y = hwy)) + geom_hex() +  scale_fill_viridis_c() +
  labs(title = "Default, continuous", x = NULL, y = NULL) # for continuous

############# Zooming ##############
# to zoom in on a region of the plot, it’s generally best to use coord_cartesian()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth()
mpg |> filter(displ >= 5 & displ <= 6 & hwy >= 10 & hwy <= 25) |>
  ggplot(aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth() # zoomed in

ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth() +
  scale_x_continuous(limits = c(5, 6)) + scale_y_continuous(limits = c(10, 25)) # zoom in
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) +
  geom_smooth() + coord_cartesian(xlim = c(5, 6), ylim = c(10, 25)) # better zoom in

# extracting two classes of cars and plot them separately, it’s -
# difficult to compare the plots coz of different scale ranges 
suv <- mpg |> filter(class == "suv")
compact <- mpg |> filter(class == "compact")
midsize <- mpg |> filter(class == "midsize")

ggplot(suv, aes(x = displ, y = hwy, color = drv)) + geom_point() # plots suv only
ggplot(compact, aes(x = displ, y = hwy, color = drv)) + geom_point() # plots compacts only
ggplot(midsize, aes(displ, hwy, color = drv)) + geom_point() # plots midsize only

# to overcome this problem is to share scales across multiple plots,-
# trimming the scales with the limits of the full data
x_scale <- scale_x_continuous(limits = range(mpg$displ))
y_scale <- scale_y_continuous(limits = range(mpg$hwy))
col_scale <- scale_color_discrete(limits = unique(mpg$drv))

ggplot(suv, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  x_scale + y_scale + col_scale # zooms out points of suv - better zooms  
ggplot(compact, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  x_scale + y_scale + col_scale # zooms out points of compact
ggplot(midsize, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  x_scale + y_scale + col_scale # zooms out points of midsize
# alternatively faceting can be used for the above

############ Themes ##############
# customizes the non-data elements of the plot-with theme_gray() as the default
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_bw() # good 
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_classic() # better
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_dark()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_light()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_linedraw()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_minimal()
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_void() # no scale
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = class)) +
  geom_smooth(se = FALSE) + theme_gray() # default

ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() +
  labs(title = "Larger engine sizes tend to have lower fuel economy",
    caption = "Source: https://fueleconomy.gov.") +
  theme(legend.position = c(0.6, 0.7),legend.direction = "horizontal",
    legend.box.background = element_rect(color = "Black"),
    plot.title = element_text(face = "bold"), plot.title.position = "plot",
    plot.caption.position = "plot", plot.caption = element_text(hjust = 0)) 

############### Layout #############
library( patchwork)
p1 <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + labs(title = "Plot 1")
p2 <- ggplot(mpg, aes(x = drv, y = hwy)) + geom_boxplot() + labs(title = "Plot 2")
p1 + p2
p3 <- ggplot(mpg, aes(x = cty, y = hwy)) + geom_point() + labs(title = "Plot 3")
(p1 | p3) / p2

p1 <- ggplot(mpg, aes(x = drv, y = cty, color = drv)) +geom_boxplot(show.legend = FALSE) +
  labs(title = "Plot 1")
p2 <- ggplot(mpg, aes(x = drv, y = hwy, color = drv)) + geom_boxplot(show.legend = FALSE) +
  labs(title = "Plot 2")
p3 <- ggplot(mpg, aes(x = cty, color = drv, fill = drv)) + geom_density(alpha = 0.5) +
  labs(title = "Plot 3")
p4 <- ggplot(mpg, aes(x = hwy, color = drv, fill = drv)) + geom_density(alpha = 0.5) +
  labs(title = "Plot 4")
p5 <- ggplot(mpg, aes(x = cty, y = hwy, color = drv)) + geom_point(show.legend = FALSE) +
  facet_wrap(~ drv) + labs(title = "Plot 5")
(guide_area() / (p1 + p2) / (p3 + p4) / p5) +
  plot_annotation(
  title = "City and highway mileage for cars with different drivetrains",
  caption = "Source: https://fueleconomy.gov." ) +
  plot_layout(guides = "collect",heights = c(1, 3, 2, 4)) & theme(legend.position = "top")

p1 <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + labs(title = "Plot 1") + theme_bw()
p2 <- ggplot(mpg, aes(x = drv, y = hwy)) + geom_boxplot() + labs(title = "Plot 2") + theme_bw()
p3 <- ggplot(mpg, aes(x = cty, y = hwy)) + geom_point() + labs(title = "Plot 3") + theme_bw()
(p1 | p2) / p3


#------------------------------ Part III. Transform ------------------------------------------

#-------------------- Chapter 12. Logical Vectors--------------------------------------------
library(tidyverse)
library(nycflights13)

#------------ Comparisons ----------
flights |> filter(dep_time > 600 & dep_time < 2000 & abs(arr_delay) < 20) # filters out the arguments
flights |> mutate(daytime = dep_time > 600 & dep_time < 2000,
    approx_ontime = abs(arr_delay) < 20) # creates columns
flights |> mutate(daytime = dep_time > 600 & dep_time < 2000,approx_ontime = abs(
  arr_delay) < 20,) |> filter(daytime & approx_ontime) # filters out rows with the arguments

#----------- Missing Values ---------
flights |> filter(is.na(dep_time)) |> count() # finds all the rows with a missing dep_time
flights |> filter(!is.na(dep_time))|> count() # finds all the rows not missing dep_time and returns T or F
flights |> filter(month == 1, day == 1) |> arrange(dep_time)
flights |> filter(month == 1, day == 1) |>
  arrange(desc(is.na(dep_time)), dep_time) # arranges dep_time in descending order with NA

flights |> filter(!is.na(dep_delay) & is.na( arr_delay))|> count()
flights |> filter(!is.na(arr_time |sched_arr_time) & is.na( arr_delay)) |> count()
flights |> filter(!is.na(arr_time) & !is.na(sched_arr_time) & is.na( arr_delay)) |> count()

#----------- Order of Operations --------
flights |> filter(month == 11 | month == 12) # filters out months 11 and 12
flights |> filter(month %in% c(11, 12)) # alternatively
flights |> filter(month == 11 & month == 12) # not viable
flights |> filter(month == 11 | 12) # no change
flights |> filter(dep_time %in% c(NA, 0800)) # checks for NA and 0800 from dep_time using %n% operator

# Logical Summaries == alternatively | = any() and & = all(), return TRUE and FALSE
flights |>group_by(year, month, day) |>summarize(all_delayed = all(dep_delay <= 60,
  na.rm = TRUE),any_long_delay = any(arr_delay >= 300, na.rm = TRUE),
    .groups = "drop")

# Numeric Summaries of Logical Vectors
flights |> group_by(year, month, day) |> summarize(
  all_delayed = mean(dep_delay <= 60, na.rm = TRUE),
  any_long_delay = sum(arr_delay >= 300, na.rm = TRUE),
  .groups = "drop") # sum(x) gives number of TRUEs and mean(x) gives proportion of TRUEs

df13 <- flights |> group_by(year, month, day) |> summarize(
  all_delayed = mean(is.na(dep_delay <= 60)),
  any_long_delay = sum(is.na(arr_delay >= 300)),
  .groups = "drop") 
view(df13)

# Logical Subsetting
df12 <- flights |> filter(arr_delay > 0) |> group_by(year, month, day) |>
  summarize(behind = mean(arr_delay),n = n(),.groups = "drop")
view(df12)

flights |>group_by(year, month, day) |>
  summarize(behind = mean(arr_delay[arr_delay > 0], na.rm = TRUE),
    ahead = mean(arr_delay[arr_delay < 0], na.rm = TRUE),
    n = n(),.groups = "drop")

#------------ Conditional Transformations ---------
# if_else()
x <- c(-3:3, NA)
if_else(x > 0, "+ve", "-ve") # but skips zero
if_else(x == 0, "0", if_else(x < 0, "-ve", "+ve"),"???")

x1 <- c(NA, 1, 2, NA)
y1 <- c(3, NA, 4, 6)
if_else(is.na(x1), y1, x1)

# case_when()
x <- c(-3:3, NA)
case_when( x == 0 ~ "0", x < 0 ~ "-ve", x > 0 ~ "+ve", is.na(x) ~ "???")
case_when( x < 0 ~ "-ve", x > 0 ~ "+ve") # if no case matches, NA is put
case_when(x < 0 ~ "-ve",x > 0 ~ "+ve",TRUE ~ "???")

flights |> mutate(status = case_when(is.na(arr_delay) ~ "cancelled",arr_delay < -30 ~ "very early",
      arr_delay < -15 ~ "early",abs(arr_delay) <= 15 ~ "on time",arr_delay < 60 ~ "late",
      arr_delay < Inf ~ "very late",), .keep = "used" )

x <- c(0:20)
if_else(x %% 2 == 0,"even","odd")


#----------------------------- Chapter 13. Numbers --------------------------------------------

library(tidyverse)
library(nycflights13)

#----------- Making Numbers --------
# parse_double() when numbers have been written as strings
x <- c("1.2", "5.6", "1e3")
parse_double(x)

# parse_number() when the string contains non-numeric text that you want to ignore.
x <- c("$1,234", "USD 3,513", "59%")

parse_number(x)

#---------- Counts -------------
flights |> count(dest)
flights |> count(dest, sort = TRUE) |> View() # starts with most values
flights |> count(dest, sort = TRUE) |> print(n = Inf) # prints all the values

flights |> group_by(dest) |> summarize(n = n(),
    delay = mean(arr_delay, na.rm = TRUE)) |> print(n = Inf) 

flights |> group_by(dest) |> summarize(carriers = n_distinct(carrier)) |>
  arrange(desc(carriers)) # destinations served by most carriers

flights |> group_by(tailnum) |> summarize(miles = sum(distance)) # number of mile each plane flew
flights |> count(tailnum, wt = distance) # alternatively
flights |> group_by(dest) |> summarize(n_cancelled = sum(is.na(dep_time))) |>
  arrange(desc(n_cancelled)) |> print(n=Inf)# counts all missing values in each group of dest and gives them in descending order 

flights |> count(is.na(dep_time)) # counts the missing values in dep_time

#------------ Minimum and Maximum -------
# picking maxi and min values in rows of selected values - pmax() and pmin()
# different from the summary functions min() and max()
df <- tribble( ~x, ~y,1, 3, 5, 2, 7, NA,)
df |> mutate(min = pmin(x, y, na.rm = TRUE),max = pmax(x, y, na.rm = TRUE))
df |> mutate( min = min(x, y, na.rm = TRUE), max = max(x, y, na.rm = TRUE))

#----------- Modular Arithmetic --------
# %/% - gives whole number and %% - gives remainders
1:10 %/% 3
1:10 %% 3
flights |> mutate(hour = sched_dep_time %/% 100, minute = sched_dep_time %% 100,
    .keep = "used") 

flights |> group_by(hour = sched_dep_time %/% 100) |>
  summarize(prop_cancelled = mean(is.na(dep_time)), n = n()) |>
  filter(hour > 1) |> ggplot(aes(x = hour, y = prop_cancelled)) +
  geom_line(color = "Red") + geom_point(aes(size = n), color = "Blue") + theme_bw()

#----------- Cutting Numbers into Ranges ----------- 
x <- c(1, 2, 5, 10, 15, 20)
cut(x, breaks = c(0, 5, 10, 15, 20))
cut(x, breaks = c(0, 5, 10, 100)) # breaks can take on any ranges
cut(x,breaks = c(0, 5, 10, 15, 20),labels = c("sm", "md", "lg", "xl")) # giving breaks labels

y <- c(NA, -10, 5, 10, 30)
cut(y, breaks = c(0, 5, 10, 15, 20)) # values outside the range are given NA

#----------- Cumulative and Rolling Aggregates ---------
cumsum()
cummean()
cumprod()
cummin()
cummax()
x <- 1:10
cumsum(x)

##################### General Transformations ######################

#--------------- Ranks ----------
x <- c(1, 2, 2, 3, 4, NA)
min_rank(x)
min_rank(desc(x))

df <- tibble(x = x)
df |> mutate( row_number = row_number(x), dense_rank = dense_rank(x),
    percent_rank = percent_rank(x), cume_dist = cume_dist(x))

# row_number()
df <- tibble(id = 1:10)
df |> mutate( row0 = row_number() - 1, three_groups = row0 %% 3,
              three_in_each_group = row0 %/% 3)

#----------- Offsets ----------
x <- c(2, 5, 11, 11, 19, 35)
lag(x)
lag(x, n = 2) # gives 2 lags
lead(x) # lags from the bottom
lead(x, n = 3)
x - lag(x) # gives the difference btwn current and previous value
x == lag(x) # tells you when the current value changes

#----------- Consecutive Identifiers -------------
#  starting a new group every time some event occurs
events <- tibble(time = c(0, 1, 2, 3, 5, 10, 12, 15, 17, 19, 20, 27, 28, 30))
events <- events |> mutate(diff = time - lag(time, default = first(time)),
    has_gap = diff >= 5)
events
events |> mutate(group = cumsum(has_gap))

# consecutive_id() - starts new group every time one of its arguments changes
df <- tibble(
  x = c("a", "a", "a", "b", "c", "c", "d", "e", "a", "a", "b", "b"),
  y = c(1, 2, 3, 2, 4, 1, 3, 9, 4, 8, 10, 199))
df
df |> group_by(id = consecutive_id(x)) # gives consecutive ids to the values
df |> group_by(id = consecutive_id(x)) |> slice_head(n = 1) # slices off the first row of each repeating row

flights |> group_by(dest) |> filter(row_number() < 4) |> view()
flights |> group_by(dest) |> filter(row_number(dep_delay) < 4) |> view()

flights |> mutate(hour = dep_time %/% 100) |> group_by(year, month, day, hour) |>
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE),n = n(),
    .groups = "drop") |>filter(n > 5)

#------------- Numeric Summaries ---------
# counts, means, and sums
# center - mean(symmetric distributions) and median(skewed distributions) 
flights |> group_by(year, month, day) |> summarize(mean = mean(dep_delay, na.rm = TRUE),
  median = median(dep_delay, na.rm = TRUE),n = n(),.groups = "drop" ) |>
  ggplot(aes(x = mean, y = median)) +
  geom_abline(slope = 1, intercept = 0, color = "Blue", linewidth =2) +
  geom_point()

# Minimum, Maximum, and Quantiles
flights |> group_by(year, month, day) |> summarize( max = max(dep_delay, na.rm = TRUE),
    q95 = quantile(dep_delay, 0.95, na.rm = TRUE),.groups = "drop")

# Spread - not so interested in where the bulk of the data lies, but in how it is spread out
flights |> group_by(origin, dest) |>
  summarize( distance_sd = IQR(distance), n = n(),.groups = "drop") |>
  filter(distance_sd > 0)

# Distributions
ggplot(flights, aes(x=dep_delay)) + geom_histogram(color="Black",fill="White") # not visible well
library(scales)
ggplot(flights, aes(x=dep_delay)) + geom_histogram(color="Black",fill="White") + 
  scale_x_continuous(limits = c(-20, 100)) # zooms in the distribution

# distributions for subgroups
flights |> filter(dep_delay < 120) |>
  ggplot(aes(x = dep_delay, group = interaction(day, month))) +
  geom_freqpoly(binwidth = 5, alpha = 1/5)

# Positions -  extracting a value at a specific position:first(x), last(x), and nth(x, n)
flights |> group_by(year, month, day) |> summarize(first_dep = first(dep_time, na_rm = TRUE),
    fifth_dep = nth(dep_time, 5, na_rm = TRUE),last_dep = last(dep_time, na_rm = TRUE)) |>
  print(n=Inf)

flights |> group_by(year, month, day) |> mutate(r = min_rank(sched_dep_time)) |>
  filter(r %in% c(1, max(r))) |> relocate(r)


#------------------------------------ Chapter 14. Strings -----------------------------------

library(tidyverse)
install.packages("babynames")
library(babynames)

string1 <- "This is a string, 'love'"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'
string1
string2

#--------- Escapes --------
double_quote <- "\"" 
single_quote <- '\''
backslash <- "\\"
x <- c(single_quote, double_quote, backslash)
x
str_view(string1)

# To write - He said "That's amazing!", we need (\")
s <- "He said \"That's amazing!\""
s
str_view(s) # gives the exact string

# Raw Strings - writing some thing like - \a\b\c\d
f <- r"[\a\b\c\d]"
f
str_view(f) # gives the exact string  

p <- r"[\\\\\\]"
str_view(p)

#---------- Creating Many Strings from Data ----------
# str_c() -  with mutate()
str_c("x", "y") # combines x to y to give xy
str_c("x", "y", "z")
str_c("Hello ", c("John", "Susan"))
str_c("The price of ", "food ", "is", " price")

paste("x", "y", "z") # adds space
paste0("x", "y", "z") # doesn't add space
paste("Hello ", c("John", "Susan")) # alternatively with paste()
paste0("Hello ", c("John", "Susan"))
paste0(letters[1:2], letters[1:3])

df <- tibble(name = c("Flora", "David", "Terra", NA))
df |> mutate(greeting = str_c("Hi ", name, "!"))

# coalesce() to replace them
df |> mutate(greeting1 = str_c("Hi ", coalesce(name, "you"), "!"),
    greeting2 = coalesce(str_c("Hi ", name, "!"), "Hi!"))

# alternatively - str_glue()
df |> mutate(greeting = str_glue("Hi {name}!"))

# str_flatten() - with summarize()
str_flatten(c("x", "y", "z"))
str_flatten(c("x", "y", "z"), ", ")
str_flatten(c("x", "y", "z"), ", ", last = ", and ")

df <- tribble(
  ~ name, ~ fruit,
  "Carmen", "banana",
  "Carmen", "apple",
  "Marvin", "nectarine",
  "Terence", "cantaloupe",
  "Terence", "papaya",
  "Terence", "mandarin")
df |> group_by(name) |> summarize(fruits = str_flatten(fruit, ", "))

#------------ Extracting Data from Strings ----------
# Separating into Rows - separate_longer_delim() 
df1 <- tibble(x = c("a,b,c", "d,e", "f"))
df1 |> separate_longer_delim(x, delim = ",")

df2 <- tibble(x = c("1211", "131", "21"))
df2 |> separate_longer_position(x, width = 1) # to be separated by position 1

# Separating into Columns - separate_wider_delim()
df3 <- tibble(x = c("a10.1.2022", "b10.2.2011", "e15.1.2015"))
df3 |> separate_wider_delim( x, delim = ".", names = c("code", "edition", "year")) |> 
  mutate(number = parse_number(code))
df3 |> separate_wider_delim(x,delim = ".",names = c("code", NA, "year"))

df4 <- tibble(x = c("202215TX", "202122LA", "202325CA"))
df4 |> separate_wider_position( x, widths = c(year = 4, age = 2,
  state = 2)) # variations in positions

#-------- Diagnosing Widening Problems ---------
# having fewer pieces
df <- tibble(x = c("1-1-1", "1-1-2", "1-3", "1-3-2", "1"))
df |> separate_wider_delim( x, delim = "-",names = c("x", "y", "z")) # too few elements
debug <- df |>
  separate_wider_delim(x,delim = "-",names = c("x", "y", "z"),too_few = "debug") # debugs
debug
df |> separate_wider_delim( x, delim = "-", names = c("x", "y", "z"), 
      too_few = "align_start") # align_start helps you to fill NA in the few lines
df |> separate_wider_delim( x, delim = "-", names = c("x", "y", "z"), 
      too_few = "align_end") # align_end helps to separate starting with "z"

# have too many pieces
df <- tibble(x = c("1-1-1", "1-1-2", "1-3-5-6", "1-3-2", "1-3-5-7-9"))
df |> separate_wider_delim(x,delim = "-",names = c("x", "y", "z")) # warning-too many
debug <- df |> separate_wider_delim(x, delim = "-", names = c("x", "y", "z"),
    too_many = "debug") # debugged
debug
df |> separate_wider_delim( x, delim = "-", names = c("x", "y", "z"),
    too_many = "drop") # drops the remainders
df |> separate_wider_delim(x,delim = "-",names = c("x", "y", "z"),
    too_many = "merge") # merges the remainders

df |> separate_wider_delim(x,delim = "-",names = c("x", "y", "z", "v", "h"),
    too_few = "align_start") # coded as too many

#---------- Letters ---------
str_length(c("a", "R for data science", NA)) # gives number of strings

babynames
view(babynames)
babynames |> str_length()
babynames |> count(length = str_length(name))
babynames |> count(length = str_length(name), wt = n)
babynames |> filter(str_length(name) == 15) |> count(name, wt = n, sort = TRUE)

# Subsetting - str_sub(string, start, end)
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)

babynames |> mutate(first = str_sub(name, 1, 1),last = str_sub(name, -1, -1)) 

#---------- Non-English Text --------   
library(tidyverse)
# Encoding - charToRaw()
charToRaw("Hadley")
charToRaw("kanakulya christopher")
charToRaw("ssetumba musa tamale")
charToRaw("kasangojordanpenn")

#--------------------
x1 <- "text\nEl Ni\xf1o was particularly bad this year"
read_csv(x1)
read_csv(x1, locale = locale(encoding = "Latin1"))
x2 <- "text\n\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
read_csv(x2)
read_csv(x2, locale = locale(encoding = "Shift-JIS"))
#---------------------

# Letter Variations
u <- c("\u00fc", "u\u0308")
str_view(u)
str_length(u)
str_sub(u, 1, 1)
str_to_upper(c("i", "ı")) # upper case
str_to_upper(c("i", "ı"), locale = "tr")

str_sort(c("a", "c", "ch", "h", "z"))
str_sort(c("a", "c", "ch", "h", "z"), locale = "cs")


#-------------------------- Chapter 15. Regular Expressions(regex) -------------------------------------

library(tidyverse)
library(babynames)
view(babynames)

#---------- Pattern Basics --------
view(fruit)
str_view(fruit, "berry") # views the fruits with the word berry in it
str_view(babynames$name, "[Mary]") # couldn't converge
str_view(c("a", "ab", "ae", "bd", "ea", "eab"), "a.") # give a followed by one other character
str_view(fruit, "a...e") # gives a, 3 characters in btwn and then with e

str_view(c("a", "ab", "abb"), "ab?") # ab? matches an "a", optionally followed by a "b"
str_view(c("a", "ab", "abb"), "ab+") # ab+ matches an "a", followed by at least one "b".
str_view(c("a", "ab", "abb"), "ab*") # # ab* matches an "a", followed by any number of "b"s.

# Character classes are defined by [] 
view(words)
str_view(words, "[aeiou]x[aeiou]") # matches anything with “a”, “e”, “i”, "0" or "u”
str_view(words, "[^aeiou]y[^aeiou]") # matches anything except “a”, “e”, “i”, "0" or "u”

# using alternation, |, to pick between one or more alternative patterns
str_view(fruit, "apple|melon|nut")
str_view(fruit, "aa|ee|ii|oo|uu")

mary <- babynames$name |>  str_view( "Mary") # returns those with Mary on them
mary
view(mary)

#--------- Key Functions -------
############ Detect Matches ############
str_detect(c("a", "b", "c"), "[aeiou]") # returns a logical vector
babynames |> filter(str_detect(name, "x")) |> count(name, wt = n, sort = TRUE)
babynames |> group_by(year) |> summarize(prop_x = mean(str_detect(name, "x"))) |>
  ggplot(aes(x = year, y = prop_x)) + geom_line()

cut <- diamonds$cut |>  str_detect( "Premium")
cut
#  str_subset() returns a character vector containing only the strings that match.
str_subset(c("a", "e", "c"), "[aeiou]")
str_subset(fruit, "berry")
cut <- diamonds$cut |>  str_subset( "Premium") # returns a logical vector
head(cut)

# str_which() returns an integer vector giving the positions of the strings that match
str_which(c("a", "n", "e"), "[aeiou]")
cut <- diamonds$cut |>  str_which( "Premium") # gives position of premium
cut

############ Count Matches #############
x <- c("apple", "banana", "pear")
str_count(x, "p")

str_count("abababa", "aba") # returns 2
str_view("abababa", "aba")

# use str_count() with mutate() -  counts the number of vowels and consonants in each name
babynames |> count(name) |>mutate( vowels = str_count(name, "[aeiou]"),
    consonants = str_count(name, "[^aeiou]")) # ignores upper case letters
babynames |> count(name) |> mutate( name = str_to_lower(name), vowels = str_count(name, "[aeiou]"),
    consonants = str_count(name, "[^aeiou]")) # solved
babynames |> count(name) |>mutate( vowels = str_count(name, "[aeiouAEIOU]"),
    consonants = str_count(name, "[^aeiouAEIOU]")) # alternatively
babynames |> count(name) |>mutate( vowels = str_count(name, regex("[aeiou]", ignore_case = TRUE) ),
    consonants = str_count(name, regex("[^aeiou]", ignore_case = TRUE))) # alternatively

############# Replace Values #################
# - these functions are naturally paired with mutate()
x <- c("apple", "pear", "banana")
str_replace_all(x, "[aeiou]", "-") # replaces the letters in the box brackets with "-"
str_replace(x, "[aeiou]", "-") # replaces the first letter encountered in each word

a <- c(r"[\a\b\c\d]")
str_replace_all(a, "[a]", "-")

x <- c("apple", "pear", "banana")
str_remove_all(x, "[aeiou]") # removes the letters in the box brackets
str_remove(x, "[aeiou]") # removes the first letter encountered in each word

############## Extract Variables ############
# extracts data out of one column into one or more new columns
# separate_wider_regex(), separate_wider_position(), separate_wider_delim()
df <- tribble( ~str, "<Sheryl>-F_34", "<Kisha>-F_45", "<Brandon>-N_33",
  "<Sharon>-F_38","<Penny>-F_58","<Justin>-M_41","<Patricia>-F_84")
df |> separate_wider_regex(str,patterns = c( "<", name = "[A-Za-z]+", ">-",
     gender = ".", "_", age = "[0-9]+"))

#------------ Pattern Details ----------
########### Escaping ############
# To create the regular expression \., we need to use \\.
dot <- "\\."
# But the expression itself only contains one \
str_view(dot)
str_view(c("abc", "a.c", "bef"), "a\\.c")

x <- "a\\b"
str_view(x)
str_view(x, "\\\\")
str_view(x, r"{\\}") # alternatively with raw-strings helps you escape one layer of escaping
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c") # alternatively with [.]
str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")

############# Anchors ##########
# regular expressions match any part of a string - ^ for start and $ for the end
str_view(fruit, "^a") # returns fruits starting with a
str_view(fruit, "a$") # returns fruits ending with a
str_view(fruit, "apple") # matches the string wherever it is
str_view(fruit, "^apple$") # matches the full string
str_view(fruit, "berry")
str_view(fruit, "^berry$")

# match the boundary between words
x <- c("summary(x)", "summarize(df)", "rowsum(x)", "sum(x)")
str_view(x, "sum") # matches all entries with some combination of sum
str_view(x, "\\bsum\\b")  # allows you match only sum with  operator \\b

str_view("abc", c("$", "^", "\\b")) # anchors will produce a zero-width match
str_replace_all("abc", c("$", "^", "\\b"), "--") # replaces -- on the indicated areas of abc

############ Character Classes ##########
# character class allows you to match any character in a set with []
# [a-z] matches any lowercase letter, [0-9] matches any number
# \ escapes special characters
x <- "abcd ABCD 12345 -!@#%."
str_view(x, "[abc]+")
str_view(x, "[a-z]+")
str_view(x, "[^a-z0-9]+")

# You need an escape to match characters that are otherwise special inside of []
str_view("a-b-c", "[a-c]")
str_view("a-b-c", "[a\\-c]") # an escape of \\ used

# six shortcuts with a selection of letters, numbers, punctuation characters
x <- "abcd ABCD 12345 -!@#%."
str_view(x, "\\d+") # matches any digit
str_view(x, "\\D+") # matches anything that isn't a digit
str_view(x, "\\s+") # matches any whitespace
str_view(x, "\\S+") # matches anything that isn’t whitespace
str_view(x, "\\w+") # matches any “word” character
str_view(x, "\\W+") # matches any “nonword” character

############## Quantifiers ###############
# Quantifiers control how many times a pattern matches
# {n} matches exactly n times
# {n,} matches at least n times
# {n,m} matches between n and m times

############ Grouping and Capturing ##########
str_view(fruit, "(.)\\1") # finds all fruits that have a repeated letter
str_view(fruit, "(..)\\1") # finds all fruits that have a repeated pair of letters

str_view(words, "^(.).*\\1$") # finds words that start and end with same letters
str_view(words, "^(..).*\\1$") # finds words that start and end with same pair of letters

head(sentences)
sentences |> str_replace("(\\w+) (\\w+) (\\w+)", "\\1 \\3 \\2") |> 
  str_view() # switches the order of the second and third words

# extracting the matches for each group
sentences |> str_match("the (\\w+) (\\w+)") |> head() # returns a matrix not easy to work with
sentences |> str_match("the (\\w+) (\\w+)") |> as_tibble(.name_repair = "minimal") |>
  set_names("match", "word1", "word2") # matrix converted to a tibble

#---------- Pattern Control ----------
########### Regex flags ##########
# most useful flag is probably ignore_case = TRUE
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
str_view(bananas, regex("banana", ignore_case = TRUE))

# work with multiline strings (strings that contain \n) dotall and multiline also useful
x <- "Line 1\nLine 2\nLine 3"
str_view(x, ".Line")
str_view(x, regex(".Line", dotall = TRUE)) # matches everything including \n

# multiline = TRUE makes ^ and $ match the start and end of each line -
# rather than the start and end of the complete string
x <- "Line 1\nLine 2\nLine 3"
str_view(x, "^Line")
str_view(x, regex("^Line", multiline = TRUE))

phone <- regex(
  r"(
\(? # optional opening parens
(\d{3}) # area code
[)\-]? # optional closing parens or dash
\ ? # optional space
(\d{3}) # another three numbers
[\ -]? # optional space or dash
(\d{4}) # four more numbers
)",
comments = TRUE)
str_extract(c("514-791-8141", "(123) 456 7890", "123456"), phone)

############# Fixed Matches ##########
# You can opt out of the regular expression rules by using fixed()
str_view(c("", "a", "."), fixed("."))

str_view("x X", "X")
str_view("x X", fixed("X", ignore_case = TRUE)) # gives you the ability to ignore case

# working with non-English text, you will probably want coll() instead of fixed()
str_view("i İ ı I", fixed("İ", ignore_case = TRUE))
str_view("i İ ı I", coll("İ", ignore_case = TRUE, locale = "tr"))

#------------ Practice ------------
# Checking your work by creating simple positive and negative controls
# Combining regular expressions with Boolean algebra
# Creating complex patterns using string manipulation

############# Check Your Work ############
str_view(sentences, "^The") # returns all sentences that start with The
str_view(sentences, "^The\\b") # adding a word boundary makes sure that the sentence starts with The

str_view(sentences, "^She|He|It|They\\b") # returns all sentences that begin with a pronoun
str_view(sentences, "^(She|He|It|They)\\b") # with () we get exact matches

# use of positive and negative matches to see if the pattern works as expected
pos <- c("He is a boy", "She had a good time")
neg <- c("Shells come from the sea", "Hadley said 'It's a great day'")
pattern <- "^(She|He|It|They)\\b"
str_detect(pos, pattern)
str_detect(neg, pattern)

############# Boolean Operations ############
str_view(words, "^[^aeiou]+$") # words that contain only consonants
str_view(words[!str_detect(words, "[aeiou]")]) # alternatively

# logical combinations particularly those involving “and” or “not.” -
# since there’s no “and” operator built in to regular expressions
str_view(words, "a.*b|b.*a") # returns  all words that contain “a” and “b
words[str_detect(words, "a") & str_detect(words, "b")] # alternatively

words[str_detect(words, "a") & str_detect(words, "e") &
    str_detect(words, "i") & str_detect(words, "o") &
    str_detect(words, "u")] #  a word that contains all vowels

############ Creating a Pattern with Code ##########
# we want to find all sentences that mention a color - word boundaries are better
str_view(sentences, "\\b(red|green|blue)\\b")

# if colors are many, store in a vector
rgb <- c("Red", "Green", "Blue")
str_c("\\b(", str_flatten(rgb, "|"), ")\\b")

str_view(colors()) # using colors in R
cols <- colors()
cols <- cols[!str_detect(cols, "\\d")]
pattern <- str_c("\\b(", str_flatten(cols, "|"), ")\\b")
str_view(sentences, pattern) # returns all sentences with colors


#---------------------------------- Chapter 16. Factors ----------------------------------

library(tidyverse)

########### Factor Basics ##########
x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar")
sort(x1) # not sorted well

month_levels <- c( "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
y1 <- factor(x1, levels = month_levels)
y1
sort(y1) # sorted well after asigning factors

y2 <- factor(x2, levels = month_levels)
y2 # values not in the level will be silently converted to NA

factor(x1) # omitting levels, data is taken in alphabetical order
forcats::fct(x1) # orders by first appearance 
levels(y2) # accesses the set of valid levels directly

# creating a factor when reading your data with readr with col_factor()
csv <- "
month,value
Jan,12
Feb,56
Mar,12"
df <- read_csv(csv, col_types = cols(month = col_factor(month_levels)))
df$month

############ General Social Survey ###########
gss_cat
?gss_cat

# factors in a tibble not easily seen so we use count()
gss_cat |> count(race)
gss_cat |> count(race, relig) # counts those in each race group and relig
table(gss_cat$race, gss_cat$relig) # alternatively

ggplot(gss_cat, aes(y = fct_infreq(rincome), fill = race)) + geom_bar()  + 
  scale_color_brewer(palette = "Dark2") 
gss_cat %>% group_by(partyid) %>% count()
table(gss_cat$denom, gss_cat$relig)

########### Modifying Factor Order ############
# number of hours spent on tv by religion
relig_summary <- gss_cat |> group_by(relig) |>
  summarize(tvhours = mean(tvhours, na.rm = TRUE), n = n())
relig_summary

ggplot(relig_summary, aes(x = tvhours, y = relig)) + geom_point(color = "Blue")
ggplot(relig_summary, aes(x = tvhours, y = fct_reorder(relig, tvhours))) +
  geom_point() # fct_reorder() orders the factor variables to tv hours

relig_summary |> mutate(relig = fct_reorder(relig, tvhours)) |>
  ggplot(aes(x = tvhours, y = relig)) + geom_point() # alternatively

# how average age varies across reported income level
rincome_summary <- gss_cat |> group_by(rincome) |>
  summarize(age = mean(age, na.rm = TRUE),n = n())
rincome_summary
ggplot(rincome_summary, aes(x = age, y = fct_reorder(rincome, age))) +
  geom_point()
ggplot(rincome_summary, aes(x = age, y = fct_relevel(rincome, "Not applicable"))) +
  geom_point() # use fct_relevel() to move a factor level to the front of the line


by_age <- gss_cat |> filter(!is.na(age)) |> count(age, marital) |>
  group_by(age) |> mutate(prop = n / sum(n))
ggplot(by_age, aes(x = age, y = prop, color = marital)) +
  geom_line(linewidth = 1) + scale_color_brewer(palette = "Dark2")

# fct_reorder2(f, x, y) reorders the factor f by the y values associated with the largest x values
ggplot(by_age, aes(x = age, y = prop, color = fct_reorder2(marital, age, prop))) +
  geom_line(linewidth = 1) + scale_color_brewer(palette = "Set1") +
  labs(color = "marital")

gss_cat |> mutate(marital = marital |> fct_infreq() |> fct_rev()) %>% 
 ggplot(aes( x = marital)) + geom_bar(fill = "White", color = "Black") + theme_bw()  

############ Modifying Factor Levels ##########
# fct_recode() allows you to recode, or change, the value of each level
gss_cat |> count(partyid)
gss_cat |> mutate(partyid = fct_recode(partyid,
                         "Republican, strong" = "Strong republican",
                         "Republican, weak" = "Not str republican",
                         "Independent, near rep" = "Ind,near rep",
                         "Independent, near dem" = "Ind,near dem",
                         "Democrat, weak" = "Not str democrat",
                         "Democrat, strong" = "Strong democrat" )) |>
  count(partyid)

# combine groups, you can assign multiple old levels to the same new level
gss_cat |> mutate(partyid = fct_recode(partyid,
                         "Republican, strong" = "Strong republican",
                         "Republican, weak" = "Not str republican",
                         "Independent, near rep" = "Ind,near rep",
                         "Independent, near dem" = "Ind,near dem",
                         "Democrat, weak" = "Not str democrat",
                         "Democrat, strong" = "Strong democrat",
                         "Other" = "No answer",
                         "Other" = "Don't know",
                         "Other" = "Other party")) %>% 
  select(partyid) %>% group_by(partyid) %>% count()

# collapsing a lot of levels, fct_collapse() is a useful variant of fct_recode()
gss_cat |> mutate(partyid = fct_collapse(partyid,
                           "other" = c("No answer", "Don't know", "Other party"),
                           "rep" = c("Strong republican", "Not str republican"),
                           "ind" = c("Ind,near rep", "Independent", "Ind,near dem"),
                           "dem" = c("Not str democrat", "Strong democrat"))) |>
  count(partyid)

# lumping together the small groups to make a plot or table simpler
gss_cat %>% group_by(relig) %>% select(relig) %>% count()
gss_cat |> mutate(relig = fct_lump_lowfreq(relig)) |> 
  count(relig) # merges all fewer groups
gss_cat |> mutate(relig = fct_lump_n(relig, n = 10)) |> 
  count(relig, sort = TRUE) # fct_lump_n() returns number of groups needed here its 10

############### Ordered Factors ###########
# factors created with ordered() imply strict ordering and equal distance between levels
# 1st level is “less than” the 2nd level by the same amount that the second level 
# is “less than” the third level, and so on
ordered(c("a", "b", "c"))


#-------------------------- Chapter 17. Dates and Times -------------------------------

library(tidyverse)
library(nycflights13)

#----------- Creating Date/Times -----------
# current data or date-time
today() # returns current date
now() # returns current date and time

csv <- "
date,datetime
2022-01-02,2022-01-02 05:12"
read_csv(csv) # readr automatically recognizes date and date-time

# no matter how you specify the date, its displayed the same  
csv <- "
date
01/02/15"
read_csv(csv, col_types = cols(date = col_date("%m/%d/%y")))
read_csv(csv, col_types = cols(date = col_date("%d/%m/%y")))
read_csv(csv, col_types = cols(date = col_date("%y/%m/%d")))

########## From Strings #############
# ymd() creates dates
ymd("2017-01-31")
mdy("January 31st, 2017")
dmy("31-Jan-2017")

ymd_hms("2017-01-31 20:11:59") #  creates a date-time - hours, minutes, seconds
mdy_hm("01/31/2017 08:01")

ymd("2017-01-31", tz = "UTC") # forces to create a time zone

############## From Individual Components ##########
# use make_date() for dates, use make_datetime() for date-times
flights |> select(year, month, day, hour, minute)
flights |> select(year, month, day, hour, minute) |>
  mutate(departure = make_datetime(year, 
  month, day, hour, minute)) # returns a single column for date/time

make_datetime_100 <- function(year, month, day, time) {
  make_datetime(year, month, day, time %/% 100, time %% 100)
} # creates a function make_datetime_100

flights_dt <- flights |> filter(!is.na(dep_time), !is.na(arr_time)) |>
  mutate( dep_time = make_datetime_100(year, month, day, dep_time),
    arr_time = make_datetime_100(year, month, day, arr_time),
    sched_dep_time = make_datetime_100(year, month, day,sched_dep_time),
    sched_arr_time = make_datetime_100(year, month, day,sched_arr_time)) |>
  select(origin, dest, ends_with("delay"), ends_with("time"))
flights_dt

flights_dt |> ggplot(aes(x = dep_time)) + 
  geom_freqpoly(binwidth = 86400) # 86400 seconds = 1 day
flights_dt |> filter(dep_time < ymd(20130102)) |> ggplot(aes(x = dep_time)) +
  geom_freqpoly(binwidth = 600) # 600 s = 10 minutes
# Note using date-times in a numeric context (like in a histogram), 1 -
# means 1 second, so a binwidth of 86400 means one day. For dates, 1 means 1 day

############# From Other Types ###########
# switching between a date-time and a date, use as_datetime() and as_date()
as_datetime(today())
as_date(now())

as_datetime(60 * 60 * 10)
as_date(365 * 10 + 2)
ymd(c("2010-10-10", "bananas"))
today(tz="UTC")

d1 <- "January 1, 2010"
mdy(d1)
d2 <- "2015-Mar-07"
ymd(d2)
d3 <- "06-Jun-2017"
dmy(d3)
d4 <- c("August 19 (2015)", "July 1 (2015)") # failed
as_date(d4)
d5 <- "12/30/14" # Dec 30, 2014
mdy(d5)
t1 <- "1705" # failed
now(t1)
t2 <- "11:15:10.12 PM" # failed
ymd_hm(t2)

#------------ Date-Time Components -----------

############# Getting Components ##########
# pulling out individual parts of the date with the accessor functions - 
# year(), month(), mday() (day of the month), yday() (day of the year),
# wday() (day of the week), hour(), minute(), and second()

datetime <- ymd_hms("2026-07-08 12:34:56")
year(datetime)
month(datetime)
mday(datetime)
yday(datetime)
wday(datetime)
hour(datetime)
minute(datetime)
second(datetime)

month(datetime, label = TRUE) # returns abbreviated name of month or day of week
wday(datetime, label = TRUE, abbr = FALSE) # Setting abbr = FALSE returns full name

# using wday() to see that more flights depart during week days than on weekend
flights_dt |> mutate(wday = wday(dep_time, label = TRUE)) |>
  ggplot(aes(x = wday)) + geom_bar()

#  average departure delay by minute within the hour
# flights leaving in minutes 20–30 and 50–60 have much lower delays than the rest
flights_dt |> mutate(minute = minute(dep_time)) |> group_by(minute) |>
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE),n = n()) |>
  ggplot(aes(x = minute, y = avg_delay)) + geom_line()

# scheduled departure time doesn't have such a strong pattern
sched_dep <- flights_dt |> mutate(minute = minute(sched_dep_time)) |> group_by(minute) |>
  summarize( avg_delay = mean(arr_delay, na.rm = TRUE), n = n())
ggplot(sched_dep, aes(x = minute, y = avg_delay)) + geom_line()

############# Rounding ##########
# rounding date to a nearby unit of time, with floor_date(), round_date(),ceiling_date()
flights_dt |> count(week = floor_date(dep_time, "week")) |>
  ggplot(aes(x = week, y = n)) + geom_line() + geom_point()

flights_dt |> mutate(dep_hour = dep_time - floor_date(dep_time, "day")) |>
  ggplot(aes(x = dep_hour)) + geom_freqpoly(binwidth = 60 * 30)
flights_dt |> mutate(dep_hour = hms::as_hms(dep_time - floor_date(dep_time,"day"))) |>
  ggplot(aes(x = dep_hour)) +geom_freqpoly(binwidth = 60 * 30)

############## Modifying Components #########
# accessor function to modify the components of a date/time incase of wrong formats
(datetime <- ymd_hms("2026-07-08 12:34:56"))
year(datetime) <- 2030
datetime
month(datetime) <- 01
datetime
hour(datetime) <- hour(datetime) + 1
datetime

# instead of modifying, create a new date-time with update()
update(datetime, year = 2030, month = 2, mday = 2, hour = 2)

# If values are too big, they will roll over:
update(ymd("2023-02-01"), mday = 30)
update(ymd("2023-02-01"), hour = 400)

#----------- Time Spans ----------

########### Durations ###########
# subtract two dates, you get a difftime object
h_age <- today() - ymd("1979-10-14")
h_age
as.duration(h_age)

# Durations always record the time span in seconds
dseconds(15)
dminutes(10)
dhours(c(12, 24))
ddays(0:5)
dweeks(3)
dyears(1)

# Larger units are created by converting minutes, hours, days, weeks, and years to seconds
2 * dyears(1)
dyears(1) + dweeks(12) + dhours(15)

# You can add and subtract durations to and from days
tomorrow <- today() + ddays(1)
tomorrow
last_year <- today() - dyears(1)
last_year

############ Periods ###########
# sometimes you might get an unexpected result because of time zones
one_am <- ymd_hms("2026-03-08 01:00:00", tz = "America/New_York")
one_am
one_am + ddays(1)

# To solve this problem, lubridate provides periods
one_am
one_am + days(1) # with the d

# Like durations, periods can be created with a number of friendly constructor functions
hours(c(12, 24))
days(7)
months(1:6)
years(1:5)

# You can add and multiply periods
10 * (months(6) + days(1))
days(50) + hours(25) + minutes(2)

# periods are more like to do what you expect than durations when added to dates
# A leap year
ymd("2024-01-01") + dyears(1)
ymd("2024-01-01") + years(1) # better response
# Daylight savings time
one_am + ddays(1)
one_am + days(1)

# Let’s use periods to fix an oddity related to our flight dates -
# Some planes appear to arrive at their destination before they departed from New York City
flights_dt |> filter(arr_time < dep_time) # returns overnight flights

flights_dt <- flights_dt |> mutate(overnight = arr_time < dep_time,
    arr_time = arr_time + days(overnight),
    sched_arr_time = sched_arr_time + days(overnight)) # add one day 

flights_dt <- flights_dt |> mutate(overnight = arr_time < dep_time,
    arr_time = arr_time + days(1),
    sched_arr_time = sched_arr_time + days(1)) # alternatively

flights_dt |> filter(arr_time < dep_time) # returns zero rows

############ Intervals ###########
# You can create an interval by writing start %--% end
y2023 <- ymd("2023-01-01") %--% ymd("2024-01-01")
y2023
y2024 <- ymd("2024-01-01") %--% ymd("2025-01-01")
y2024
y2023 / days(1) # returns how many days fit in a year
y2024 / days(1)

(today() %--% (today() + years(1))) / months(1) 

seq(ymd("2015-01-01"), ymd("2015-12-01"), by = "week") # returns weeks in every month
seq(ymd("2024-01-01"), ymd("2024-12-01"), by = "month") # returns first day of each month

############# Time Zones ###########
Sys.timezone() # returns your time zone
today() # returns today's date
now() # returns both date and current time

length(OlsonNames())
head(OlsonNames())

# these three objects represent the same instant in time
x1 <- ymd_hms("2024-06-01 12:00:00", tz = "America/New_York")
x1
x2 <- ymd_hms("2024-06-01 18:00:00", tz = "Europe/Copenhagen")
x2
x3 <- ymd_hms("2024-06-02 04:00:00", tz = "Pacific/Auckland")
x3

x1 - x2
x1 - x3

x4 <- c(x1, x2, x3)
x4 # returns time zones of the first element


#--------------------------- Chapter 18. Missing Values -------------------------------

library(tidyverse)

#----------- Explicit Missing Values ----------
########### Last Observation Carried Forward ###########
treatment <- tribble(
  ~person, ~treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, NA,
  "Katherine Burke", 1, 4)
treatment
treatment |> fill(everything()) # fills the missing values using the previous values

############ Fixed Values ##########
# incase missing values represent zero
x <- c(1, 4, 5, 7, NA)
coalesce(x, 0) # returns the NA as a zero  

x <- c(1, 4, 5, 7, -99)
na_if(x, -99) # returns -99 as NA

#------------- Implicit Missing Values ------------
# missing values that are not easily seen
stocks <- tibble(
  year = c(2020, 2020, 2020, 2020, 2021, 2021, 2021),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  price = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66))
stocks
df <- stocks |> pivot_wider(names_from = qtr,values_from = price) # shows the missing values
df |> pivot_longer(cols = !(year),names_to = "years",values_to = "price")

########### Complete ###########
stocks |> complete(year, qtr) # returns the full combination of rows and the NAs
stocks |> complete(year = 2019:2021, qtr) # returns a missing range of 2019

########## Joins ############
# revealing implicitly missing observations using joins
library(nycflights13)
flights |> distinct(faa = dest) |> anti_join(airports) # returns missing destinations
flights |> distinct(tailnum) |> anti_join(planes) # returns missing planes

#------------ Factors and Empty Groups ----------
# counting factors with a group of missing values
health <- tibble(name = c("Ikaia", "Oletta", "Leriah", "Dashay", "Tresaun"),
  smoker = factor(c("no", "no", "no", "no", "no"), levels = c("yes",
  "no")),age = c(34, 88, 75, 47, 56))

health |> count(smoker) # returns count without missing group
health |> count(smoker, .drop = FALSE) # returns count with the missing group

# with graphs
ggplot(health, aes(x = smoker)) + geom_bar() +
  scale_x_discrete() # returns ignoring the missing group
ggplot(health, aes(x = smoker)) + geom_bar() +
  scale_x_discrete(drop = FALSE) # returns the missing group too

# dplyr::group_by(), you can use .drop = FALSE to preserve all factor levels
health |> group_by(smoker, .drop = FALSE) |> summarize(
    n = n(),mean_age = mean(age),min_age = min(age), max_age = max(age),
    sd_age = sd(age)) # some unusual results coz of implicit missings
    
health |> group_by(smoker) |> summarize(n = n(), mean_age = mean(age), 
  min_age = min(age),max_age = max(age),sd_age = sd(age)) |> 
  complete(smoker) # makes the implicit missings explicit


#-------------------------- Chapter 19. Joins -----------------------------------------

library(tidyverse)
library(nycflights13)

#----------- Keys ----------
# how tables are connected through keys and what to do if they don't have keys
########### Primary and Foreign Keys ##########
# A primary key is a variable/set of variables that uniquely identifies each observation.
# When more than one variable is needed, the key is called a compound key

airlines # carrier or name
airports # faa is the primary key
planes # tailnum the primary key
weather # makes origin and time_hour the compound primary key

# A foreign key is a variable/set of variables that corresponds to a primary key-
# in another table
flights$tailnum # is a foreign key that corresponds to the primary key planes$tailnum

############ Checking Primary Keys ##########
# to count() the primary keys and look for entries where n is greater than one
planes
planes |> count(tailnum) |> filter(n > 1) # returns zero rows

weather 
weather |> count(time_hour, origin) |> filter(n > 1) # returns zero rows

# check for missing values in your primary keys — if a value is missing - 
# then it can’t identify an observation
planes |> filter(is.na(tailnum)) # returns zero rows
weather |> filter(is.na(time_hour) | is.na(origin)) # returns zero rows

########### Surrogate Keys ###########
# 3 variables in flights data frame that are primary keys
flights |> count(time_hour, carrier, flight) |> filter(n > 1)

# are altitude and latitude a good primary key for airports
airports
airports |> count(alt, lat) |> filter(n > 1) # returns n = 2, hence not a primary key

#  introducing a simple numeric surrogate key using the row number
flights2 <- flights |> mutate(id = row_number(), .before = 1)
flights2 # returns first column as id

#---------------- Basic Joins ------------
#  dplyr provides six join functions
left_join() #  mutating join - keeps all the rows in x
inner_join() # keeps only those rows that occur in both x and y
right_join() # keeps all rows in y
full_join() # keeps all rows in either x or y

semi_join() #  filtering join - keep all rows in x that have a match in y
anti_join() #  filtering join - keep all rows in x that don’t have a match in y

############ Mutating Joins ########
# A mutating join allows you to combine variables from two data frames
flights2 <- flights |> select(year, time_hour, origin, dest, tailnum, carrier)
flights2 # returns a shorter data frame

# using left_join() to add the full airline name to the flights2 data
airlines
flights2 |> left_join(airlines)
flights2 |> right_join(airlines)
flights2 |> inner_join(airlines)
flights2 |> full_join(airlines)

weather
# returns temperature and wind speed when each plane departed joined to flights2 dataframe
flights2 |> left_join(weather |> select(origin, time_hour, temp, wind_speed))

# returns what size of plane was flying
flights2 |> left_join(planes |> select(tailnum, type, engines, seats))

# When left_join() fails to find a match for a row in x, it fills in the new -
# variables with missing values
planes
flights2 |> filter(tailnum == "N3ALAA") |>
  left_join(planes |> select(tailnum, type, engines, seats)) %>% print(n=Inf)

############# Specifying Join Keys ##########
# naturally left_join() uses all similar variables to join
flights2 |> left_join(planes)

# to join explicitly we specify using join_by()
flights2 |> left_join(planes, join_by(tailnum))
flights2 |> left_join(planes, join_by(tailnum == tailnum)) # alternatively better
# year variables are disambiguated in the output with a suffix (year.x and year.y)

# specify different join keys in each table. For example, there -
# are two ways to join the flight2 and airports table: either by dest or by origin
airports
flights2
flights2 |> left_join(airports, join_by(dest == faa)) 
# dest == faa, tells which primary key in dataframe x to match with in dataframe y

flights2 |> left_join(airports, join_by(origin == faa))

############ Filtering Joins ##########
# the primary action of a filtering join is to filter the rows

# Semi-joins keep all rows in x that have a match in y
airports |> semi_join(flights2, 
    join_by(faa == origin)) # returns airports dataset to show just the origin airports
flights2 |> semi_join(airports, join_by(origin == faa))

airports |>
  semi_join(flights2, join_by(faa == dest)) # just the destinations

# Anti-joins are the opposite: return all rows in x that don’t have a match in y
# we can find rows that are missing from airports by looking for flights - 
# that don’t have a matching destination airport  
flights2 |> anti_join(airports, join_by(dest == faa)) |>
    distinct(dest)
  
# we can find which tailnums that are missing from planes
flights2 |> anti_join(planes, join_by(tailnum)) |> distinct(tailnum)

top_dest <- flights2 |> count(dest, sort = TRUE) |> head(10)
top_dest

airports |> semi_join(flights, join_by(faa == dest)) |>
  ggplot(aes(x = lon, y = lat)) + borders("state") + geom_point() +
  coord_quickmap() # map of the United States

#------------ How Do Joins Work? -----------

x <- tribble(~key, ~val_x,1, "x1",2, "x2",3, "x3")
x
y <- tribble( ~key, ~val_y, 1, "y1", 2, "y2", 4, "y3")
y

# inner_join() matches each row in x to the row in y that has the same value of key
inner_join(x,y)

# left join matches where every row in x appears in the output
left_join(x,y)

# right join matches where every row of y appears in the output
right_join(x,y)

# full join keeps all observations that appear in x or y
full_join(x,y)

############# Row Matching ###########
# There are three possible outcomes for a row in x:-
# If it doesn’t match anything, it’s dropped.
# If it matches one row in y, it’s preserved.
# If it matches more than one row in y, it’s duplicated once for each match

# one particularly dangerous case can cause a combinatorial explosion of rows
df1 <- tibble(key = c(1, 2, 2), val_x = c("x1", "x2", "x3"))
df1
df2 <- tibble(key = c(1, 2, 2), val_y = c("y1", "y2", "y3"))
df2

# many-to-many join and will cause dplyr to emit a warning:
inner_join(df1,df2) # joins but with warnings
df1 |> inner_join(df2, join_by(key)) # returns warnings
df1 |> inner_join(df2, join_by(key), relationship = "many-to-many") # alternatively without warnings

############ Filtering Joins ##########
# semi_join() only matters when there is a match; otherwise, values in y don’t affect the output
semi_join(x,y)

# anti_join() is the inverse of a semi_join(), dropping rows from x that have a match in y
anti_join(x,y)

# for keeping both keys
x |> left_join(y, by = "key", keep = TRUE)
left_join(x,y, keep = TRUE)

#------------- Non-Equi Joins ------------
# non-equi join where the x key must be greater than or equal to the y key - 
# Many rows generate multiple matches
left_join(x,y, join_by(key == key)) # equi joins
left_join(x,y, join_by(key >= key)) # non-equi joins

############ Cross Joins ##########
# A cross join matches each row in x with every row in y
left_join(x,y, join_by())

# Cross joins are useful when generating permutations - joining df to itself is a self-join
df <- tibble(name = c("John", "Simon", "Tracy", "Max"))
df |> cross_join(df)

########### Inequality Joins ###########
# Inequality joins use <, <=, >=, or > to restrict the set of possible matches
left_join(x,y, join_by(key < key))

# An inequality join is where x is joined to y on rows where the key of x is less 
# than the key of y. This makes a triangular shape in the top-left corner

# restricts the cross join so that instead of generating all permutations, 
# we generate all combinations
df <- tibble(id = 1:4, name = c("John", "Simon", "Tracy", "Max"))
df |> left_join(df, join_by(id < id))

############# Rolling Joins ###########
# Rolling joins are a special type of inequality join where instead of getting every
# row that satisfies the inequality, you get just the closest row

# # matches the smallest y that’s greater than or equal to x
left_join(x,y, join_by(closest(key <= key))) 

# matches the biggest y that’s less than x
left_join(x,y, join_by(closest(key > key)))

parties <- tibble(q = 1:4,party = ymd(c("2022-01-10", "2022-04-04", "2022-07-11", 
    "2022-10-03")))
# Now imagine that you have a table of employee birthdays:
employees <- tibble(name = sample(babynames::babynames$name, 100),
    birthday = ymd("2022-01-01") + (sample(365, 100, replace = TRUE) - 1))
employees

# And for each employee we want to find the first party date that comes after (or
# on) their birthday, a rolling join works
employees |> left_join(parties, join_by(closest(birthday >= party))) # returns a join

# people with birthdays before January 10 don’t get a party
employees |> anti_join(parties, join_by(closest(birthday >= party)))

############# Overlap Joins ###########
# 1. between(x, y_lower, y_upper) is short for x >= y_lower,x <= y_upper.
# 2. within(x_lower, x_upper, y_lower, y_upper) is short for x_lower >= y_lower, x_upper <= y_upper.
# 3. overlaps(x_lower, x_upper, y_lower, y_upper) is short for x_lower <= y_upper, x_upper >= y_lower

parties <- tibble(q = 1:4,
  party = ymd(c("2022-01-10", "2022-04-04", "2022-07-11", "2022-10-03")),
  start = ymd(c("2022-01-01", "2022-04-04", "2022-07-11", "2022-10-03")),
  end = ymd(c("2022-04-03", "2022-07-11", "2022-10-02", "2022-12-31")))
parties

# a self-join to check whether any start-end interval overlaps with another
parties |> inner_join(parties, join_by(overlaps(start, end, start, end), q < q)) |>
  select(start.x, end.x, start.y, end.y) # there is an overlap

# fixing the overlap
parties <- tibble(q = 1:4,
  party = ymd(c("2022-01-10", "2022-04-04", "2022-07-11", "2022-10-03")),
  start = ymd(c("2022-01-01", "2022-04-04", "2022-07-11", "2022-10-03")),
  end = ymd(c("2022-04-03", "2022-07-10", "2022-10-02", "2022-12-31")))

# use unmatched = "error" to quickly find out if any employees didn’t get assigned a party
employees |> inner_join(parties, join_by(between(birthday, start, end)),
             unmatched = "error")


#========================== Part IV. Import =====================================

install.packages("haven")
library(haven)

read_spss() # Read SPSS files
read_sas() # Read SAS files
read_stata() # Read Stata files
write_spss() # Write data to SPSS files
write_sas() #  Write data to SAS files
write_stata() # Write data to Stata files

nlsw88Data <- read_stata("nlsw88.dta")
nlsw88Data
glimpse(nlsw88Data)
view(nlsw88Data)
nlsw88Data$race <- factor(nlsw88Data$race)
contrasts(nlsw88Data$race)
levels(nlsw88Data$race)
attributes(nlsw88Data$collgrad) 


poverty_2020Data <- read_stata("Poverty_2020.dta")
glimpse(poverty_2020Data)
view(poverty_2020Data)
poverty_2020Data$quints <- factor(poverty_2020Data$quints)
levels(poverty_2020Data$quints)
labels(poverty_2020Data$region)
attributes(poverty_2020Data$region)

GSEC8 <- read_dta("D:/Chris kana/masters research/Household/GSEC8.dta")
View(GSEC8)
glimpse(GSEC8)
attributes(GSEC8$FF33)
GSEC8 |> count(hhid) |> filter(n > 1)

GSEC3A <- read_dta("D:/Chris kana/masters research/Household/GSEC3A.dta")
View(GSEC3A)
glimpse(GSEC3A)
attributes(GSEC3A$S04)
GSEC3A$S04 <- factor(GSEC3A$S04)
GSEC3A %>% group_by(S04)%>% distinct(hhid) %>% count(S04)
attributes(GSEC3A$S05)
GSEC3A %>% group_by(S05)%>% distinct(hhid) %>% count(S05)

GSEC3A %>% group_by(S09)%>% distinct(hhid) %>% count(S09, na.rm = T)
GSEC3A %>% distinct(S09)
dist <- GSEC3A %>% distinct(hhid, .keep_all = T )
dist %>% group_by(S09) %>% count(S09, na.rm = T)
glimpse(dist)
attributes(dist$S09)
table(dist$S04)

#-------------------------- Chapter 20. Spreadsheets ------------------------------------

















































































































































































































































































