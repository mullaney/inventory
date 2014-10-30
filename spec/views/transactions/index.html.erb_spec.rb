require 'rails_helper'

RSpec.describe "transactions/index", :type => :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        :item => nil,
        :code => "Type",
        :amount => 1
      ),
      Transaction.create!(
        :item => nil,
        :code => "Type",
        :amount => 1
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
