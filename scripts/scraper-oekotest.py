#! python3
# coding: utf-8

# scrapes Oeko Test Stromvergleich

import requests, sys, webbrowser, bs4, os

results_csv = open('oekotest-strom-scraped.tsv', 'a')
results_csv.write(f'Anbieter\tProdukt\n')

base_url = 'https://www.oekotest.de'
url = f'{base_url}//bauen-wohnen/Oeko-Strom-im-Test-Das-sind-die-besten-Anbieter_111510_1.html'

table_select = '.productList-body .product'
print(f"Start scraping\n")
req = requests.get(url)
req.raise_for_status()
soup = bs4.BeautifulSoup(req.text, "lxml")

provider_select = '.product-distributor'
product_select = '.product-name'

for i in soup.select(table_select):
    provider, product = '', ''

    if i.select(provider_select) != None:
        provider = i.select(provider_select)[0].getText()
        procider = provider.strip()
        #provider = provider.replace('<br>', ' ')
        #provider = provider.replace('\n', ' ')
    if i.select(product_select) != None:
        product = i.select(product_select)[0].getText()
        product = product.strip()
        #product = tarif.replace('<br>', ' ')
        #product = tarif.replace('\n', ' ')

    results_csv.write(f'{provider}\t{product}\n')

print('Done\n')
