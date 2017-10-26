require 'rails_helper'

RSpec.describe "new_trails/edit", type: :view do
  before(:each) do
    @new_trail = assign(:new_trail, NewTrail.create!(
      :trails_id => 1,
      :geom => ""
    ))
  end

  it "renders the edit new_trail form" do
    render

    assert_select "form[action=?][method=?]", new_trail_path(@new_trail), "post" do

      assert_select "input#new_trail_trails_id[name=?]", "new_trail[trails_id]"

      assert_select "input#new_trail_geom[name=?]", "new_trail[geom]"
    end
  end
end
