require 'rails_helper'

describe 'merchant invoice show' do
  before do
    @merchant = create :merchant
    @merchant_2 = create :merchant

    @customer = create :customer

    @invoice_1 = create :invoice, { customer_id: @customer.id }
    @invoice_2 = create :invoice, { customer_id: @customer.id }

    @item_1 = create :item, { merchant_id: @merchant.id, status: 'Enabled' }
    @item_2 = create :item, { merchant_id: @merchant.id }
    @item_3 = create :item, { merchant_id: @merchant_2.id }

    @invoice_item_1 = create :invoice_item, { invoice_id: @invoice_1.id, item_id: @item_1.id, unit_price: 50, quantity: 1, status: 0 }
    @invoice_item_2 = create :invoice_item, { invoice_id: @invoice_1.id, item_id: @item_2.id, unit_price: 100, quantity: 1, status: 1 }
    @invoice_item_3 = create :invoice_item, { invoice_id: @invoice_2.id, item_id: @item_3.id, unit_price: 200, quantity: 1, status: 2 }

    visit merchant_invoice_path(@merchant, @invoice_1)
  end

  describe 'display' do
    it 'invoice attributes' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content("Created on: #{@invoice_1.created_at.strftime('%A, %B %d, %Y')}")
      expect(page).to have_content(@invoice_1.customer.full_name)
      expect(page).to_not have_content(@invoice_2)
    end

    describe 'total revenue' do
      it 'revenue of all items on invoice' do
        expect(page).to have_content("Total Revenue: $1.50")
      end
    end

    describe 'invoice items' do
      it 'lists all invoice item names, quantity, price and status' do
        within "#invoice_item-#{@invoice_item_1.id}" do
          expect(page).to have_content(@invoice_item_1.item.name)
          expect(page).to have_content(@invoice_item_1.quantity)
          expect(page).to have_content(@invoice_item_1.unit_price)
          expect(page).to have_content(@invoice_item_1.status)
          expect(page).to_not have_content(@item_3)
        end
      end

      it 'select update invoice item status' do
        within "#invoice_item-#{@invoice_item_2.id}" do
          expect(find_field('invoice_item_status').value).to eq('pending')
          select 'packaged'
          click_button 'Update Invoice'
        end
        expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))

        within "#invoice_item-#{@invoice_item_1.id}" do
          expect(find_field('invoice_item_status').value).to eq('packaged')
          expect(page).to have_content('packaged')
        end
      end
    end
  end
end
