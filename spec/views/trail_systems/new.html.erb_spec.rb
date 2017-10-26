require 'rails_helper'

RSpec.describe "trail_systems/new", type: :view do
  before(:each) do
    assign(:trail_system, TrailSystem.new(
      :trail_subsystem => "MyString"
    ))
  end

  it "renders new trail_system form" do
    render

    assert_select "form[action=?][method=?]", trail_systems_path, "post" do

      assert_select "input#trail_system_trail_subsystem[name=?]", "trail_system[trail_subsystem]"
    end
  end
end
