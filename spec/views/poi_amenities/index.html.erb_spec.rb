require 'rails_helper'

RSpec.describe "poi_amenities/index", type: :view do
  before(:each) do
    assign(:poi_amenities, [
      PoiAmenity.create!(
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
      ),
      PoiAmenity.create!(
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
      )
    ])
  end

  it "renders a list of poi_amenities" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
    assert_select "tr>td", :text => 13.to_s, :count => 2
    assert_select "tr>td", :text => 14.to_s, :count => 2
    assert_select "tr>td", :text => 15.to_s, :count => 2
    assert_select "tr>td", :text => 16.to_s, :count => 2
    assert_select "tr>td", :text => 17.to_s, :count => 2
    assert_select "tr>td", :text => 18.to_s, :count => 2
    assert_select "tr>td", :text => 19.to_s, :count => 2
    assert_select "tr>td", :text => 20.to_s, :count => 2
    assert_select "tr>td", :text => 21.to_s, :count => 2
    assert_select "tr>td", :text => 22.to_s, :count => 2
    assert_select "tr>td", :text => 23.to_s, :count => 2
    assert_select "tr>td", :text => 24.to_s, :count => 2
    assert_select "tr>td", :text => 25.to_s, :count => 2
    assert_select "tr>td", :text => 26.to_s, :count => 2
    assert_select "tr>td", :text => 27.to_s, :count => 2
    assert_select "tr>td", :text => 28.to_s, :count => 2
    assert_select "tr>td", :text => 29.to_s, :count => 2
    assert_select "tr>td", :text => 30.to_s, :count => 2
    assert_select "tr>td", :text => 31.to_s, :count => 2
    assert_select "tr>td", :text => 32.to_s, :count => 2
    assert_select "tr>td", :text => 33.to_s, :count => 2
    assert_select "tr>td", :text => 34.to_s, :count => 2
    assert_select "tr>td", :text => 35.to_s, :count => 2
    assert_select "tr>td", :text => 36.to_s, :count => 2
    assert_select "tr>td", :text => 37.to_s, :count => 2
    assert_select "tr>td", :text => 38.to_s, :count => 2
    assert_select "tr>td", :text => 39.to_s, :count => 2
    assert_select "tr>td", :text => 40.to_s, :count => 2
    assert_select "tr>td", :text => 41.to_s, :count => 2
    assert_select "tr>td", :text => 42.to_s, :count => 2
    assert_select "tr>td", :text => 43.to_s, :count => 2
    assert_select "tr>td", :text => 44.to_s, :count => 2
    assert_select "tr>td", :text => 45.to_s, :count => 2
    assert_select "tr>td", :text => 46.to_s, :count => 2
  end
end
