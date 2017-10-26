require 'rails_helper'

RSpec.describe "pointsofinterests/edit", type: :view do
  before(:each) do
    @pointsofinterest = assign(:pointsofinterest, Pointsofinterest.create!(
      :pointsofinterest_id => 1,
      :geom => ""
    ))
  end

  it "renders the edit pointsofinterest form" do
    render

    assert_select "form[action=?][method=?]", pointsofinterest_path(@pointsofinterest), "post" do

      assert_select "input#pointsofinterest_pointsofinterest_id[name=?]", "pointsofinterest[pointsofinterest_id]"

      assert_select "input#pointsofinterest_geom[name=?]", "pointsofinterest[geom]"
    end
  end
end
