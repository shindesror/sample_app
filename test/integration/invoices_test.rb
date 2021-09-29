require 'test_helper'

class InvoicesTest < ActionDispatch::IntegrationTest
  let(:invoice) { create(:invoice) }

  setup do
    invoice
  end

  teardown do
    Rails.cache.clear # Clear Cache
  end

  # Invoice#index
  test 'should give all invoices' do
    get '/invoices'
    assert_response :success
    assert_equal Invoice.count, 1
    assert_select 'td', invoice.client_name
  end

  # Invoice#xhr_add_invoice
  test 'should create new invoice' do
    post '/invoices/xhr_add_invoice', params: {
      invoice: { amount: 400.0, client_name: 'Test Client', tax: 20 }
    }

    assert_response :success
    assert_equal Invoice.count, 2
  end

  # Invoice#xhr_change_client_name
  test 'should update client_name' do
    patch "/invoices/#{invoice.id}/xhr_change_client_name", params: {
      invoice: { client_name: 'Test Client' }
    }

    assert_response :success
    assert_equal Invoice.count, 1
    assert_equal Invoice.last.client_name, 'Test Client'
  end

  # Invoice#destroy
  test 'should destroy invoice' do
    delete "/invoices/#{invoice.id}"

    assert_equal Invoice.count, 0
  end
end
