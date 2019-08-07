# coding: utf-8
# merge Bundesnetzagentur und bisherige Liste

require 'csv'

bna = CSV.read("../cleaned_data/StromVersorgerListe_Bundesnetzagentur.cleaned.csv", headers: true)
labels = CSV.read("../cleaned_data/vbzns-merged-2019-08-05-cleaned.csv", headers: true)

comb = Hash.new(false)

puts "Start merge\n\n"

labels.each do |record|
  if comb[record["Anbieter"].downcase] == false
    comb[record["Anbieter"].downcase] = {
      provider: record["Anbieter"],
      phone: record["Telefon"],
      website: record["Website"],
      adress: record["Adresse"],
      availability: record["Verfügbarkeit"],
      okpower: record["Ok Power"],
      gruenstrom: record["Grünstrom"],
      eum: record["Energie&Management"],
      vbns: record["Verbraucherschutz Niedersachsen"],
      matchbna: false
    }
  else
    puts "Already listed in dataset: #{record['Anbieter']}"
  end
end

count = 0

bna.each do |record|
  if comb[record["Firmenname"].downcase] != false
    puts "Found match, enhancing data for: #{ record['Firmenname'] }"
    count += 1
    comb[record["Firmenname"].downcase][:matchbna] = true
    comb[record["Firmenname"].downcase][:address] = "#{record['Firmenanschrift']} - #{record['PLZ']} #{record['Firmenort']}"
  else
    # will be filtered by in Open Refine
    comb[record["Firmenname"].downcase] = {
      provider: record["Firmenname"],
      matchbna: "bna",
      address: "#{record['Firmenanschrift']} - #{record['PLZ']} #{record['Firmenort']}"
    }
  end
end

comb = comb.sort_by { |k,v| v[:provider] }

CSV.open("bna_matched.csv", "w") do |csv|
  csv << ["Anbieter",
          "Ok Power",
          "Grünstrom",
          "Energie & Managment",
          "Verbraucher Niedersachsen",
          "Vergleich Bundesnetzagentur",
          "Telefon",
          "Website",
          "Adresse",
          "Verfügbarkeit"]

  comb.each do |k,v|
    csv << [v[:provider],
            v[:okpower],
            v[:gruenstrom],
            v[:eum],
            v[:vbns],
            v[:matchbna],
            v[:phone],
            v[:website],
            v[:address],
            v[:availability]
           ]
  end
end

puts "\nResults:"
puts "dataset count: #{comb.count}, matches found #{count} (labels before: #{labels.count}, bna overall #{bna.count})"
