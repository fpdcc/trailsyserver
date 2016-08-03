require 'rails_helper'

RSpec.describe "picnicgroves/show", type: :view do
  before(:each) do
    @picnicgrofe = assign(:picnicgrofe, Picnicgrofe.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Preserve Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Division/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Large Capacity/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Fpd Uid/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(//)
  end
end
