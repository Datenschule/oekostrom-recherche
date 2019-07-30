#! python3
# coding: utf-8

# scrapes OK power Label

import requests, sys, webbrowser, bs4, os

results_csv = open('okpower-label-scraped.tsv', 'a')
results_csv.write(f'Anbieter\tTarif\tAdresse\tTelefon\tWebsite\n')

base_url = 'https://www.ok-power.de'
url = f'{base_url}/fuer-strom-kunden/anbieter-uebersicht.html'

table_select = '#anbieterliste .anbieter'
print(f"Start scraping\n")
req = requests.get(url)
req.raise_for_status()
soup = bs4.BeautifulSoup(req.text, "lxml")

provider_select = '.row_0 .col_first strong'
tarif_select = '.row_0 .col_last a'
phone_select = '.row_2 .col_last'
web_select = '.row_last .col_last a'
address_select_1 = '.row_2 .col_first'
address_select_2 = '.row_3 .col_first'

for i in soup.select(table_select):
    provider, tarif, address, phone, web = '', '', '', '', ''

    if i.select(provider_select) != None:
        provider = i.select(provider_select)[0].getText()
        provider = provider.replace('<br>', ' ')
        provider = provider.replace('\n', ' ')
    if i.select(tarif_select) != None:
        tarif = i.select(tarif_select)[0].getText()
        tarif = tarif.strip()
        tarif = tarif.replace('<br>', ' ')
        tarif = tarif.replace('\n', ' ')
    if i.select(phone_select) != None:
        phone = i.select(phone_select)[0].getText()
        phone = phone.replace('<br>', ' ')
        phone = phone.replace('\n', ' ')
    if len(i.select(web_select)) > 0:
        web = i.select(web_select)[0].getText()
    if i.select(address_select_1) != None and i.select(address_select_2) != None:
        address = f"{i.select(address_select_1)[0].getText()} - {i.select(address_select_2)[0].getText()}"
        address = address.replace('<br>', ' ')
        address = address.replace('\n', ' ')

    results_csv.write(f'{provider}\t{tarif}\t{address}\t{phone}\t{web}\n')

print('Done\n')
