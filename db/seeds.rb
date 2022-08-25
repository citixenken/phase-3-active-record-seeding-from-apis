# Ruby code that communicate with API and persist data in our DB
puts "Seeding spells..."

#spells to add to DB
spells = ["acid-arrow", "animal-messenger", "calm-emotions", "charm-person"]

# iterate over each spell
spells.each do |spell|
    # make request to endpoint for individual spell
    response = RestClient.get "https://www.dnd5eapi.co/api/spells/#{spell}"

    # response will come back as JSON-formatted string.
    # use JSON.parse to convert this string to a Ruby hash.
    spell_hash = JSON.parse(response)

    # Create spelll in DB using data from hash
    Spell.create(
        name: spell_hash["name"],
        level: spell_hash["level"],
        description: spell_hash["desc"][0], #array within array
    )
end

puts "Done seeding!"