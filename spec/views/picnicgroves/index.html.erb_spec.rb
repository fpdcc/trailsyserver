require 'rails_helper'

RSpec.describe "picnicgroves/index", type: :view do
  before(:each) do
    assign(:picnicgroves, [
      Picnicgrofe.create!(
        :picnicgrove_id => "",
        :preserve_name => "Preserve Name",
        :grove => 2,
        :division => "Division",
        :capacity => 3,
        :large_capacity => "Large Capacity",
        :type => "Type",
        :location => "Location",
        :status => "Status",
        :fpd_uid => "Fpd Uid",
        :poi_info_id => 4,
        :geom => ""
      ),
      Picnicgrofe.create!(
        :picnicgrove_id => "",
        :preserve_name => "Preserve Name",
        :grove => 2,
        :division => "Division",
        :capacity => 3,
        :large_capacity => "Large Capacity",
        :type => "Type",
        :location => "Location",
        :status => "Status",
        :fpd_uid => "Fpd Uid",
        :poi_info_id => 4,
        :geom => ""
      )
    ])
  end

  it "renders a list of picnicgroves" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Preserve Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Division".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Large Capacity".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Fpd Uid".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
