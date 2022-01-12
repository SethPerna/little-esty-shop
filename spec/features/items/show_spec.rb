require 'rails_helper'

describe 'Merchant item show page' do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id)

    visit merchant_item_path(@merchant_1, @item_1)
  end

  describe 'display' do
    it 'all attributes for one item' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_1.unit_price)
      expect(page).to have_content(@item_1.description)
    end

    it 'includes a link to update item info' do
      click_link "Update Item Information"
      expect(current_path).to eq(edit_merchant_item_path(@merchant_1, @item_1))
    end
  end
end
