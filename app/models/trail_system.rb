class TrailSystem < ActiveRecord::Base
  self.per_page = 15

  has_many :alertings, :as => :alertable
  has_many :alerts, :through => :alertings

  accepts_nested_attributes_for :alertings
  accepts_nested_attributes_for :alerts
end
