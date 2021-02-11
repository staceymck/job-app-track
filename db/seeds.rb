#Create users
User.create(username: "Hunter_1", password: "123", password_confirmation: "123")
User.create(username: "Search54", password: "1234", password_confirmation: "1234")
User.create(username: "Candidate23", password: "12345", password_confirmation: "12345")

#Create 10 job apps per user
User.all.each do |user|
  10.times do
    JobApp.create(
      job_title: Faker::Job.title,
      job_description: Faker::Internet.url,
      company_name: Faker::Company.name,
      company_location: Faker::Address.city,
      contact_name: Faker::Name.name,
      contact_title: Faker::Job.title,
      contact_phone: Faker::PhoneNumber.phone_number,
      contact_email: Faker::Internet.email,
      app_status: Faker::Number.between(from: 0, to: 5),
      offer_decision: 0, #default to NA and change later based on random app_status assigned
      notes: Faker::Lorem.paragraphs(number: 5).join(" "),
      user_id: user.id
    )
  end
end

#Add date_applied only to applications past the "interested" status
#Add accepted/declined offer_decision value only to apps in the "offer_made" status
JobApp.all.each do |app|
  if !app.interested?
    app.date_applied = Faker::Date.backward(days: 30)
  end

  if app.offer?
    app.offer_decision = "declined"
  end
  app.save
end

User.all.each do |user|
  app_with_offer = user.job_apps.offer
  app_with_offer.offer_decision = "accepted" if app_with_offer
  app_with_offer.save
end

#Create 1 follow-up action for each non-accepted app
User.all.each do |user|
  user.job_apps.each do |app|
    unless app.accepted?
      app.follow_ups.create(
        action: Faker::Lorem.sentence,
        complete_by: Faker::Date.forward(days: 7),
        action_status: Faker::Number.between(from: 0, to: 1)
      )
    end
  end
end