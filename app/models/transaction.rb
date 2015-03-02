class Transaction < ActiveRecord::Base
  belongs_to :item
  has_one :category, through: :items
  validates :code, :inclusion => {:in => ['delivery', 'sale', 'waste', 'buyback', 'lost', 'found', 'other']}
  validate :has_appropriate_amount

  scope :most_recent_first, -> { order('date DESC') }

  after_initialize :init

  def code_list
    ['delivery', 'sale', 'waste', 'buyback', 'lost', 'found', 'other']
  end

  def has_appropriate_amount
    if self.amount < 0
      if self.code == "delivery"
        errors.add(:amount, "for 'delivery' cannot be negative.")
      elsif self.code == "found"
        errors.add(:amount, "for 'found' cannot be negative.")
      end
    elsif self.amount > 0
      if self.code == "sale"
        errors.add(:amount, "for 'sale' cannot be positive.")
      elsif self.code == "waste"
        errors.add(:amount, "for 'waste' cannot be positive.")
      elsif self.code == "lost"
        errors.add(:amount, "for 'lost' cannot be positive.")
      elsif self.code == "buyback"
        errors.add(:amount, "for 'waste' cannot be positive.")
      end
    end
  end


  private

    def init
      self.code               ||= 'delivery'
      self.amount             ||= 0
    end
end