# db/seeds.rb
include ActionView::Helpers::NumberHelper
require 'faker'

puts "Seeding database..."

# --- Brokerages ---
brokerages = 3.times.map do
  Brokerage.create!(
    id: SecureRandom.uuid,
    name: "#{Faker::Name.last_name} Realty Ltd.",
    mls_id: Faker::Alphanumeric.alphanumeric(number: 6).upcase,
    website: Faker::Internet.url,
    logo_url: Faker::Company.logo,
    contact_email: Faker::Internet.email,
    contact_phone: Faker::PhoneNumber.phone_number
  )
end
puts "Created #{brokerages.count} brokerages."

# --- Agents ---
agents = 5.times.map do
  brokerage = brokerages.sample
  Agent.create!(
    id: SecureRandom.uuid,
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    phone: Faker::PhoneNumber.cell_phone,
    license_number: Faker::Alphanumeric.alphanumeric(number: 8).upcase,
    brokerage_id: brokerage.id,
    photo_url: Faker::Avatar.image
  )
end
puts "Created #{agents.count} agents."

# --- Users ---
users = 5.times.map do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password123',
    name: Faker::Name.name,
    jti: SecureRandom.uuid
  )
end
puts "Created #{users.count} users."

# --- Groups (Collections) ---
groups = 3.times.map do
  Group.create!(
    name: ["Vancouver Condos", "Downtown Rentals", "North Shore Homes"].sample
  )
end
puts "Created #{groups.count} groups."

# --- Add Users to Groups ---
puts "Adding users to groups..."
users.each do |user|
  UserGroup.create!(
    user: user,
    group: groups.sample # Assign each user to one random group
  )
end
puts "Added #{users.count} users to random groups."

# --- Estates ---
estates = 10.times.map do
  agent = agents.sample
  brokerage = brokerages.find { |b| b.id == agent.brokerage_id }
  group = groups.sample

  estate = Estate.create!(
    address: "#{Faker::Address.street_address}, #{Faker::Address.city}",
    link: "https://www.rew.ca/properties/#{Faker::Alphanumeric.alphanumeric(number: 8).upcase}",
    image: Faker::LoremFlickr.image(size: "800x600", search_terms: ['house']),
    price: number_to_currency(
      Faker::Number.between(from: 400_000, to: 1_500_000),
      unit: "$",
      precision: 0
    ),
    mls_number: "R#{Faker::Number.number(digits: 7)}",
    mls_source: ["GVR", "FVREB", "CADREB", "BCNREB"].sample,
    agent_id: agent.id,
    brokerage_id: brokerage.id,
    group_id: group.id,
    is_verified: [true, false].sample
  )

  # --- Listing Details ---
  estate.create_listing_detail!(
    list_price: estate.price,
    gross_taxes: "$#{Faker::Number.between(from: 2000, to: 6000)}",
    strata_fees: ["$200", "$344", "$450"].sample,
    is_pre_approved_available: [true, false].sample,
    bedrooms: Faker::Number.between(from: 1, to: 4),
    full_bathrooms: Faker::Number.between(from: 1, to: 3),
    property_type: ["Apt/Condo", "Townhouse", "House"].sample,
    year_built: Faker::Number.between(from: 1980, to: 2022),
    age: "#{Faker::Number.between(from: 1, to: 40)} yrs old",
    title: ["Freehold Strata", "Leasehold"].sample,
    style: ["Corner Unit", "Ground Level Unit", "Penthouse"].sample,
    heating_type: ["Hot Water", "Radiant", "Forced Air"].sample,
    features: ["In Unit Laundry", "Shopping Nearby", "Private Balcony"].join(', '),
    amenities: ["Bike Room", "Exercise Centre", "Recreation Facilities"].join(', '),
    appliances: ["Dishwasher", "Refrigerator", "Stove", "Washer & Dryer"].join(', '),
    community: ["Lynn Valley", "Kitsilano", "Mount Pleasant"].sample,
    days_on_market: Faker::Number.between(from: 1, to: 45),
    views_count: Faker::Number.between(from: 10, to: 1000),
    mls_number: estate.mls_number,
    mls_source: estate.mls_source,
    board: "Real Estate Board of Greater Vancouver"
  )

  estate
end
puts "Created #{estates.count} estates with listing details."

# --- Comments ---
estates.each do |estate|
  2.times do
    EstateComment.create!(
      user: users.sample,
      estate: estate,
      comment: Faker::Lorem.sentence(word_count: 12),
      comment_type: ["like", "dislike", "neutral"].sample
    )
  end
end
puts "Created estate comments."

# --- Ratings ---
estates.each do |estate|
  users.sample(3).each do |user|
    EstateRating.create!(
      user: user,
      estate: estate,
      rating: Faker::Number.between(from: 3.0, to: 5.0).round(1)
    )
  end
end
puts "Created estate ratings."

# --- Tags ---
tag_names = ["Pet Friendly", "Pool", "Newly Renovated", "Ocean View"]
tags = tag_names.map { |n| Tag.find_or_create_by!(name: n) }

estates.each do |estate|
  EstateTag.create!(
    estate_id: estate.id,
    tag_id: tags.sample.id,
    group_id: estate.group_id
  ) rescue ActiveRecord::RecordInvalid
end
puts "Tagged estates."

puts "✅ Seeding complete!"