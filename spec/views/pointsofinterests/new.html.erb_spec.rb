require 'rails_helper'

RSpec.describe "pointsofinterests/new", type: :view do
  before(:each) do
    assign(:pointsofinterest, Pointsofinterest.new(
      :pointsofinterest_id => 1,
      :geom => ""
    ))
  end

  it "renders new pointsofinterest form" do
    render

    assert_select "form[action=?][method=?]", pointsofinterests_path, "post" do

      assert_select "input#pointsofinterest_pointsofinterest_id[name=?]", "pointsofinterest[pointsofinterest_id]"

      assert_select "input#pointsofinterest_geom[name=?]", "pointsofinterest[geom]"
    end
  end
end
