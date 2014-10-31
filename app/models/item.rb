class Item < ActiveRecord::Base
  belongs_to :category
  has_many :transactions
  validates :category_id, presence: true
  validates :name, presence: true

  scope :with_balance, -> { joins(:transactions).select("items.*, sum(transactions.amount) as transactions_sum").group("items.id").order('items.name ASC') }
end
