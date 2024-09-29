library("tidyverse")
library("dplyr")
library("readxl")


## install.packages("rJava") install.packages("xlsx") and install java previosly
options(java.parameters = "-Xmx4g")
library(xlsx)
###library(rJava)
#library("openxlsx")  ## The xlsx file has ans issue with Power BI


# Get Data Files in R -----------------------------------------------------

## I have consolidate the years from 2001 to 2012 using Excel:
INEC_Camas_2001_2012 <- read_excel("./Data/Camas_2001_2012.xlsx", 
                              col_types = c("text", "numeric", "text","text", "text", "text", "text", "text", 
                                            "text", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric"),
                              col_names = c( 
                                "Cod_est", "Anio_inv", "Prov_ubi", "Cant_ubi", "Parr_ubi", "Clase", "Tipo", "Entidad", 
                                "Sector", "Dotmedic", "Dotcirug", "Dotginob", "Dotped", "Dotcardi", "Dotneumo",
                                "Dotpsiqu", "Dottraum", "Dotinfec", "Dotofta", "Doturolo",	"Dotgast" ,
                                "Dototrse", "Dotserin", "Dotemerg", "Dotcinte", "Dismedic", "Discirug",
                                "Disginob", "Disped", "Discardi", "Disneumo", "Dispsiqu", "Distraum",
                                "Disinfec", "Disofta", "Disurolo", "Disgast", "Disotrse", "Disserin",
                                "Disemerg", "Discinte", "Camas_dnor", "Camas_disp", "Dias_cdis","Dia_estad",
                                "Falmen48", "Falmas48", "Totegres"
                              ) , skip = 1)

## The others years from 2013 until 2021 i get the file from the webpage of INEC:
## https://www.ecuadorencifras.gob.ec/estadisticas/ 
INEC_Camas_2013 <- read_excel("./Data/camas_2013.xlsx", 
                                col_types = c("text", "text", "text","text", "text", "text", "text", "text", 
                                               "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                               "numeric", "numeric", "numeric"),
                                col_names = c( 
                                  "Cod_est",  "Prov_ubi", "Cant_ubi", "Parr_ubi", "Clase", "Tipo", "Entidad", 
                                  "Sector", "Dotmedic", "Dotcirug", "Dotginob", "Dotped", "Dotcardi", "Dotneumo",
                                  "Dotpsiqu", "Dottraum", "Dotinfec", "Dotofta", "Doturolo",	"Dotgast" ,
                                  "Dototrse", "Dotserin", "Dotemerg", "Dotcinte", "Dismedic", "Discirug",
                                  "Disginob", "Disped", "Discardi", "Disneumo", "Dispsiqu", "Distraum",
                                  "Disinfec", "Disofta", "Disurolo", "Disgast", "Disotrse", "Disserin",
                                  "Disemerg", "Discinte", "Camas_dnor", "Camas_disp", "Totegres", "Dia_estad", 
                                  "Dias_cdis", "Falmen48", "Falmas48"
                                  ) , skip = 1)  ### campos faltantes: "Anio_inv",

#str(INEC_Camas_2001_2012)
### Adding the year to the data:
INEC_Camas_2013$Anio_inv<- 2013
### 2014----
INEC_Camas_2014 <- read_excel("./Data/camas_2014.xlsx", 
                              col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                            "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric"),
                              col_names = c( 
                                "Cod_est",  "Prov_ubi", "Cant_ubi", "Parr_ubi", "Clase", "Tipo", "Entidad", 
                                "Sector", "Dotmedic", "Dotcirug", "Dotginob", "Dotped", "Dotcardi", "Dotneumo",
                                "Dotpsiqu", "Dottraum", "Dotinfec", "Dotofta", "Doturolo",	"Dotgast" ,
                                "Dototrse", "Dotserin", "Dotemerg", "Dotcinte", "Dismedic", "Discirug",
                                "Disginob", "Disped", "Discardi", "Disneumo", "Dispsiqu", "Distraum",
                                "Disinfec", "Disofta", "Disurolo", "Disgast", "Disotrse", "Disserin",
                                "Disemerg", "Discinte", "Camas_dnor", "Camas_disp", "Totegres", "Dia_estad", 
                                "Dias_cdis", "Falmen48", "Falmas48"
                              ) , skip = 1)  ### campos faltantes: "Anio_inv",
INEC_Camas_2014$Anio_inv<- 2014                              

### 2015----

INEC_Camas_2015<-read_excel("./Data/camas_2015.xlsx", 
                            col_types = c("text", "text", "text", "text", "text", "text", "text", "numeric", 
                                          "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                          "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                          "numeric", "numeric"),
                            col_names = c( 
                              "Prov_ubi", "Cant_ubi", "Parr_ubi", "Clase", "Tipo", "Entidad", "Sector",
                              "Dotmedic", "Dotcirug", "Dotginob", "Dotped", "Dotcardi", "Dotneumo",
                              "Dotpsiqu", "Dottraum", "Dotinfec", "Dotofta", "Doturolo",	"Dotgast" ,
                              "Dototrse", "Dotserin", "Dotemerg", "Dotcinte", "Dismedic", "Discirug",
                              "Disginob", "Disped", "Discardi", "Disneumo", "Dispsiqu", "Distraum",
                              "Disinfec", "Disofta", "Disurolo", "Disgast", "Disotrse", "Disserin",
                              "Disemerg", "Discinte", "Camas_disp", "Dias_cdis", "Camas_dnor","Falmen48",
                              "Falmas48", "Totegres", "Dia_estad"
                            ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",  

INEC_Camas_2015$Anio_inv<- 2015 

#2016 ----
INEC_Camas_2016<- read_excel("./Data/camas_2016.xlsx", 
                             col_types = c("text", "text", "text", "text", "text", "text", "text", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric"),
                             col_names = c( 
                               "Prov_ubi", "Cant_ubi", "Parr_ubi", "Clase", "Tipo", "Entidad", "Sector",
                               "Dotmedic", "Dotcirug", "Dotginob", "Dotped", "Dotcardi", "Dotneumo",
                               "Dotpsiqu", "Dottraum", "Dotinfec", "Dotofta", "Doturolo",	"Dotgast" ,
                               "Dototrse", "Dotserin", "Dotemerg", "Dotcinte", "Dismedic", "Discirug",
                               "Disginob", "Disped", "Discardi", "Disneumo", "Dispsiqu", "Distraum",
                               "Disinfec", "Disofta", "Disurolo", "Disgast", "Disotrse", "Disserin",
                               "Disemerg", "Discinte", "Camas_dnor", "Camas_disp", "Falmen48", "Falmas48",
                                "Dia_estad", "Dias_cdis", "Totegres"
                             ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",  
INEC_Camas_2016$Anio_inv<- 2016 
#2017 ----


INEC_Camas_2017<- read_excel("./Data/camas_2017.xlsx", 
                             col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric"),
                             col_names = c( 
                               "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector",
                              "Dotmedic",	"Dismedic",	"Dotcirug",	"Discirug",	"Dotginob",	"Disginob",	
                              "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                              "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                              "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                              "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,"Dototrse",	"Disotrse",	
                              "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	"Dotcinte",	
                              "Dotcintrm",	"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                              "Falmas48"
                             ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",
                                            # campos nuevos: Dotootorri	Disootorri  Dotemerg	Dotcinte  Dotcintrm	Dototrapo
INEC_Camas_2017$Anio_inv<- 2017 

#2018 ----
INEC_Camas_2018<- read_excel("./Data/camas_2018.xlsx", 
                             col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric","numeric", "numeric", "numeric", 
                                           "numeric"),
                             col_names = c( 
                               "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector",
                               "Dotmedic",	"Dismedic",	"Dotcirug",	"Discirug",	"Dotginob",	"Disginob",	
                               "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                               "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                               "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                               "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,"Dototrse",	"Disotrse",	
                               "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	"Dotcinte",	
                               "Dotcintrm",	"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                               "Falmas48"
                             ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",
                                            # campos nuevos: Dotootorri	Disootorri  Dotemerg	Dotcinte  Dotcintrm	Dototrapo
INEC_Camas_2018$Anio_inv<-2018

#2019 ----
INEC_Camas_2019 <- read_excel("./Data/camas_2019.xlsx", 
                              col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric"),
                              col_names = c( 
                                "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector",
                                "Dotmedic",	"Dismedic",	"Dotcirug",	"Discirug",	"Dotginob",	"Disginob",	
                                "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                                "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                                "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                                "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,
                                "Dotquem",	"Disquem",	"Dotneuro",	"Disneuro",	"Dotnefro",	"Disnefro",	"Dotonco", "Disonco",
                                "Dothema",	"Dishema","Dototrse",	"Disotrse",	
                                "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	"Dotcinteadult",
                                "Dotcintepediatri",	"Dotcinteneonat",
                                "Dotcintrm", "Dotcrecup"	,"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                                "Falmas48"
                              ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",   "Dotcinte"
# campos nuevos: Dotootorri	Disootorri  Dotemerg	Dotcinte  Dotcintrm	Dototrapo
# campos nuevos adicionales: dotquem	disquem	dotneuro	disneuro	dotnefro	disnefro	dotonco	disonco	dothema	dishema
#Dotcinteadult   dotcintepediatri	dotcinteneonat dotcrecup
INEC_Camas_2019$Anio_inv<-2019

#2020 ----
INEC_Camas_2020 <- read_excel("./Data/camas_2020.xlsx", 
                              col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                            "numeric", "numeric"),
                              col_names = c( 
                                "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector",
                                "Dotmedic",	"Dismedic",	"Dotcirug",	"Discirug",	"Dotginob",	"Disginob",	
                                "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                                "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                                "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                                "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,
                                "Dotquem",	"Disquem",	"Dotneuro",	"Disneuro",	"Dotnefro",	"Disnefro",	"Dotonco", "Disonco",
                                "Dothema",	"Dishema","Dototrse",	"Disotrse",	
                                "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	"Dotcinteadult",
                                "Dotcintepediatri",	"Dotcinteneonat",
                                "Dotcintrm", "Dotcrecup"	,"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                                "Falmas48"
                              ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",   "Dotcinte"
# campos nuevos: Dotootorri	Disootorri  Dotemerg	Dotcinte  Dotcintrm	Dototrapo
# campos nuevos adicionales: dotquem	disquem	dotneuro	disneuro	dotnefro	disnefro	dotonco	disonco	dothema	dishema
#Dotcinteadult   dotcintepediatri	dotcinteneonat dotcrecup
INEC_Camas_2020$Anio_inv<-2020

#2021----
INEC_Camas_2021<- read_excel("./Data/camas_2021.xlsx", 
                             col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", 
                                           "numeric", "numeric"),
                             col_names = c( 
                               "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector",
                               "Dotmedic",	"Dismedic",	"Dotcirug",	"Discirug",	"Dotginob",	"Disginob",	
                               "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                               "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                               "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                               "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,
                               "Dotquem",	"Disquem",	"Dotneuro",	"Disneuro",	"Dotnefro",	"Disnefro",	"Dotonco", "Disonco",
                               "Dothema",	"Dishema","Dototrse",	"Disotrse",	
                               "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	"Dotcinteadult",
                               "Dotcintepediatri",	"Dotcinteneonat",
                               "Dotcintrm", "Dotcrecup"	,"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                               "Falmas48"
                             ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",   "Dotcinte"


# campos nuevos: Dotootorri	Disootorri  Dotemerg	Dotcinte  Dotcintrm	Dototrapo
# campos nuevos adicionales: dotquem	disquem	dotneuro	disneuro	dotnefro	disnefro	dotonco	disonco	dothema	dishema
#Dotcinteadult   dotcintepediatri	dotcinteneonat dotcrecup
INEC_Camas_2021$Anio_inv<-2021
### 2022 ----
INEC_Camas_2022<- read_excel("./Data/camas_2022.xlsx", 
                             col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric"),
                             col_names = c( 
                               "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector","Dotmedic",	"Dismedic",
                               	"Dotginob",	"Disginob", "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                               "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                               "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                               "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,
                               "Dotquem",	"Disquem",	"Dotneuro",	"Disneuro",	"Dotnefro",	"Disnefro",	"Dotonco", "Disonco",
                               "Dothema",	"Dishema", "dotaler", "disaler", "dotatpri","disatpri","dotcardipe","discardipe","dotciruca",
                               "disciruca","dotcirutor","discirutor","Dotcirug","Discirug","dotcirumafa","discirumafa","dotciruonc","disciruonc","dotciruped","disciruped","dotciruplas",
                               "disciruplas","dotciruvas","disciruvas","dotclido","disclido","dotderma","disderma","dotendoc","disendoc","dotendod","disendod","dotgen","disgen",
                               "dotgeri","disgeri","dotgero","disgero","dotmedial","dismedial","dotmedifa","dismedifa","dotmedifi","dismedifi","dotneurocli","disneurocli","dotneurops",
                               "disneurops","dotneuro","disneuro","dotodonpe","disodonpe","dotoncohe","disoncohe","dotortod","disortod","dotperio","disperio","dotprocto",
                               "disprocto","dotrehaor","disrehaor","dotreuma","disreuma","dotobste","disobste","dotcirucard","discirucard",
                               "Dototrse",	"Disotrse", "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	
                               "dotcbas",
                               "Dotcintrm","dotcinterpediatri","dotcinterneonat",                               
                               "Dotcinteadult","Dotcintepediatri",	"Dotcinteneonat",
                                "Dotcrecup"	,"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                               "Falmas48"
                             ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",   "Dotcinte"


INEC_Camas_2022$Anio_inv<-2022
INEC_Camas_2022$Clase<- as.character(as.numeric(INEC_Camas_2022$Clase))
INEC_Camas_2022$Area_ubi<- as.character(as.numeric(INEC_Camas_2022$Area_ubi))
INEC_Camas_2022$Tipo<- as.character(as.numeric(INEC_Camas_2022$Tipo))
INEC_Camas_2022$Entidad<- as.character(as.numeric(INEC_Camas_2022$Entidad))
INEC_Camas_2022$Sector<- as.character(as.numeric(INEC_Camas_2022$Sector))




###2023----
INEC_Camas_2023<- read_excel("./Data/camas_2023.xlsx", 
                             col_types = c("text", "text", "text", "text", "text", "text", "text", "text", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric", 
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric", "numeric", "numeric", "numeric","numeric", "numeric","numeric", "numeric",
                                           "numeric", "numeric", "numeric"),
                             col_names = c( 
                               "Prov_ubi", "Cant_ubi", "Parr_ubi", "Area_ubi" ,"Clase", "Tipo", "Entidad", "Sector","Dotmedic",	"Dismedic",
                               "Dotginob",	"Disginob", "Dotped",	"Disped","Dotneon",	"Disneon", "Dotcardi",	"Discardi",	
                               "Dotneumo",	"Disneumo",	"Dotpsiqu",	"Dispsiqu","Dottraum",	"Distraum", 
                               "Dotinfec",	"Disinfec","Dotofta",	"Disofta",	"Dotootorri",	"Disootorri",	
                               "Doturolo",	"Disurolo","Dotgast",	"Disgast"	,
                               "Dotquem",	"Disquem",	"Dotneuro",	"Disneuro",	"Dotnefro",	"Disnefro",	"Dotonco", "Disonco",
                               "Dothema",	"Dishema", "dotaler", "disaler", "dotatpri","disatpri","dotcardipe","discardipe","dotciruca",
                               "disciruca","dotcirutor","discirutor","Dotcirug","Discirug","dotcirumafa","discirumafa","dotciruonc","disciruonc","dotciruped","disciruped","dotciruplas",
                               "disciruplas","dotciruvas","disciruvas","dotclido","disclido","dotderma","disderma","dotendoc","disendoc","dotendod","disendod","dotgen","disgen",
                               "dotgeri","disgeri","dotgero","disgero","dotmedial","dismedial","dotmedifa","dismedifa","dotmedifi","dismedifi","dotneurocli","disneurocli","dotneurops",
                               "disneurops","dotneuro","disneuro","dotodonpe","disodonpe","dotoncohe","disoncohe","dotortod","disortod","dotperio","disperio","dotprocto",
                               "disprocto","dotrehaor","disrehaor","dotreuma","disreuma","dotobste","disobste","dotcirucard","discirucard",
                               "Dototrse",	"Disotrse", "Dotserin",	"Disserin",	"Camas_dnor",	"Camas_disp", "Dotemerg",	
                               "dotcbas",
                               "Dotcintrm","dotcinterpediatri","dotcinterneonat",                               
                               "Dotcinteadult","Dotcintepediatri",	"Dotcinteneonat",
                               "Dotcrecup"	,"Dototrapo"	, "Dia_estad", "Dias_cdis",	"Totegres",	"Falmen48",	
                               "Falmas48"
                             ) , skip = 1)  ### campos faltantes: "Anio_inv", "Cod_est",    "Disemerg", "Discinte",   "Dotcinte"


INEC_Camas_2023$Anio_inv<-2023
INEC_Camas_2023$Clase<- as.character(as.numeric(INEC_Camas_2023$Clase))
INEC_Camas_2023$Area_ubi<- as.character(as.numeric(INEC_Camas_2023$Area_ubi))
INEC_Camas_2023$Tipo<- as.character(as.numeric(INEC_Camas_2023$Tipo))
INEC_Camas_2023$Entidad<- as.character(as.numeric(INEC_Camas_2023$Entidad))
INEC_Camas_2023$Sector<- as.character(as.numeric(INEC_Camas_2023$Sector))


# Full Rows Merge Data set --- df_Consolidado---------------------------------------------

df_Consolidado<-bind_rows(INEC_Camas_2001_2012,INEC_Camas_2013,INEC_Camas_2014,INEC_Camas_2015,INEC_Camas_2016,INEC_Camas_2017,INEC_Camas_2018,INEC_Camas_2019,INEC_Camas_2020,INEC_Camas_2021)

df_Consolidado_1<-bind_rows(df_Consolidado, INEC_Camas_2023, INEC_Camas_2022 )



### remove the temporary datasets:
rm(list = c("INEC_Camas_2001_2012","INEC_Camas_2013","INEC_Camas_2014","INEC_Camas_2015","INEC_Camas_2016","INEC_Camas_2017","INEC_Camas_2018",
            "INEC_Camas_2019","INEC_Camas_2020","INEC_Camas_2021", "INEC_Camas_2022", "INEC_Camas_2023"))

df_Consolidado_1 %>%count()  ### 14914 this is the number of rows od the dataset. -->>> 16173 incuido a 2023

df_Consolidado_1 %>%  filter(is.na(Anio_inv)) %>% View()  ## Checking for Na's

#View(df_Consolidado)

### Entity Cases:  Casos Junta de Beneficencia y SOLCA ----
### Junta de Beneficencia de Guayaquil (entidad=13) y SOLCA(entidad = 15) son consideradas como privadas sin fines de lucro 
##a partir del 2015. Se realiza esta homologacion para todos los años:
#Junta de Beneficencia de Guayaquil and SOLCA were considered private non-profit after 2015, so we make the changes to the data before 2015 too:

df_Consolidado_1 <- df_Consolidado_1 %>% 
  mutate(Sector= if_else( (Entidad=="13" | Entidad == "15") , "3", Sector)   )
  
# We need to import some Master Data ad Dimentions-  Importacion de las Dimensiones-Datos Maestros ---------------------------

# Get the n sheets  ## Importar las n hojas que se encuentran en el archivo Dimensiones:
# If we don't know how to, we can check in google to have some referenes, as example:
#https://dominicroye.github.io/es/2019/importar-varias-hojas-excel-en-r/#:~:text=Por%20defecto%2C%20la%20funci%C3%B3n%20read_excel,el%20nombre%20(segundo%20argumento).&text=La%20funci%C3%B3n%20excel_sheets()%20permite%20extraer%20los%20nombres%20de%20las%20hojas.


ruta<- "./Data/Dimensiones.xlsx"

datos_Dimensiones<- ruta %>%  excel_sheets() %>% set_names() %>% map(read_excel, path=ruta)
str(datos_Dimensiones)


#Add to dataframe df_Consolidado data from Dimensions table. 
# Añadir al DataFrame df_Consolidado las Descripciones de los Id's a con los datos de datos_Dimensiones----------

#str(df_Consolidado)
#1.- Prov_ubi y Region
df_Consolidado_Descripciones<- left_join(df_Consolidado_1, datos_Dimensiones$Provincia,join_by("Prov_ubi"=="ID_Provincia") )

# df_Consolidado_Descripciones %>%count()  ### 14914 --- 14915
# df_Consolidado_Descripciones %>%  filter(is.na(Anio_inv)) %>% View()  

#Region: ID_Region
df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Region,join_by("ID_Region"=="ID_Region") )
#View(df_Consolidado_Descripciones)

#2.- Canton: ID_Canton
df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Canton,join_by("Cant_ubi"=="ID_Canton") )

#3.-Parroquia: Parr_ubi
df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Parroquia,join_by("Parr_ubi"=="ID_Parroquia") )

#4.- Clase: Cahnge the data type of variable Clase / modificar el tipo de dato para hacer el join de la variable clase
#str(df_Consolidado_Descripciones)
#str(datos_Dimensiones$Clase)

df_Consolidado_Descripciones<- df_Consolidado_Descripciones %>% mutate(
  Clase=as.integer(Clase)
)

df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Clase,join_by("Clase"=="ID_Clase") )

# df_Consolidado_Descripciones %>%count()  ### 14914
# df_Consolidado_Descripciones %>%  filter(is.na(Anio_inv)) %>% View()  

#5.- Tipo : Change the data type of variable Tipo / cambiar el tipo de dato de la variable Tipo
df_Consolidado_Descripciones<- df_Consolidado_Descripciones %>% mutate(
  Tipo=as.integer(Tipo)
)

df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Tipo,join_by("Tipo"=="ID_Tipo") )

#6.- Entidad: Change the data type of variable Entidad / Cambiar el tipo de dato de la variable entidad
df_Consolidado_Descripciones<- df_Consolidado_Descripciones %>% mutate(
  Entidad=as.integer(Entidad)
)


df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Entidad,join_by("Entidad"=="ID_Entidad") )

#7.- Sector:Change the data type of the variable Sector /  Cambiar el tipo de dato de la variable Sector

df_Consolidado_Descripciones<- df_Consolidado_Descripciones %>% mutate(
  Sector=as.integer(Sector)
)

df_Consolidado_Descripciones<- left_join(df_Consolidado_Descripciones, datos_Dimensiones$Sector,join_by("Sector"=="ID_Sector") )

### Remove the objects that we don't requiere anymore - Remover objetos que ya no usamos:
rm(list = c("df_Consolidado","datos_Dimensiones"))

df_Consolidado_Descripciones<-df_Consolidado_Descripciones %>% select( !Cod_est )

#View(df_Consolidado_Descripciones)

# Write the file in .csv or .xlsx -----------------------------------------

### Guardar archivo tratado en .csv o xlsx

write_csv(df_Consolidado_Descripciones, file ="./Output/DataINECCamas.csv", na = "NA"  )

#write.xlsx(df_Consolidado_Descripciones, file= "./Output/DataINECCamas.xlsx", sheetName = "Sheet1", row.names = FALSE)


#xlsx::write.xlsx(df_Consolidado_Descripciones, file= "DataINECCamas.xlsx", sheetName = "Sheet1", row.names = FALSE)


#openxlsx::write.xlsx(df_Consolidado_Descripciones, file= "DataINECCamas.xlsx", sheetName = "Sheet1", rownames = FALSE)
#View(df_Consolidado_Descripciones)

### Now we import the data from output to Power BI. 
#We can also set the data to a DB on the cloud such as BigQuery and then connect Power BI to the DB






