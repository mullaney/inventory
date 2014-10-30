require 'rails_helper'

RSpec.describe "transactions/edit", :type => :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      :item => nil,
      :code => "",
      :amount => 1
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input#transaction_item_id[name=?]", "transaction[item_id]"

      assert_select "input#transaction_type[name=?]", "transaction[type]"

      assert_select "input#transaction_amount[name=?]", "transaction[amount]"
    end
  end
end
