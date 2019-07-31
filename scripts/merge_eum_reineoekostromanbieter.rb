# coding: utf-8
# merge okpower and gruenstrom

require 'csv'

labels = CSV.read("../raw_data/labels-merged-2019-07-31.csv", headers: true)
eum = CSV.read("../raw_data/Reine_Oekostromanbieter_Liste_2018_Umfrage_Tabelle_EundM.orig.csv", headers: true)

comb = Hash.new(false)

puts "Start merge\n\n"

labels.each do |record|
  comb[record["Anbieter"].downcase] = {
    provider: record["Anbieter"],
    phone: record["Telefon"],
    website: record["Website"],
    address: record["Adresse"],
    availability: record["Verfügbarkeit"],
    okpower: record["Ok Power"],
    gruenstrom: record["Grünstrom"],
    eum: false
  }
end

eum.each do |record|
  if comb[record["name"].downcase] != false
    puts "Found match: #{ record['name'] }"
    comb[record["name"].downcase][:eum] = true
  else
    #comb[record["name"].downcase] = {
    #  provider: record["name"]
    #}
    #comb[record["name"].downcase][:eum] = true
  end

end

comb = comb.sort_by { |k,v| v[:provider] }

CSV.open("eum-merged.csv", "w") do |csv|
  csv << ["Anbieter",
          "Telefon",
          "Website",
          "Adresse",
          "Verfügbarkeit",
          "Ok Power",
          "Grünstrom",
          "Energie&Management"]

  comb.each do |k,v|
    csv << [v[:provider],
            v[:phone],
            v[:website],
            v[:address],
            v[:availability],
            v[:okpower],
            v[:gruenstrom],
            v[:eum]]
  end
end

puts "\nResults:"
puts "Merged dataset count: #{comb.count} (individual total count: #{labels.count + eum.count})"
