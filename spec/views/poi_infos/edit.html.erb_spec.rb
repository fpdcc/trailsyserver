require 'rails_helper'

RSpec.describe "poi_infos/edit", type: :view do
  before(:each) do
    @poi_info = assign(:poi_info, PoiInfo.create!(
      :poi_info_id => 1,
      :point_type => "MyString",
      :addr => "MyString",
      :zip => "MyString",
      :zipmuni => "MyString",
      :municipality => "MyString",
      :public_access => "MyString",
      :latitude => "9.99",
      :longitude => "9.99",
      :commdist => 1,
      :zone_name => "MyString",
      :zonemapno => 1,
      :dwmapno => 1,
      :nameid => 1,
      :pointsofinterest_id => 1,
      :fpd_uid => 1,
      :web_poi => "MyString",
      :web_street_addr => "MyString",
      :web_muni_addr => "MyString",
      :parking_connection_id => 1,
      :parking_info_id => 1,
      :alt_nameid => 1,
      :alt2_nameid => 1
    ))
  end

  it "renders the edit poi_info form" do
    render

    assert_select "form[action=?][method=?]", poi_info_path(@poi_info), "post" do

      assert_select "input#poi_info_poi_info_id[name=?]", "poi_info[poi_info_id]"

      assert_select "input#poi_info_point_type[name=?]", "poi_info[point_type]"

      assert_select "input#poi_info_addr[name=?]", "poi_info[addr]"

      assert_select "input#poi_info_zip[name=?]", "poi_info[zip]"

      assert_select "input#poi_info_zipmuni[name=?]", "poi_info[zipmuni]"

      assert_select "input#poi_info_municipality[name=?]", "poi_info[municipality]"

      assert_select "input#poi_info_public_access[name=?]", "poi_info[public_access]"

      assert_select "input#poi_info_latitude[name=?]", "poi_info[latitude]"

      assert_select "input#poi_info_longitude[name=?]", "poi_info[longitude]"

      assert_select "input#poi_info_commdist[name=?]", "poi_info[commdist]"

      assert_select "input#poi_info_zone_name[name=?]", "poi_info[zone_name]"

      assert_select "input#poi_info_zonemapno[name=?]", "poi_info[zonemapno]"

      assert_select "input#poi_info_dwmapno[name=?]", "poi_info[dwmapno]"

      assert_select "input#poi_info_nameid[name=?]", "poi_info[nameid]"

      assert_select "input#poi_info_pointsofinterest_id[name=?]", "poi_info[pointsofinterest_id]"

      assert_select "input#poi_info_fpd_uid[name=?]", "poi_info[fpd_uid]"

      assert_select "input#poi_info_web_poi[name=?]", "poi_info[web_poi]"

      assert_select "input#poi_info_web_street_addr[name=?]", "poi_info[web_street_addr]"

      assert_select "input#poi_info_web_muni_addr[name=?]", "poi_info[web_muni_addr]"

      assert_select "input#poi_info_parking_connection_id[name=?]", "poi_info[parking_connection_id]"

      assert_select "input#poi_info_parking_info_id[name=?]", "poi_info[parking_info_id]"

      assert_select "input#poi_info_alt_nameid[name=?]", "poi_info[alt_nameid]"

      assert_select "input#poi_info_alt2_nameid[name=?]", "poi_info[alt2_nameid]"
    end
  end
end
