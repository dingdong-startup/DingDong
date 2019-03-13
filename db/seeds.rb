# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Property.destroy_all 
# ActiveRecord::Base.connection.reset_pk_sequence!('properties')
# Area.destroy_all 
# ActiveRecord::Base.connection.reset_pk_sequence!('areas')
# Tenant.destroy_all 
# ActiveRecord::Base.connection.reset_pk_sequence!('tenants')
# RequirementList.destroy_all 
# ActiveRecord::Base.connection.reset_pk_sequence!('requirement_lists')
Agency.destroy_all 
ActiveRecord::Base.connection.reset_pk_sequence!('agencies')
Position.destroy_all 
ActiveRecord::Base.connection.reset_pk_sequence!('positions')
Agent.destroy_all 
ActiveRecord::Base.connection.reset_pk_sequence!('agents')
# Visit.destroy_all 
# ActiveRecord::Base.connection.reset_pk_sequence!('visits')


# v = VisitStatus.new(name: "Pending")
# v.save


# 10.times do
#   t = Tenant.new(first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   stripe_customer_id: nil) 
#   t.save
# end

3.times do 
  a = Area.new(name: Faker::Address.city,
    zipcode: Faker::Address.zip_code)
  a.save
end

5.times do 
  # r = RequirementList.new(flat_sharing: Faker::Boolean.boolean,
  #   warrant: Faker::Boolean.boolean,
  #   min_revenu: rand(700.1500)*3)
  # r.save 
  
  a = Agency.new(name: Faker::Company.name,
    address: Faker::Address.full_address,
    phone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    password: "TEST123",
    monthly_properties: rand(5..40))
  a.save

  p = Position.new(title: Faker::Company.profession)
  p.save 

  b = Agent.new(first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  email: Faker::Internet.email,
  cellphone: Faker::PhoneNumber.cell_phone,
  position_id: p.id,
  agency_id: a.id)
  b.save
end 


20.times do 

  p = Property.new(
    title: Faker::Address.full_address,
    price: rand(600..3000),
    surface: rand(9..150),
    description: Faker::Company.bs,
    agency_id: rand(1..5),
    agent_id: rand(1..5),
    floor: rand(1..9),
    room: rand(1..4),
    area_id: rand(1..3),
    available_date: Faker::Date.forward(rand(10..50)),
    address: Faker::Address.street_address)
  p.images.attached(io: File.open('/app/assets/images'), filename: 'photo1.jpg')
  
  p.save


#   3.times do 
#     v = Visit.new(time_id: Faker::Date.forward(rand(2..6)),
#       property_id: p.id,
#       tenant_id: rand(1..10),
#       visit_status_id: 1)
#   end
end


