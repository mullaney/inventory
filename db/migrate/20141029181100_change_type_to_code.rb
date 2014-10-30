class ChangeTypeToCode < ActiveRecord::Migration
  def change
    rename_column :transactions, :type, :code
  end
end
