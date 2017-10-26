require 'rails_helper'

RSpec.describe "poi_descs/edit", type: :view do
  before(:each) do
    @poi_desc = assign(:poi_desc, PoiDesc.create!(
      :poi_info_id => 1,
      :hours1 => "MyString",
      :hours2 => "MyString",
      :phone => "MyString",
      :description => "MyString",
      :web_link => "MyString",
      :map_link => "MyString",
      :map_link_spanish => "MyString",
      :vol_link => "MyString",
      :vol_link2 => "MyString",
      :picnic_link => "MyString",
      :event_link => "MyString",
      :custom_link => "MyString",
      :season1 => "MyString",
      :season2 => "MyString",
      :special_hours => "MyString",
      :special_description => "MyString",
      :special_link => "MyString",
      :photo_link => "MyString",
      :poi_desc_id => 1
    ))
  end

  it "renders the edit poi_desc form" do
    render

    assert_select "form[action=?][method=?]", poi_desc_path(@poi_desc), "post" do

      assert_select "input#poi_desc_poi_info_id[name=?]", "poi_desc[poi_info_id]"

      assert_select "input#poi_desc_hours1[name=?]", "poi_desc[hours1]"

      assert_select "input#poi_desc_hours2[name=?]", "poi_desc[hours2]"

      assert_select "input#poi_desc_phone[name=?]", "poi_desc[phone]"

      assert_select "input#poi_desc_description[name=?]", "poi_desc[description]"

      assert_select "input#poi_desc_web_link[name=?]", "poi_desc[web_link]"

      assert_select "input#poi_desc_map_link[name=?]", "poi_desc[map_link]"

      assert_select "input#poi_desc_map_link_spanish[name=?]", "poi_desc[map_link_spanish]"

      assert_select "input#poi_desc_vol_link[name=?]", "poi_desc[vol_link]"

      assert_select "input#poi_desc_vol_link2[name=?]", "poi_desc[vol_link2]"

      assert_select "input#poi_desc_picnic_link[name=?]", "poi_desc[picnic_link]"

      assert_select "input#poi_desc_event_link[name=?]", "poi_desc[event_link]"

      assert_select "input#poi_desc_custom_link[name=?]", "poi_desc[custom_link]"

      assert_select "input#poi_desc_season1[name=?]", "poi_desc[season1]"

      assert_select "input#poi_desc_season2[name=?]", "poi_desc[season2]"

      assert_select "input#poi_desc_special_hours[name=?]", "poi_desc[special_hours]"

      assert_select "input#poi_desc_special_description[name=?]", "poi_desc[special_description]"

      assert_select "input#poi_desc_special_link[name=?]", "poi_desc[special_link]"

      assert_select "input#poi_desc_photo_link[name=?]", "poi_desc[photo_link]"

      assert_select "input#poi_desc_poi_desc_id[name=?]", "poi_desc[poi_desc_id]"
    end
  end
end
