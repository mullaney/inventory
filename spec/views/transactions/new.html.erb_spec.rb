require 'rails_helper'

RSpec.describe "transactions/new", :type => :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      :item => nil,
      :code => "",
      :amount => 1
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input#transaction_item_id[name=?]", "transaction[item_id]"

      assert_select "input#transaction_type[name=?]", "transaction[type]"

      assert_select "input#transaction_amount[name=?]", "transaction[amount]"
    end
  end
end
