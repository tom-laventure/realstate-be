# db/seeds.rb

# Creating Users
user1 = User.create!(
  email: 'user1@example.com',
  password: 'password',
  name: 'John Doe',
  jti: SecureRandom.uuid
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'password',
  name: 'Jane Smith',
  jti: SecureRandom.uuid
)

user3 = User.create!(
  email: 'user3@example.com',
  password: 'password',
  name: 'Jane Doeseph',
  jti: SecureRandom.uuid
)

# Creating Groups
group1 = Group.create!(
  name: 'Luxury Estates',
)

group2 = Group.create!(
  name: 'Affordable Homes',
)

# Creating Estates
estate1 = Estate.create!(
  header: 'Luxury Mansion in Beverly Hills',
  link: 'https://example.com/mansion',
  group: group1
)

estate2 = Estate.create!(
  header: 'Cozy Cottage in the Countryside',
  link: 'https://example.com/cottage',
  group: group2
)

# Adding Users to Groups (UserGroups)
UserGroup.create!(
  user: user1,
  group: group1
)

UserGroup.create!(
  user: user2,
  group: group2
)

UserGroup.create!(
    user: user3,
    group: group2
)

# Creating Estate Ratings
EstateRating.create!(
  rating: 4.5,
  user: user1,
  estate: estate1
)

EstateRating.create!(
  rating: 3.8,
  user: user2,
  estate: estate2
)

# Creating Estate Comments
EstateComment.create!(
  user: user1,
  estate: estate1,
  comment_type: 'good',
  comment: 'This estate is absolutely stunning!'
)

EstateComment.create!(
  user: user2,
  estate: estate2,
  comment_type: 'good',
  comment: 'This cottage is perfect for a quiet weekend getaway.'
)

puts "Seed data created successfully!"