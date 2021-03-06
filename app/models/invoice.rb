class Invoice < ApplicationRecord
  has_many :purchase_orders, dependent: :destroy

  validates :client_name, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  default_scope -> { order('created_at desc') }

  def total
    if tax.present?
      amount * (1 + (tax / 100))
    else
      amount
    end
  end
end
