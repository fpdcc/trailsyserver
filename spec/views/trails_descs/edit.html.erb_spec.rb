require 'rails_helper'

RSpec.describe "trails_descs/edit", type: :view do
  before(:each) do
    @trails_desc = assign(:trails_desc, TrailsDesc.create!(
      :trail_desc_id => 1,
      :trail_subsystem => "MyString",
      :alt_name => "MyString",
      :trail_desc => "MyString",
      :map_link => "MyString",
      :map_link_spanish => "MyString"
    ))
  end

  it "renders the edit trails_desc form" do
    render

    assert_select "form[action=?][method=?]", trails_desc_path(@trails_desc), "post" do

      assert_select "input#trails_desc_trail_desc_id[name=?]", "trails_desc[trail_desc_id]"

      assert_select "input#trails_desc_trail_subsystem[name=?]", "trails_desc[trail_subsystem]"

      assert_select "input#trails_desc_alt_name[name=?]", "trails_desc[alt_name]"

      assert_select "input#trails_desc_trail_desc[name=?]", "trails_desc[trail_desc]"

      assert_select "input#trails_desc_map_link[name=?]", "trails_desc[map_link]"

      assert_select "input#trails_desc_map_link_spanish[name=?]", "trails_desc[map_link_spanish]"
    end
  end
end
