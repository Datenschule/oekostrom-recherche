# coding: utf-8
# merge labels and Verbraucherzentrale Niedersachsen

require 'csv'

labels = CSV.read("../raw_data/eum-merged-added-2019-07-31.csv", headers: true)
vbzns = CSV.read("../cleaned_data/Uebersicht_Oekostromtarife_niedersaechsischer_Grundversorger-cleaned-2019-08-05.csv", headers: true)

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
    eum: record["Energie&Management"],
    vbzns: false
  }
end

vbzns.each do |record|
  if comb[record["Energieversorgungsunternehmen (EVU)"].downcase] != false
    puts "Found match: #{ record['Energieversorgungsunternehmen (EVU)'] }"
    comb[record["Energieversorgungsunternehmen (EVU)"].downcase][:vbzns] = true
  else
    comb[record["Energieversorgungsunternehmen (EVU)"].downcase] = {
      provider: record["Energieversorgungsunternehmen (EVU)"]
    }
    comb[record["Energieversorgungsunternehmen (EVU)"].downcase][:vbzns] = true
  end

end

comb = comb.sort_by { |k,v| v[:provider] }

CSV.open("vbzns-merged.csv", "w") do |csv|
  csv << ["Anbieter",
          "Telefon",
          "Website",
          "Adresse",
          "Verfügbarkeit",
          "Ok Power",
          "Grünstrom",
          "Energie&Management",
          "Verbraucherschutz Niedersachsen"]

  comb.each do |k,v|
    csv << [v[:provider],
            v[:phone],
            v[:website],
            v[:address],
            v[:availability],
            v[:okpower],
            v[:gruenstrom],
            v[:eum],
            v[:vbzns]]
  end
end

puts "\nResults:"
puts "Merged dataset count: #{comb.count} (individual total count: #{labels.count + vbzns.count})"
