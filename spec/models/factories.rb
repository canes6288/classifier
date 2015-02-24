Factory.define :respondent do |respondent|
  respondent.first_name Faker::Name::first_name
  respondent.last_name Faker::Name::last_name
  respondent.sequence(:email) {|n| "respondent#{n}@blow.com" }
end
