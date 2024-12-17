
##################################################################
##                         Kappale 6.3:                         ##
##                     dplyr-paketin lataus                     ##
##################################################################

# Ladataan muistiin dplyr-paketti.
library(dplyr)



##################################################################
##                      Kappaleet 7 ja 7.1                      ##
##                      Esimerkkidatasetti                      ##
##                   Datan muokkaus dplyr:lla                   ##
##################################################################

# Kopioidaan R:n esimerkkidatan "mtcars" sisältö
# uuteen datasettiin "automobiilit".
automobiilit <- mtcars

# Otetaan käsiteltäväksi datasettimme "automobiilit".
automobiilit2 <- automobiilit %>%              

# Säilytetään vain autot, joissa yli 1 karburaattori:
  filter(carb > 1) %>%            
  
# Luodaan uusia suomenkielisiä muuttujia (oikeastaan
# duplikaatteja jo englanniksi olevista muuuttujista).
  mutate(bensankulutus = mpg,    
         hevosvoima = hp,         
         massa = wt,              
         vaihteisto = am) %>%
  
#Pidetään luomamme muuttujat, tuhotaan kaikki muut  
  select(bensankulutus,           
         hevosvoima,
         massa,
         vaihteisto)



##################################################################
##                      Kappaleet 8 ja 8.1                      ##
##                     Puutteellista dataa?                     ##
##                  Puutteellisen datan poisto                  ##
##################################################################

# 1.
#
# Luodaan auto, jolle ei määritetä massaa.
# Massa saa automaattisesti R:ssä siksi arvon NA (not available eli missing data).
# Tallennetaan koko uusi automobiilisetti datasettiin "automobiilit3":
automobiilit3 <- automobiilit2 %>%
  add_row(bensankulutus = 30.7,
          hevosvoima = 67,
          vaihteisto = 1)

#Annetaan viimeisen rivin (eli auton) nimeksi "Lada":
row.names(automobiilit3)[nrow(automobiilit3)] <- "Лада"     


# 2.
#  
# Luodaan seuraava auto, joka saa DDR:n historiaa henkivän nimen "Trabant".
# Annetaan massaksi selvästi virheellinen arvo 0 kiloa.
# Tallennetaan koko automobiilisetti datasetin "automobiili3" päälle:
automobiilit3 <- automobiilit3 %>%
  add_row(bensankulutus = 34.6,  
          hevosvoima = 23,    
          massa = 0,           
          vaihteisto = 1)

row.names(automobiilit3)[nrow(automobiilit3)] <- "Trabant"  


# Näytetään datamme, kun NA'ta sisältäneet rivit on poistettu.
# Huom! Uutta datasettiä ei luoda, sillä emme käske dataa
# operaattorilla <- siirrettäväksi mihinkään uuteen datasettiin.
# Eli seuraava koodi vain ikään kuin näyttää minkälainen datasetti
# meille tulisi, jos ohjaisimme koodin eteenpäin uuteen datasettiin
# käyttämällä operaattoria <- ja antamalla uudelle datasetille jonkun
# nimen, esim. "automobiilit4":
automobiilit3 %>% na.omit


# Säilytetään vain autot, joiden muuttujat saavat "sallittuja", järjellisiä arvoja.
# Jälleen: emme tee uutta datasettiä vaan ainoastaan demonstroimme minkälainen datasetti
# tulisi, jos loisimme tässä uuden datasetin.
automobiilit3 %>%
  filter(bensankulutus > 0,
         hevosvoima > 0,
         massa > 0,
         vaihteisto %in% c(0,1))


# Poistetaan rivit joilla epäadekvaattia dataa tai NA:ta.
# Tallennetaan tällainen koko automobiilisetti
# uuteen datasettiin "automobiilit4":
automobiilit4 <- automobiilit3 %>%
  filter(bensankulutus > 0,
         hevosvoima > 0,
         massa > 0,
         vaihteisto %in% c(0,1))



##################################################################
##                          Kappale 10                          ##
##                       Muunnosmuuttujat                       ##
##################################################################

# Ajetaan putkittamalla eli %>%-merkkikomboa käyttämällä kaikki
# seuraavat 4 kohtaa kerralla:

# 1. Lähdetään uudelleen alusta liikkeelle, otetaan mtcars käsiteltäväksi.
autoja <- mtcars %>% 
  
# 2. Valitaan vain yli 1 karburaattoria sisältävät autot.  
  filter(carb > 1) %>%
  
# 3. Muutetaan mutate-käskyllä jenkkiyksiköt eurooppalaisiksi
# ja annetaan muuttujille samalla suomalaisia nimiä.  
  mutate(bensankulutus_eu = 235.2 / mpg,     
         hevosvoima_eu = hp / 0.9863,        
         massa_eu = wt * 453.6,
         vaihteisto = am) %>%

# 4. Select-käskyllä säilytetään vain luomamme uudet muuttujat ja
# samalla tulee tuhotuksi kaikki muut muuttujat.
  select(bensankulutus_eu,
         hevosvoima_eu,
         massa_eu,
         vaihteisto)



#################################################################
##                        Kappale 11.1                         ##
##                       as.factor-käsky                       ##
#################################################################

# Muutetaan muuttuja "autoja$vaihteisto" eli datasetin "autoja" muuttuja
# "vaihteisto" muotoon factor.
# Tallennetaan se itsensä päälle.
autoja$vaihteisto <- as.factor(autoja$vaihteisto)

# Täysin sama asia olisi voitu tehdä dplyr-tyyppisellä käskyllä:

#autoja <- autoja %>% mutate(vaihteisto = as.factor(vaihteisto))



##################################################################
##                         Kappale 11.2                         ##
##                            tibble                            ##
##################################################################

# Muutetaan datasettimme muotoon tibble.
# Rivinimet tuhoutuvat, mutta ne voidaan tästä
# eteenpäin nähdä ensimmäisessä sarakkeessa.
autoja2 <- as_tibble(autoja, rownames = "Automerkit")
