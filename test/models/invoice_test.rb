require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
  let(:invoice) { create(:invoice) }

  it 'should have a client name' do
    invoice.client_name = nil
    refute invoice.valid?
  end

  it 'should have a positive amount' do
    invoice.amount = -10
    refute invoice.valid?

    invoice.amount = nil
    refute invoice.valid?

    invoice.amount = 5
    assert invoice.valid?
  end

  it 'should calculate total' do
    invoice.amount = 50
    invoice.tax = 10
    assert_equal 55, invoice.total

    invoice.amount = 50
    invoice.tax = nil
    assert_equal 50, invoice.total
  end
end
