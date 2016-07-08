require 'rails_helper'

RSpec.describe "poi_infos/index", type: :view do
  before(:each) do
    assign(:poi_infos, [
      PoiInfo.create!(
        :poi_info_id => 2,
        :point_type => "Point Type",
        :addr => "Addr",
        :zip => "Zip",
        :zipmuni => "Zipmuni",
        :municipality => "Municipality",
        :public_access => "Public Access",
        :latitude => "9.99",
        :longitude => "9.99",
        :commdist => 3,
        :zone_name => "Zone Name",
        :zonemapno => 4,
        :dwmapno => 5,
        :nameid => 6,
        :pointsofinterest_id => 7,
        :fpd_uid => 8,
        :web_poi => "Web Poi",
        :web_street_addr => "Web Street Addr",
        :web_muni_addr => "Web Muni Addr",
        :parking_connection_id => 9,
        :parking_info_id => 10,
        :alt_nameid => 11,
        :alt2_nameid => 12
      ),
      PoiInfo.create!(
        :poi_info_id => 2,
        :point_type => "Point Type",
        :addr => "Addr",
        :zip => "Zip",
        :zipmuni => "Zipmuni",
        :municipality => "Municipality",
        :public_access => "Public Access",
        :latitude => "9.99",
        :longitude => "9.99",
        :commdist => 3,
        :zone_name => "Zone Name",
        :zonemapno => 4,
        :dwmapno => 5,
        :nameid => 6,
        :pointsofinterest_id => 7,
        :fpd_uid => 8,
        :web_poi => "Web Poi",
        :web_street_addr => "Web Street Addr",
        :web_muni_addr => "Web Muni Addr",
        :parking_connection_id => 9,
        :parking_info_id => 10,
        :alt_nameid => 11,
        :alt2_nameid => 12
      )
    ])
  end

  it "renders a list of poi_infos" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Point Type".to_s, :count => 2
    assert_select "tr>td", :text => "Addr".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => "Zipmuni".to_s, :count => 2
    assert_select "tr>td", :text => "Municipality".to_s, :count => 2
    assert_select "tr>td", :text => "Public Access".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Zone Name".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => "Web Poi".to_s, :count => 2
    assert_select "tr>td", :text => "Web Street Addr".to_s, :count => 2
    assert_select "tr>td", :text => "Web Muni Addr".to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
  end
end
