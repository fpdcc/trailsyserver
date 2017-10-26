require 'rails_helper'

RSpec.describe "trail_systems/show", type: :view do
  before(:each) do
    @trail_system = assign(:trail_system, TrailSystem.create!(
      :trail_subsystem => "Trail Subsystem"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Trail Subsystem/)
  end
end
