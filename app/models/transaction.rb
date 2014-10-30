class Transaction < ActiveRecord::Base
  belongs_to :item
  has_one :category, through: :items
  validates :code, :inclusion => {:in => ['delivery', 'sale', 'waste', 'buyback', 'found', 'other']}

  private
    def code_list
      ['delivery', 'sale', 'waste', 'buyback', 'found', 'other']
    end
end