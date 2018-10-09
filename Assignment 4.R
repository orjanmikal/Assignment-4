rm(list=ls())

#loading packages
library(rvest)
library(tibble)
library(dplyr)
library(tidyr)
library(tidyverse)

#Getting the website
url <- "https://w2.brreg.no/kunngjoring/kombisok.jsp?datoFra=01.01.2018&datoTil=03.10.2018&id_region=100&id_fylke=19&id_kommune=-+-+-&id_niva1=51&id_niva2=-+-+-&id_bransje1=0"

webpage <- read_html(url)

#Using CSS selectors to scrap section
section <- html_nodes(webpage,'p a')

#Converting the title data to text
section_data <- html_text(section)
section_data <- as.factor(section_data)
head(section_data)

#Converting dato to date format
dato <- html_nodes(webpage, "tr~ tr+ tr td:nth-child(6) p")
dato <- html_text(dato)
head(dato)
dato <- as.Date(dato, format = "%d.%m.%Y")
str(dato)

#Scrapping number section
number <-html_nodes(webpage, "td:nth-child(4) p")
number <- html_text(number)
number <-str_replace_all(string = number, pattern=" ", repl= "")

#Scrapping names
names <- html_nodes(webpage, "td td:nth-child(2) p")
glimpse(names)
names <- html_text(names[2:269])
names <- as.character(names)

#Creating dataframe
dataframe <- data.frame(names, section_data, dato, number, stringsAsFactors = FALSE)

#Removing persons
dataframe <- filter(dataframe, number > 6)

