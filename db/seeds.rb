@seedproperty1# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Property.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('properties')
Area.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('areas')
Tenant.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('tenants')
Agency.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('agencies')
Position.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('positions')
Agent.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('agents')
PaymentStatus.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('payment_statuses')
Visit.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('visits')
VisitStatus.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('visit_statuses')
Favorite.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('favorites')


v1 = VisitStatus.new(title: "Unfavorite")
v1.save
v2 = VisitStatus.new(title: "Favorite")
v2.save
v3 = VisitStatus.new(title: "Demanded Visit")
v3.save
v4 = VisitStatus.new(title: "Visit Accepted")
v4.save
v5 = VisitStatus.new(title: "Visit Done")
v5.save
v6 = VisitStatus.new(title: "Location Successful")
v6.save

p1 = PaymentStatus.new(title: 'No Card')
p2 = PaymentStatus.new(title: 'Card Saved')
p3 = PaymentStatus.new(title: 'Card Debited')
p1.save
p2.save
p3.save

10.times do
  t = Tenant.new(first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "test123",
    stripe_customer_id: nil,
    payment_status_id: rand(1..3))
    t.save
  end



  5.times do

    a = Agency.new(name: Faker::Company.name,
      address: Faker::Address.full_address,
      phone: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email,
      password: "TEST123",
      monthly_properties: rand(5..40))
      a.save

      po=Position.new(title: Faker::Company.profession)
      po.save

      b = Agent.new(first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        cellphone: Faker::PhoneNumber.cell_phone,
        position_id: p.id,
        agency_id: a.id)
        b.save
      end




      puts "je suis la 1"
      @seed_property = Scrapper.new.perform
      puts @seed_property

      @seed_property.each do |property|

        ar = Area.new(
          name:property.fetch("area_name"),
          zipcode:property.fetch("zipcode"))
          ar.save
          puts "je suis la 2"
          pr = Property.new(
            title: property.fetch("title"),
            price: property.fetch("price"),
            surface: property.fetch("surface"),
            description: property.fetch("title"),
            agency_id: rand(1..5),
            agent_id: rand(1..5),
            floor: property.fetch("floor"),
            room: property.fetch("room"),
            area_id: ar.id,
            available_date: Faker::Date.forward(rand(10..50)),
            address: property.fetch("address"))
            pr.images.attach(io: File.open("app/assets/images/"+ property.fetch("images")[0]+".jpg"), filename: property.fetch("images")[0], content_type: 'image/jpg')
            pr.images.attach(io: File.open("app/assets/images/"+ property.fetch("images")[1]+".jpg"), filename: property.fetch("images")[0], content_type: 'image/jpg')
            pr.images.attach(io: File.open("app/assets/images/"+ property.fetch("images")[2]+".jpg"), filename: property.fetch("images")[0], content_type: 'image/jpg')
            pr.images.attach(io: File.open("app/assets/images/"+ property.fetch("images")[3]+".jpg"), filename: property.fetch("images")[0], content_type: 'image/jpg')
            pr.images.attach(io: File.open("app/assets/images/"+ property.fetch("images")[4]+".jpg"), filename: property.fetch("images")[0], content_type: 'image/jpg')
            pr.save
            puts "je suis la 3"
            puts property
          end
