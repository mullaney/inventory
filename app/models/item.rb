class Item < ActiveRecord::Base
  belongs_to :category
  has_many :transactions
  validates :category_id, presence: true
  validates :name, presence: true

  scope :with_balance, -> { joins(:transactions).select("items.*, sum(transactions.amount) as transactions_sum").group("items.id").order('items.name ASC') }

  def first_delivery_date
    deliveries = self.transactions.where(code: 'delivery').order('date ASC').limit(1)
    if !deliveries.empty?
      deliveries.first.date
    else
      nil
    end
  end

  def total_sales
    sales = -self.transactions.where(code: 'sale').sum(:amount)
  end

  def recent_sales
    sales = -self.transactions.where("code = ? AND date > ?", "sale", Date.today - 4.weeks).sum(:amount)
  end
end
