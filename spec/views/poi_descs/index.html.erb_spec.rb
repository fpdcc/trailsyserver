require 'rails_helper'

RSpec.describe "poi_descs/index", type: :view do
  before(:each) do
    assign(:poi_descs, [
      PoiDesc.create!(
        :poi_info_id => 2,
        :hours1 => "Hours1",
        :hours2 => "Hours2",
        :phone => "Phone",
        :description => "Description",
        :web_link => "Web Link",
        :map_link => "Map Link",
        :map_link_spanish => "Map Link Spanish",
        :vol_link => "Vol Link",
        :vol_link2 => "Vol Link2",
        :picnic_link => "Picnic Link",
        :event_link => "Event Link",
        :custom_link => "Custom Link",
        :season1 => "Season1",
        :season2 => "Season2",
        :special_hours => "Special Hours",
        :special_description => "Special Description",
        :special_link => "Special Link",
        :photo_link => "Photo Link",
        :poi_desc_id => 3
      ),
      PoiDesc.create!(
        :poi_info_id => 2,
        :hours1 => "Hours1",
        :hours2 => "Hours2",
        :phone => "Phone",
        :description => "Description",
        :web_link => "Web Link",
        :map_link => "Map Link",
        :map_link_spanish => "Map Link Spanish",
        :vol_link => "Vol Link",
        :vol_link2 => "Vol Link2",
        :picnic_link => "Picnic Link",
        :event_link => "Event Link",
        :custom_link => "Custom Link",
        :season1 => "Season1",
        :season2 => "Season2",
        :special_hours => "Special Hours",
        :special_description => "Special Description",
        :special_link => "Special Link",
        :photo_link => "Photo Link",
        :poi_desc_id => 3
      )
    ])
  end

  it "renders a list of poi_descs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Hours1".to_s, :count => 2
    assert_select "tr>td", :text => "Hours2".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Web Link".to_s, :count => 2
    assert_select "tr>td", :text => "Map Link".to_s, :count => 2
    assert_select "tr>td", :text => "Map Link Spanish".to_s, :count => 2
    assert_select "tr>td", :text => "Vol Link".to_s, :count => 2
    assert_select "tr>td", :text => "Vol Link2".to_s, :count => 2
    assert_select "tr>td", :text => "Picnic Link".to_s, :count => 2
    assert_select "tr>td", :text => "Event Link".to_s, :count => 2
    assert_select "tr>td", :text => "Custom Link".to_s, :count => 2
    assert_select "tr>td", :text => "Season1".to_s, :count => 2
    assert_select "tr>td", :text => "Season2".to_s, :count => 2
    assert_select "tr>td", :text => "Special Hours".to_s, :count => 2
    assert_select "tr>td", :text => "Special Description".to_s, :count => 2
    assert_select "tr>td", :text => "Special Link".to_s, :count => 2
    assert_select "tr>td", :text => "Photo Link".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
