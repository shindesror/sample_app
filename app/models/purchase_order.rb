class PurchaseOrder < ApplicationRecord
  enum status: %i[draft paid delivered].freeze

  belongs_to :invoice

  validates :client_name, :status, :vendor, presence: true
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
