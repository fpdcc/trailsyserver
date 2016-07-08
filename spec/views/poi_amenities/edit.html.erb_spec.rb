require 'rails_helper'

RSpec.describe "poi_amenities/edit", type: :view do
  before(:each) do
    @poi_amenity = assign(:poi_amenity, PoiAmenity.create!(
      :poi_info_id => 1,
      :ada => 1,
      :bike_parking => 1,
      :bike_rental => 1,
      :birding => 1,
      :boat_ramp => 1,
      :boat_rental => 1,
      :camping => 1,
      :canoe => 1,
      :comfortstation => 1,
      :cross_country => 1,
      :cycling => 1,
      :disc_golf => 1,
      :dog_friendly => 1,
      :dog_leash => 1,
      :drinkingwater => 1,
      :drone => 1,
      :ecological => 1,
      :equestrian => 1,
      :fishing => 1,
      :ice_fishing => 1,
      :gas_powered => 1,
      :golf => 1,
      :hiking => 1,
      :indoor_rental => 1,
      :large_capacity => 1,
      :m_airplane => 1,
      :m_boat => 1,
      :nature_center => 1,
      :natureplay => 1,
      :no_alcohol => 1,
      :no_parking => 1,
      :overlook => 1,
      :pavillion => 1,
      :picnic_grove => 1,
      :shelter => 1,
      :skating_ice => 1,
      :skating_inline => 1,
      :sledding => 1,
      :snowmobile => 1,
      :swimming => 1,
      :toboggan => 1,
      :volunteer => 1,
      :zip_line => 1,
      :poi_amenity_id => 1
    ))
  end

  it "renders the edit poi_amenity form" do
    render

    assert_select "form[action=?][method=?]", poi_amenity_path(@poi_amenity), "post" do

      assert_select "input#poi_amenity_poi_info_id[name=?]", "poi_amenity[poi_info_id]"

      assert_select "input#poi_amenity_ada[name=?]", "poi_amenity[ada]"

      assert_select "input#poi_amenity_bike_parking[name=?]", "poi_amenity[bike_parking]"

      assert_select "input#poi_amenity_bike_rental[name=?]", "poi_amenity[bike_rental]"

      assert_select "input#poi_amenity_birding[name=?]", "poi_amenity[birding]"

      assert_select "input#poi_amenity_boat_ramp[name=?]", "poi_amenity[boat_ramp]"

      assert_select "input#poi_amenity_boat_rental[name=?]", "poi_amenity[boat_rental]"

      assert_select "input#poi_amenity_camping[name=?]", "poi_amenity[camping]"

      assert_select "input#poi_amenity_canoe[name=?]", "poi_amenity[canoe]"

      assert_select "input#poi_amenity_comfortstation[name=?]", "poi_amenity[comfortstation]"

      assert_select "input#poi_amenity_cross_country[name=?]", "poi_amenity[cross_country]"

      assert_select "input#poi_amenity_cycling[name=?]", "poi_amenity[cycling]"

      assert_select "input#poi_amenity_disc_golf[name=?]", "poi_amenity[disc_golf]"

      assert_select "input#poi_amenity_dog_friendly[name=?]", "poi_amenity[dog_friendly]"

      assert_select "input#poi_amenity_dog_leash[name=?]", "poi_amenity[dog_leash]"

      assert_select "input#poi_amenity_drinkingwater[name=?]", "poi_amenity[drinkingwater]"

      assert_select "input#poi_amenity_drone[name=?]", "poi_amenity[drone]"

      assert_select "input#poi_amenity_ecological[name=?]", "poi_amenity[ecological]"

      assert_select "input#poi_amenity_equestrian[name=?]", "poi_amenity[equestrian]"

      assert_select "input#poi_amenity_fishing[name=?]", "poi_amenity[fishing]"

      assert_select "input#poi_amenity_ice_fishing[name=?]", "poi_amenity[ice_fishing]"

      assert_select "input#poi_amenity_gas_powered[name=?]", "poi_amenity[gas_powered]"

      assert_select "input#poi_amenity_golf[name=?]", "poi_amenity[golf]"

      assert_select "input#poi_amenity_hiking[name=?]", "poi_amenity[hiking]"

      assert_select "input#poi_amenity_indoor_rental[name=?]", "poi_amenity[indoor_rental]"

      assert_select "input#poi_amenity_large_capacity[name=?]", "poi_amenity[large_capacity]"

      assert_select "input#poi_amenity_m_airplane[name=?]", "poi_amenity[m_airplane]"

      assert_select "input#poi_amenity_m_boat[name=?]", "poi_amenity[m_boat]"

      assert_select "input#poi_amenity_nature_center[name=?]", "poi_amenity[nature_center]"

      assert_select "input#poi_amenity_natureplay[name=?]", "poi_amenity[natureplay]"

      assert_select "input#poi_amenity_no_alcohol[name=?]", "poi_amenity[no_alcohol]"

      assert_select "input#poi_amenity_no_parking[name=?]", "poi_amenity[no_parking]"

      assert_select "input#poi_amenity_overlook[name=?]", "poi_amenity[overlook]"

      assert_select "input#poi_amenity_pavillion[name=?]", "poi_amenity[pavillion]"

      assert_select "input#poi_amenity_picnic_grove[name=?]", "poi_amenity[picnic_grove]"

      assert_select "input#poi_amenity_shelter[name=?]", "poi_amenity[shelter]"

      assert_select "input#poi_amenity_skating_ice[name=?]", "poi_amenity[skating_ice]"

      assert_select "input#poi_amenity_skating_inline[name=?]", "poi_amenity[skating_inline]"

      assert_select "input#poi_amenity_sledding[name=?]", "poi_amenity[sledding]"

      assert_select "input#poi_amenity_snowmobile[name=?]", "poi_amenity[snowmobile]"

      assert_select "input#poi_amenity_swimming[name=?]", "poi_amenity[swimming]"

      assert_select "input#poi_amenity_toboggan[name=?]", "poi_amenity[toboggan]"

      assert_select "input#poi_amenity_volunteer[name=?]", "poi_amenity[volunteer]"

      assert_select "input#poi_amenity_zip_line[name=?]", "poi_amenity[zip_line]"

      assert_select "input#poi_amenity_poi_amenity_id[name=?]", "poi_amenity[poi_amenity_id]"
    end
  end
end
