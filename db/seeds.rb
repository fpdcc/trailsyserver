# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ADMIN_USER = (ENV["DEFAULT_ADMIN_USER"] || "admin@example.com").freeze
PASSWORD   = (ENV["DEFAULT_ADMIN_PASSWORD"] || "password").freeze
#MPSSC_USER = (ENV["DEFAULT_MPSSC_USER"] || "mpssc@example.com").freeze
#NPS_USER   = (ENV["TEST_NPS_USER"] || "nps@example.com").freeze

fpdcc = Organization.create({
  code: "FPDCC",
  full_name: "Cook County Forest Preserves",
  phone: "",
  url: ""
  })

admin = User.find_by(email: ADMIN_USER.dup)
admin.destroy unless admin.nil?
User.create({ 
  email: ADMIN_USER.dup,
  admin: true,
  approved: true,
  password: PASSWORD.dup,
  password_confirmation: PASSWORD.dup,
  role: "admin"
  })
