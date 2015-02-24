# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Respondent.destroy_all
Prediction.destroy_all

Respondent.create(gender: 'male', height: 6, weight: 180)
Respondent.create(gender: 'male', height: 6, weight: 180)
Respondent.create(gender: 'female', height: 5, weight: 130)
Respondent.create(gender: 'female', height: 5, weight: 150)
Respondent.create(gender: 'female', height: 5, weight: 150)
Respondent.create(gender: 'female', height: 6, weight: 100)
Respondent.create(gender: 'male', height: 5, weight: 190)
Respondent.create(gender: 'male', height: 5, weight: 165)
