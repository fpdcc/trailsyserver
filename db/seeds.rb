# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ADMIN_USER = (ENV["DEFAULT_ADMIN_USER"] || "admin@example.com").freeze
PASSWORD   = (ENV["DEFAULT_ADMIN_PASSWORD"] || "mYpaSS512%").freeze
LEVEL1_USER = (ENV["DEFAULT_LEVEL1_USER"] || "level1@example.com").freeze
LEVEL2_USER = (ENV["DEFAULT_LEVEL2_USER"] || "level2@example.com").freeze
LEVELUNKNOWN_USER = (ENV["DEFAULT_LEVELUNKNOWN_USER"] || "levelUnknown@example.com").freeze


#NPS_USER   = (ENV["TEST_NPS_USER"] || "nps@example.com").freeze

fpdcc = Organization.create({
  code: "FPDCC",
  full_name: "Cook County Forest Preserves",
  phone: "",
  url: ""
  })

admin = User.find_by(email: ADMIN_USER.dup)
admin.destroy unless admin.nil?
User.create!({ 
  email: ADMIN_USER.dup,
  admin: true,
  approved: true,
  password: PASSWORD.dup,
  password_confirmation: PASSWORD.dup,
  role: "admin"
  })

level1 = User.find_by(email: LEVEL1_USER.dup)
level1.destroy unless level1.nil?
User.create({ 
  email: LEVEL1_USER.dup,
  approved: true,
  password: PASSWORD.dup,
  password_confirmation: PASSWORD.dup,
  role: "level1"
  })

level2 = User.find_by(email: LEVEL2_USER.dup)
level2.destroy unless level2.nil?
User.create({ 
  email: LEVEL2_USER.dup,
  approved: true,
  password: PASSWORD.dup,
  password_confirmation: PASSWORD.dup,
  role: "level2"
  })

levelUnknown = User.find_by(email: LEVELUNKNOWN_USER.dup)
levelUnknown.destroy unless levelUnknown.nil?
User.create({ 
  email: LEVELUNKNOWN_USER.dup,
  approved: true,
  password: PASSWORD.dup,
  password_confirmation: PASSWORD.dup,
  role: "unknown"
  })