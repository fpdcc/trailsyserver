require 'rails_helper'

RSpec.describe "trails_descs/show", type: :view do
  before(:each) do
    @trails_desc = assign(:trails_desc, TrailsDesc.create!(
      :trail_desc_id => 2,
      :trail_subsystem => "Trail Subsystem",
      :alt_name => "Alt Name",
      :trail_desc => "Trail Desc",
      :map_link => "Map Link",
      :map_link_spanish => "Map Link Spanish"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Trail Subsystem/)
    expect(rendered).to match(/Alt Name/)
    expect(rendered).to match(/Trail Desc/)
    expect(rendered).to match(/Map Link/)
    expect(rendered).to match(/Map Link Spanish/)
  end
end
