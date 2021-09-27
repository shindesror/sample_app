# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Invoice.create client_name: Faker::Name.name,
                 amount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
                 tax: [nil, 8, 12, 30].sample
end
