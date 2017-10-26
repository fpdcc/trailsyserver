require 'rails_helper'

RSpec.describe "trail_systems/edit", type: :view do
  before(:each) do
    @trail_system = assign(:trail_system, TrailSystem.create!(
      :trail_subsystem => "MyString"
    ))
  end

  it "renders the edit trail_system form" do
    render

    assert_select "form[action=?][method=?]", trail_system_path(@trail_system), "post" do

      assert_select "input#trail_system_trail_subsystem[name=?]", "trail_system[trail_subsystem]"
    end
  end
end
