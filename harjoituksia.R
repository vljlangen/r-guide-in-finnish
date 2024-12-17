
# Ladataan dplyr-paketti käyttöön

library(dplyr)


# Ladataan mtcars-data datasettiin, jonka nimeksi tulee "automobiilit":

automobiilit <- mtcars


# Luodaan uusi datasetti automobiilit 2, johon otetaan mukaan vain 4 muuttujaa,
# joille annetaan suomenkieliset nimet:

automobiilit2 <- automobiilit %>% #Otetaan käsiteltäväksi datasetti automobiilit
  filter(carb > 1) %>%            #Säilytetään vain autot, joissa yli 1 karburaattori
  mutate(bensankulutus = mpg,     #Luodaan uusia suomenkielisiä
         hevosvoima = hp,         #muuttujia näillä neljällä rivillä;
         massa = wt,              #käytännössä luodaan englanninkielisistä
         vaihteisto = am) %>%     #valmiista muuttujista duplikaatteja
  select(bensankulutus,           #Pidetään luomamme muuttujat, tuhotaan kaikki muut
         hevosvoima,
         massa,
         vaihteisto)


# Luodaan puutteellista dataa harjoituksen vuoksi:

automobiilit2 <- automobiilit2 %>%
  add_row(bensankulutus = 10,           #Luodaan auto, jolle massaa ei määritetä,
          hevosvoima = 80,              #joten tämän auton massa saa automaattisesti
          vaihteisto = 0)              #arvon NA (= not available = missing data)

automobiilit2 <- automobiilit2 %>%
  add_row(bensankulutus = 15,           #Luodaan seuraava auto,
          hevosvoima = 100,             #jonka massa kyllä määritetään,
          massa = 0,                    #mutta massa saa epäadekvaatin arvon 0 kiloa
          vaihteisto = 0)


# Poistetaan NA-arvoa sisältävät rivit:

automobiilit2 <- automobiilit2 %>% na.omit


# Poistetaan rivit joilla epäadekvaattia dataa:

automobiilit2 <- automobiilit2 %>%
  filter(bensankulutus > 0,
         hevosvoima > 0,
         massa > 0,
         vaihteisto %in% c(0,1))


# Muutetaan amerikkalaiset yksiköt suomalaisiksi:

automobiilit2 <- automobiilit %>% 
  filter(carb > 1) %>%
  mutate(bensankulutus = 235.2 / mpg,     #Ihan samat ajot kuin viimeksi,
         hevosvoima = hp / 0.9863,           #mutta muutetaan mutate-käskyllä
         massa = wt * 453.6,                #nimen lisäksi yksiköt eurooppalaisiksi
         vaihteisto = am) %>%
  select(bensankulutus,                      #Ja jälleen: säilytetään vain nämä
         hevosvoima,                         #4 muuttujaa
         massa,
         vaihteisto)

autoja <- automobiilit2

