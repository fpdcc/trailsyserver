require 'rails_helper'

RSpec.describe "trails_infos/edit", type: :view do
  before(:each) do
    @trails_info = assign(:trails_info, TrailsInfo.create!(
      :trail_system => "MyString",
      :trail_subsystem => "MyString",
      :trail_color => "MyString",
      :trail_surface => "MyString",
      :trail_type => "MyString",
      :trail_difficulty => "MyString",
      :regional_trail_name => "MyString",
      :trail_desc => "MyString",
      :gps => "MyString",
      :comment => "MyString",
      :alt_name => "MyString",
      :cambr_name => "MyString",
      :on_street => "MyString",
      :crossing_type => "MyString",
      :unrecognized => "MyString",
      :length_mi => "9.99",
      :trails_id => 1,
      :off_fpdcc => "MyString",
      :web_trail => "MyString",
      :maintenance => "MyString",
      :length_ft => "9.99",
      :trail_info_id => 1
    ))
  end

  it "renders the edit trails_info form" do
    render

    assert_select "form[action=?][method=?]", trails_info_path(@trails_info), "post" do

      assert_select "input#trails_info_trail_system[name=?]", "trails_info[trail_system]"

      assert_select "input#trails_info_trail_subsystem[name=?]", "trails_info[trail_subsystem]"

      assert_select "input#trails_info_trail_color[name=?]", "trails_info[trail_color]"

      assert_select "input#trails_info_trail_surface[name=?]", "trails_info[trail_surface]"

      assert_select "input#trails_info_trail_type[name=?]", "trails_info[trail_type]"

      assert_select "input#trails_info_trail_difficulty[name=?]", "trails_info[trail_difficulty]"

      assert_select "input#trails_info_regional_trail_name[name=?]", "trails_info[regional_trail_name]"

      assert_select "input#trails_info_trail_desc[name=?]", "trails_info[trail_desc]"

      assert_select "input#trails_info_gps[name=?]", "trails_info[gps]"

      assert_select "input#trails_info_comment[name=?]", "trails_info[comment]"

      assert_select "input#trails_info_alt_name[name=?]", "trails_info[alt_name]"

      assert_select "input#trails_info_cambr_name[name=?]", "trails_info[cambr_name]"

      assert_select "input#trails_info_on_street[name=?]", "trails_info[on_street]"

      assert_select "input#trails_info_crossing_type[name=?]", "trails_info[crossing_type]"

      assert_select "input#trails_info_unrecognized[name=?]", "trails_info[unrecognized]"

      assert_select "input#trails_info_length_mi[name=?]", "trails_info[length_mi]"

      assert_select "input#trails_info_trails_id[name=?]", "trails_info[trails_id]"

      assert_select "input#trails_info_off_fpdcc[name=?]", "trails_info[off_fpdcc]"

      assert_select "input#trails_info_web_trail[name=?]", "trails_info[web_trail]"

      assert_select "input#trails_info_maintenance[name=?]", "trails_info[maintenance]"

      assert_select "input#trails_info_length_ft[name=?]", "trails_info[length_ft]"

      assert_select "input#trails_info_trail_info_id[name=?]", "trails_info[trail_info_id]"
    end
  end
end
