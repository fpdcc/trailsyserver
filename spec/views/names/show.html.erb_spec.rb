require 'rails_helper'

RSpec.describe "names/show", type: :view do
  before(:each) do
    @name = assign(:name, Name.create!(
      :nameid => 2,
      :name => "Name",
      :old_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/3/)
  end
end
