require 'rails_helper'

RSpec.describe "picnicgroves/edit", type: :view do
  before(:each) do
    @picnicgrofe = assign(:picnicgrofe, Picnicgrofe.create!(
      :picnicgrove_id => "",
      :preserve_name => "MyString",
      :grove => 1,
      :division => "MyString",
      :capacity => 1,
      :large_capacity => "MyString",
      :type => "",
      :location => "MyString",
      :status => "MyString",
      :fpd_uid => "MyString",
      :poi_info_id => 1,
      :geom => ""
    ))
  end

  it "renders the edit picnicgrofe form" do
    render

    assert_select "form[action=?][method=?]", picnicgrofe_path(@picnicgrofe), "post" do

      assert_select "input#picnicgrofe_picnicgrove_id[name=?]", "picnicgrofe[picnicgrove_id]"

      assert_select "input#picnicgrofe_preserve_name[name=?]", "picnicgrofe[preserve_name]"

      assert_select "input#picnicgrofe_grove[name=?]", "picnicgrofe[grove]"

      assert_select "input#picnicgrofe_division[name=?]", "picnicgrofe[division]"

      assert_select "input#picnicgrofe_capacity[name=?]", "picnicgrofe[capacity]"

      assert_select "input#picnicgrofe_large_capacity[name=?]", "picnicgrofe[large_capacity]"

      assert_select "input#picnicgrofe_type[name=?]", "picnicgrofe[type]"

      assert_select "input#picnicgrofe_location[name=?]", "picnicgrofe[location]"

      assert_select "input#picnicgrofe_status[name=?]", "picnicgrofe[status]"

      assert_select "input#picnicgrofe_fpd_uid[name=?]", "picnicgrofe[fpd_uid]"

      assert_select "input#picnicgrofe_poi_info_id[name=?]", "picnicgrofe[poi_info_id]"

      assert_select "input#picnicgrofe_geom[name=?]", "picnicgrofe[geom]"
    end
  end
end
