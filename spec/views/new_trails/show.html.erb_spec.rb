require 'rails_helper'

RSpec.describe "new_trails/show", type: :view do
  before(:each) do
    @new_trail = assign(:new_trail, NewTrail.create!(
      :trails_id => 2,
      :geom => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
  end
end
