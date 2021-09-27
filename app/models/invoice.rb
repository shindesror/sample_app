class Invoice < ApplicationRecord
  validates :client_name, presence: true, uniqueness: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def total
    if tax.present?
      amount * (1 + (tax / 100))
    else
      amount
    end
  end
end
