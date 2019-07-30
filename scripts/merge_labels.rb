# coding: utf-8
# merge okpower and gruenstrom

require 'csv'

gs = CSV.read("../cleaned_data/gruenstrom-cleaned-2019-07-30.csv", headers: true)
op = CSV.read("../cleaned_data/okpower-cleaned-2019-07-30.csv", headers: true)

comb = Hash.new(false)

puts "Start merge\n\n"

op.each do |record|
  if comb[record["Anbieter"]] == false
    comb[record["Anbieter"]] = {
      provider: record["Anbieter"],
      tarif: record["Tarif"],
      address: record["Adresse"],
      phone: record["Telefon"],
      website: record["Website"],
      okpower: true
    }
  else
    puts "Already listed in dataset: #{record['Anbieter']}"
  end
end

gs.each do |record|
  if comb[record["Anbieter"]] != false
    comb[record["Anbieter"]][:availability] = record["Verfügbarkeit"],
    comb[record["Anbieter"]][:gruenstrom] = true

    puts "Found match, enhancing data for: #{ record['Anbieter'] }"
  else
    comb[record["Anbieter"]] = {
      provider: record["Anbieter"],
      tarif: record["Tarif"],
      availability: record["Verfügbarkeit"],
      phone: record["Telefon"],
      website: record["Website"],
      gruenstrom: true
    }
  end
end

comb = comb.sort_by { |k,v| v[:provider] }

CSV.open("labels-merged.csv", "w") do |csv|
  csv << ["Anbieter",
          "Telefon",
          "Website",
          "Adresse",
          "Verfügbarkeit",
          "Ok Power",
          "Grünstrom"]

  comb.each do |k,v|
    csv << [v[:provider],
            v[:phone],
            v[:website],
            v[:address],
            v[:availability],
            v[:okpower],
            v[:gruenstrom]]
  end
end

puts "\nResults:"
puts "Merged dataset count: #{comb.count} (individual total count: #{gs.count + op.count})"
