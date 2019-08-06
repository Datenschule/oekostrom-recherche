# Merge-Doc

## Basis
OK Power https://www.ok-power.de/fuer-strom-kunden/anbieter-uebersicht.html
Grün Strom https://www.gruenerstromlabel.de//gruener-strom/oekostrom-beziehen/

> Zertifiziert werden immer einzelne, namentlich genannte Ökostromprodukte, nicht der Anbieter selbst. Manche Anbieter führen neben Grüner Strom-Produkten weitere, nicht zertifizierte Ökostromprodukte. Wenn Sie sich also mit dem Anbieter in Verbindung setzen, fragen Sie bitte gezielt nach dem hier genannten Produkt!

Wir scrapen von den Websiten und mergen dann basierend auf dem Anbieternamen.
Die gescrapten Daten orientieren sich an Tarifen, aber wir interessieren uns für die Anbieter.

``` bash
# scrape
$ python scripts/scraper-okpower.py && python scripts/scraper-gruenerstrom.py
# move to clean data and then merge
$ ruby scripts/merge_labels.rb
```

## Enhance!

### Energie und Management
http://www.energymailer.de/filestore/newsimgorg/Illustrationen_Stimmungsbilder/UEbersichten_Tabellen/Reine_Oekostromanbieter_Liste_2018_Umfrage_Tabelle_EundM.orig.pdf

> Stand: Oktober 2017 auf Basis der von den Unternehmen ausgewiesenen Stromkennzeichnung

Aus dem PDF gescrapt mit Tabula

``` bash
# merge
$ ruby scripts/merge_eum_reineoekostromanbieter.rb
```

### Verbraucherzentrale Niedersachsen
https://www.marktwaechter-energie.de/wp-content/uploads/2015/07/Uebersicht_Oekostromtarife_Grundversorger_Niedersachsen.pdf

https://www.marktwaechter-energie.de/untersuchungen/ueberblick-oekostrom-labels/

> Stand: August 2015

Aus dem PDF gescrapt mit Tabula und in OpenRefine nachgebessert.

``` bash
# merge
$ ruby scripts/merge_verbraucherzentrale.rb
```
Dann noch einmal in OpenRefine geclustert und bereinigt.

---

Stromauskunft.de

Scraped data from https://www.stromauskunft.de/oekostrom/oekostrom-anbieter/
und https://www.stromauskunft.de/oekostrom/echter-oekostrom/
Als PDF gespeichert, mit Tabula in CSV umgewandelt, un OpenRefine bereinigt.


Utopia.de

Daten aus diesem Artikel https://utopia.de/bestenlisten/die-besten-oekostrom-anbieter/#kriterien
