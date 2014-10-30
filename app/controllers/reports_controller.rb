    class ReportsController < ApplicationController

      def current
        # @item_list = Transaction.uniq.pluck(:item_id)
        @items = Item.all.joins(:transactions).select("items.*, sum(transactions.amount) as transactions_sum").group("items.id")
      end

    end
