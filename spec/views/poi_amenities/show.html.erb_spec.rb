require 'rails_helper'

RSpec.describe "poi_amenities/show", type: :view do
  before(:each) do
    @poi_amenity = assign(:poi_amenity, PoiAmenity.create!(
      :poi_info_id => 2,
      :ada => 3,
      :bike_parking => 4,
      :bike_rental => 5,
      :birding => 6,
      :boat_ramp => 7,
      :boat_rental => 8,
      :camping => 9,
      :canoe => 10,
      :comfortstation => 11,
      :cross_country => 12,
      :cycling => 13,
      :disc_golf => 14,
      :dog_friendly => 15,
      :dog_leash => 16,
      :drinkingwater => 17,
      :drone => 18,
      :ecological => 19,
      :equestrian => 20,
      :fishing => 21,
      :ice_fishing => 22,
      :gas_powered => 23,
      :golf => 24,
      :hiking => 25,
      :indoor_rental => 26,
      :large_capacity => 27,
      :m_airplane => 28,
      :m_boat => 29,
      :nature_center => 30,
      :natureplay => 31,
      :no_alcohol => 32,
      :no_parking => 33,
      :overlook => 34,
      :pavillion => 35,
      :picnic_grove => 36,
      :shelter => 37,
      :skating_ice => 38,
      :skating_inline => 39,
      :sledding => 40,
      :snowmobile => 41,
      :swimming => 42,
      :toboggan => 43,
      :volunteer => 44,
      :zip_line => 45,
      :poi_amenity_id => 46
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
    expect(rendered).to match(/12/)
    expect(rendered).to match(/13/)
    expect(rendered).to match(/14/)
    expect(rendered).to match(/15/)
    expect(rendered).to match(/16/)
    expect(rendered).to match(/17/)
    expect(rendered).to match(/18/)
    expect(rendered).to match(/19/)
    expect(rendered).to match(/20/)
    expect(rendered).to match(/21/)
    expect(rendered).to match(/22/)
    expect(rendered).to match(/23/)
    expect(rendered).to match(/24/)
    expect(rendered).to match(/25/)
    expect(rendered).to match(/26/)
    expect(rendered).to match(/27/)
    expect(rendered).to match(/28/)
    expect(rendered).to match(/29/)
    expect(rendered).to match(/30/)
    expect(rendered).to match(/31/)
    expect(rendered).to match(/32/)
    expect(rendered).to match(/33/)
    expect(rendered).to match(/34/)
    expect(rendered).to match(/35/)
    expect(rendered).to match(/36/)
    expect(rendered).to match(/37/)
    expect(rendered).to match(/38/)
    expect(rendered).to match(/39/)
    expect(rendered).to match(/40/)
    expect(rendered).to match(/41/)
    expect(rendered).to match(/42/)
    expect(rendered).to match(/43/)
    expect(rendered).to match(/44/)
    expect(rendered).to match(/45/)
    expect(rendered).to match(/46/)
  end
end
