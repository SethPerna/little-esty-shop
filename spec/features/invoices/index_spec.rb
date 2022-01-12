require 'rails_helper'

describe 'merchant invoices index' do
  before do
    @merchant = create :merchant
    @merchant_2 = create :merchant

    @customer = create :customer

    @invoice_1 = create :invoice, { customer_id: @customer.id }
    @invoice_2 = create :invoice, { customer_id: @customer.id }
    @invoice_3 = create :invoice, { customer_id: @customer.id }

    @item_1 = create :item, { merchant_id: @merchant.id, status: 'Enabled' }
    @item_2 = create :item, { merchant_id: @merchant.id }
    @item_3 = create :item, { merchant_id: @merchant_2.id }

    @invoice_item_1 = create :invoice_item, { invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 50, quantity: 1 }
    @invoice_item_2 = create :invoice_item, { invoice_id: @invoice_2.id, item_id: @item_2.id, unit_price: 100, quantity: 1 }
    @invoice_item_3 = create :invoice_item, { invoice_id: @invoice_3.id, item_id: @item_3.id, unit_price: 200, quantity: 1 }

    visit merchant_invoices_path(@merchant)
  end

  describe 'display' do
    it 'all invoices with IDs' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_2.id)
      expect(page).to_not have_content(@invoice_3.id)
    end

    it 'ID links to invoice show page' do
      click_link @invoice_1.id
      expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))
    end
  end
end
