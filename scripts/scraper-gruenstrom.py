#! python3
# coding: utf-8

# scrapes Grünstrom Label

import requests, sys, webbrowser, bs4, os

results_csv = open('gruenstrom-label-scraped.csv', 'a')
results_csv.write(f'Anbieter,Tarif,Verfügbarkeit,Telefon,Website\n')

base_url = 'https://www.gruenerstromlabel.de'
url = f'{base_url}/gruener-strom/oekostrom-beziehen/?no_cache=1'

table_select = '.contenttable tr'
print(f"Start scraping\n")
req = requests.get(url)
req.raise_for_status()
soup = bs4.BeautifulSoup(req.text, "lxml")

for i in soup.select(table_select):
    provider, tarif, region, phone, web = '', '', '', '', ''
    if i.find('th') != None:
        provider = i.find('th').getText()
    if i.find_all('td') != []:
        tarif = i.find_all('td')[0].getText()
        region = i.find_all('td')[1].getText()
        phone = i.find_all('td')[2].getText()
        web = i.find_all('td')[3].getText()

    results_csv.write(f'{provider},{tarif},{region},{phone},{web}\n')

print('Done\n')
