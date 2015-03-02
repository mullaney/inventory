class AddDiscontinuedToItem < ActiveRecord::Migration
  def change
    add_column :items, :discontinued, :boolean, default: false
  end
end
