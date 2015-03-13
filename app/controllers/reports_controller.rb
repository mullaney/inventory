class ReportsController < ApplicationController

  def current
    @items = Item.all.joins(:transactions).where(discontinued: false).select("items.*, sum(transactions.amount) as transactions_sum").group("items.id").order('items.category_id ASC').order('items.name ASC')
    @title = "Current Inventory"
  end

end
