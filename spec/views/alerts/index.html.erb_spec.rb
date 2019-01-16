require 'rails_helper'

RSpec.describe "alerts/index.html.erb", type: :view do
  before(:each) do
    assign(:alerts, [
      Alert.create!(
        :pointsofinterest_id => 2,
        :geom => ""
      ),
      Alert.create!(
        :pointsofinterest_id => 2,
        :geom => ""
      )
    ])
  end

  it "renders a list of alerts" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
