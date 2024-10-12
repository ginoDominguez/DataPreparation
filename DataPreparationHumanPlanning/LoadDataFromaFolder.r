library(readxl)  
library(tidyr)
library(dplyr)
library(lubridate)


setwd("D:/CV/Proyectos/R/TransformacionyCargaDatos/horariosMedicos/Data/") #Change the path
Files_list=list.files( pattern = "\\.xls$") ### un archivo a la vez sino habria que iterar.

#### Function to: read, transform and combine: -----
Processing_files<-  function(Each_file)
{
  ### read the file
  data<- read_excel(Each_file, skip=6, col_types = "text")
  
  ## Create Data column y range of time:
  data<- gather(data, key='Dates', value='RangeTime', 3:ncol(data)) 
  data<-na.omit(data) 
  
  ### Delete this wrong  schedules  00:00-00:00 
  data<- data[ data$RangeTime != '00:00-00:00'   ,  ]
  
  ## Get Dates and range of time :
  data <- data %>%  mutate( Dates= as.Date( as.numeric(Dates) , origin = "1899-12-30", tz="UTC" ))
  
  ##Get Start and End time
  data<- data %>% mutate( Start_Time= substr( RangeTime, 1, 5),
                                                      End_Time= substr(RangeTime,7,11)
  )
  ## Transforming date time
  data<-data %>% mutate( Start_Time_hour= lubridate::hm(  data$Start_Time),
                                                     End_Time_hour=lubridate::hm(  data$End_Time),
                                                     diferencia= End_Time_hour - Start_Time_hour,
                                                     Fecha_hour_Start= paste( Dates, Start_Time_hour, " " ),
                                                     Fecha_hour_Start_Format= as_datetime(Fecha_hour_Start),
                                                     Fecha_hour_End= Dates +1,
                                                     Fecha_hour_End_1= case_when(
                                                       as.numeric(diferencia)<= 0  ~ paste( Dates + 1, End_Time_hour, " "),
                                                       TRUE ~ paste( Dates , End_Time_hour ,sep =  " "),  ),
                                                     Fecha_hour_End_Format= as_datetime(Fecha_hour_End_1)
  )
  ### Cleaning hours with format error - detected from previous step
  data<- data %>%  mutate( Fecha_hour_End_Format_2 =
                             case_when(
                             End_Time== "00:00" ~ paste(Fecha_hour_End, "00:00:00", " "),
                             End_Time== "00:30" ~  paste(Fecha_hour_End, "00:30:00", " "),
                             TRUE ~ as.character(Fecha_hour_End_Format))
  )
  
  DataaBase<- select(data, c(CODIGO, NOMBRES, Dates, RangeTime, Start_Time,End_Time, Fecha_hour_Start_Format, Fecha_hour_End_Format_2 ))
  
  DataaBase$Dependencia='Site'
  DataaBase$Archivo= Each_file
  DataaBase$anio= substr(Each_file,start =5, 8)
  DataaBase$mes=substr(Each_file,start =9, 10)
  
  ###Return Data transformed
  return(DataaBase) 
}

#### Apply a function to the files and combined in one dataframe ----
Data_Combined <- do.call(rbind, lapply(Files_list, Processing_files)  )
str(Data_Combined)

colnames(Data_Combined) <- c('ID','Name','Dates','RangeTime','Start_Time','End_Time','Date_Hour_Start_Format','Date_Hour_End_Format','Site','FileName','Year','Month' )


View(Data_Combined)

write.csv(Data_Combined,"Data_Combined.csv")
