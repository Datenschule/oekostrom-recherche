# Merge-Doc

## Ökostrom Labels

Problematisch:
- Zertifizieren nur Tarife, nicht Anbieter
- Anbieter müssen Labels kaufen, nicht alle Ökoanbieter tun das

### OK Power
- https://www.ok-power.de/fuer-strom-kunden/anbieter-uebersicht.html
- Kriterien https://www.ok-power.de/files/ok_power_theme/PDF-Downloads/ok-power%20Kriterien%20V9.1.pdf
- Liste mit python gescrapt

``` bash
$ python scripts/scraper-okpower.py
```

### Grün Strom

- https://www.gruenerstromlabel.de//gruener-strom/oekostrom-beziehen/
- Liste mit python gescrapt

``` bash
$ python scripts/scraper-gruenerstrom.py
```

---

Beide Listem mit Ruby gemergt

``` bash
$ ruby scripts/merge_labels.rb
```

## Unabhängige (?) Listen

### Energie und Management
- http://www.energymailer.de/filestore/newsimgorg/Illustrationen_Stimmungsbilder/UEbersichten_Tabellen/Reine_Oekostromanbieter_Liste_2018_Umfrage_Tabelle_EundM.orig.pdf
- Stand: Oktober 2017 auf Basis der von den Unternehmen ausgewiesenen Stromkennzeichnung
- Aus dem PDF gescrapt mit Tabula

---
Zu anderen Labels gemergt mit:

``` bash
$ ruby scripts/merge_eum_reineoekostromanbieter.rb
```

### Verbraucherzentrale Niedersachsen

- https://www.marktwaechter-energie.de/wp-content/uploads/2015/07/Uebersicht_Oekostromtarife_Grundversorger_Niedersachsen.pdf
- https://www.marktwaechter-energie.de/untersuchungen/ueberblick-oekostrom-labels/
- Stand: August 2015
- Aus dem PDF gescrapt mit Tabula und in OpenRefine nachgebessert.

``` bash
$ ruby scripts/merge_verbraucherzentrale.rb
```
- Dann noch einmal in OpenRefine geclustert und bereinigt.

---

### Bundesnetzagentur

- Liste aller StromVersorger
- Stand 01.08.2019

https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Energie/Unternehmen_Institutionen/HandelundVertrieb/LieferantenAnzeige/StromVersorgerListe_pdf.pdf?__blob=publicationFile&v=7

- PDF mit Tabula gescrapt

---

Abgeglichen und Adressen ergänzt

---

## Vergleichsportale

Problematisch:
- Unklar woher die Daten stammen
- Wann welcher Anbieter vorgeschlagen bzw verglichen wird

Aber:
- Hier informieren sich Leute
- Scheinen irgendwo an Daten gekommen zu sein?

### Stromauskunft.de

- Haben eine Liste mit Ökostromtarifanbietern und eine Liste mit "echten" Ökostromanbietern nach Ökotest
- Alle Ökostromtarifanbieter https://www.stromauskunft.de/oekostrom/oekostrom-anbieter/ (715)
- Alle "echter" Ökostromanbieter https://www.stromauskunft.de/oekostrom/echter-oekostrom/ (18)
- Beziehen sich auf Öko Test, Jahrbuch 2018 vom 09.01.2018
- Als PDF gespeichert, mit Tabula in CSV umgewandelt, in OpenRefine bereinigt.

### Utopia.de

- Liste der "besten Ökostromanbieter" (16)
- https://utopia.de/bestenlisten/die-besten-oekostrom-anbieter/#kriterien
- Beziehen sich auf Öko Test 12/18
- Stand 09.07.2019

### Check24.de

- Liste alle Anbieter ohne Unterscheidung Ökostrom(Tarif) / nicht Ökostromtarif (1076)
- https://www.check24.de/strom-gas/energieanbieter/?f_type=chip&f_prop=listed&f_value=yes
- Stand 07.08.2019
- in csv kopiert

### Verivox

- Liste alle Anbieter ohne Unterscheidung Ökostrom(Tarif) / nicht Ökostromtarif (1147)
- https://www.verivox.de/power/carriers.aspx?fl=all
- Stand 07.08.2019
- in csv kopiert


### Ökotest Strom Jahrbuch Januar 2018

- Liste von Ökostromanbietern auf Basis von  Eco Top Ten
- https://www.oekotest.de/bauen-wohnen/Oeko-Strom-im-Test-Das-sind-die-besten-Anbieter_111510_1.html
- Stand 12.12.2018
- von website gescrapt

### Eco Top Ten
- Liste aller bundesweit angebotenen Ökostromtarife, die eine (!) Zertifizierung oder Label haben
- https://www.ecotopten.de/strom/oekostrom-tarife
- https://www.ecotopten.de/oekostromtarife/xls?attach=panel_pane_5
- Kriterien https://www.ecotopten.de/sites/default/files/ecotopten_kriterien_oekostrom.pdf
- Stand august 2018
- wird als .xls angeboten \o/
