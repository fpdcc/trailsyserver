require 'rails_helper'

RSpec.describe "poi_descs/show", type: :view do
  before(:each) do
    @poi_desc = assign(:poi_desc, PoiDesc.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Hours1/)
    expect(rendered).to match(/Hours2/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Web Link/)
    expect(rendered).to match(/Map Link/)
    expect(rendered).to match(/Map Link Spanish/)
    expect(rendered).to match(/Vol Link/)
    expect(rendered).to match(/Vol Link2/)
    expect(rendered).to match(/Picnic Link/)
    expect(rendered).to match(/Event Link/)
    expect(rendered).to match(/Custom Link/)
    expect(rendered).to match(/Season1/)
    expect(rendered).to match(/Season2/)
    expect(rendered).to match(/Special Hours/)
    expect(rendered).to match(/Special Description/)
    expect(rendered).to match(/Special Link/)
    expect(rendered).to match(/Photo Link/)
    expect(rendered).to match(/3/)
  end
end
