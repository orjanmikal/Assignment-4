rm(list=ls())

#Laster pakker
library(rvest)
library(tibble)

#henter ned netsiden
brøn.reg <- read_html("https://w2.brreg.no/kunngjoring/kombisok.jsp?datoFra=01.01.2018&datoTil=03.10.2018&id_region=100&id_fylke=19&id_kommune=-+-+-&id_niva1=51&id_niva2=-+-+-&id_bransje1=0")

#gjør om til en liste
brøn.reg %>% html_nodes("p")
konkursliste <- brøn.reg %>% html_nodes("p") %>% html_text()
konkursliste <- tibble(konkursliste)

#Her ble jeg sittende fast videre om hvordan man skal sortere denne listen.
