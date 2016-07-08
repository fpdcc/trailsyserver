require 'rails_helper'

RSpec.describe "names/index", type: :view do
  before(:each) do
    assign(:names, [
      Name.create!(
        :nameid => 2,
        :name => "Name",
        :old_id => 3
      ),
      Name.create!(
        :nameid => 2,
        :name => "Name",
        :old_id => 3
      )
    ])
  end

  it "renders a list of names" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
