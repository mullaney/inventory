class ReportsController < ApplicationController

  def current
    @items = Item.all.joins(:transactions).select("items.*, sum(transactions.amount) as transactions_sum").group("items.id").order('items.name ASC')
  end

end
