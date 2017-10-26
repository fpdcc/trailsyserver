require 'rails_helper'

RSpec.describe "trails_descs/index", type: :view do
  before(:each) do
    assign(:trails_descs, [
      TrailsDesc.create!(
        :trail_desc_id => 2,
        :trail_subsystem => "Trail Subsystem",
        :alt_name => "Alt Name",
        :trail_desc => "Trail Desc",
        :map_link => "Map Link",
        :map_link_spanish => "Map Link Spanish"
      ),
      TrailsDesc.create!(
        :trail_desc_id => 2,
        :trail_subsystem => "Trail Subsystem",
        :alt_name => "Alt Name",
        :trail_desc => "Trail Desc",
        :map_link => "Map Link",
        :map_link_spanish => "Map Link Spanish"
      )
    ])
  end

  it "renders a list of trails_descs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Trail Subsystem".to_s, :count => 2
    assert_select "tr>td", :text => "Alt Name".to_s, :count => 2
    assert_select "tr>td", :text => "Trail Desc".to_s, :count => 2
    assert_select "tr>td", :text => "Map Link".to_s, :count => 2
    assert_select "tr>td", :text => "Map Link Spanish".to_s, :count => 2
  end
end
