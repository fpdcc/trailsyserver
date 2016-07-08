require 'rails_helper'

RSpec.describe "new_trails/new", type: :view do
  before(:each) do
    assign(:new_trail, NewTrail.new(
      :trails_id => 1,
      :geom => ""
    ))
  end

  it "renders new new_trail form" do
    render

    assert_select "form[action=?][method=?]", new_trails_path, "post" do

      assert_select "input#new_trail_trails_id[name=?]", "new_trail[trails_id]"

      assert_select "input#new_trail_geom[name=?]", "new_trail[geom]"
    end
  end
end
