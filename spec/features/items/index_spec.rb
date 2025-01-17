require 'rails_helper'

describe 'merchants items index' do
  before do
    @merchant_1 = Merchant.create!(name: 'Hair Care')
    @merchant_2 = Merchant.create!(name: 'Long Hair Dont Care')

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: "Shampoo Bar", description: "Eco friendly shampoo", unit_price: 7, merchant_id: @merchant_1.id, status: 1)
    @item_5 = Item.create!(name: "Lotion", description: "Moisturize skin", unit_price: 10, merchant_id: @merchant_1.id, status: 1)

    visit merchant_items_path(@merchant_1)
  end

  describe 'display' do
    it 'all items from this merchant' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to_not have_content(@item_3.name)
    end

    it 'every item name is a link to its show page' do
      click_link(@item_1.name)
      expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
    end

    it 'has a link to create a new item' do
      click_link "Create New Item"

      expect(current_path).to eq(new_merchant_item_path(@merchant_1))
    end

    it 'has a button to enable or disable next to each item name' do
      within('#disabled_items') do
        within("#item-#{@item_1.id}") do
          click_button "Enable this item"
        end
      end
      within('#enabled_items') do
        within("#item-#{@item_1.id}") do
          expect(page).to have_content("Status: Enabled")
        end
      end
    end

    it "has items listed in corresponding enabled or disabled sections" do

      within('#disabled_items') do
        expect(page).to have_content('Disabled Items:')
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)
      end

      within('#enabled_items') do
        expect(page).to have_content('Enabled Items:')
        expect(page).to have_content(@item_4.name)
        expect(page).to have_content(@item_5.name)
      end
    end
    it 'lists top 5 items with total revenue listed next to each item' do
      customer_1 = create(:customer)
      merchant_6 = Merchant.create!(name: 'Rob')
      item_6 = create(:item, merchant_id: merchant_6.id)
      item_7 = create(:item, merchant_id: merchant_6.id)
      item_8 = create(:item, merchant_id: merchant_6.id)
      item_9 = create(:item, merchant_id: merchant_6.id)
      item_10 = create(:item, merchant_id: merchant_6.id)
      item_11 = create(:item, merchant_id: merchant_6.id)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_9 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_10 = Invoice.create!(customer_id: customer_1.id, status: 2)
      invoice_11 = Invoice.create!(customer_id: customer_1.id, status: 2)
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_7.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_8.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_9.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_10.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_11.id, result: 0)
      invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 50)
      invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_7.id, status: 1, quantity: 1, unit_price: 45)
      invoice_item_8 = create(:invoice_item, item_id: item_8.id, invoice_id: invoice_8.id, status: 1, quantity: 1, unit_price: 40)
      invoice_item_9 = create(:invoice_item, item_id: item_9.id, invoice_id: invoice_9.id, status: 1, quantity: 1, unit_price: 35)
      invoice_item_10 = create(:invoice_item, item_id: item_10.id, invoice_id: invoice_10.id, status: 1, quantity: 1, unit_price: 30)
      invoice_item_11 = create(:invoice_item, item_id: item_11.id, invoice_id: invoice_11.id, status: 1, quantity: 1, unit_price: 5)

      visit merchant_items_path(merchant_6)
      within '#top_five_items' do
        expect(page).to have_content("Item: #{item_6.name} - Total Sales: 50")
        expect(page).to have_content("Item: #{item_7.name} - Total Sales: 45")
        expect(page).to have_content("Item: #{item_8.name} - Total Sales: 40")
        expect(page).to have_content("Item: #{item_9.name} - Total Sales: 35")
        expect(page).to have_content("Item: #{item_10.name} - Total Sales: 30")
        expect(page).to_not have_content(item_11.name)
        expect(item_6.name).to appear_before(item_7.name)
        expect(item_7.name).to appear_before(item_8.name)
        expect(item_8.name).to appear_before(item_9.name)
        expect(item_9.name).to appear_before(item_10.name)
        expect(page).to have_link(item_6.name)
        click_link(item_6.name)
        expect(current_path).to eq(merchant_item_path(merchant_6, item_6))
      end
    end
    it 'next to most popular items I see the date with the most sales for each item' do
      customer_1 = create(:customer)
      merchant_6 = Merchant.create!(name: 'Rob')
      item_6  = create(:item, name: 'name_1', merchant_id: merchant_6.id)
      item_7  = create(:item, name: 'name_2', merchant_id: merchant_6.id)
      item_8  = create(:item, name: 'name_3', merchant_id: merchant_6.id)
      item_9  = create(:item, name: 'name_4', merchant_id: merchant_6.id)
      item_10 = create(:item, name: 'name_5', merchant_id: merchant_6.id)
      item_11 = create(:item, name: 'name_6', merchant_id: merchant_6.id)
      invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2013-03-25 09:54:09 UTC")
      invoice_12 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
      invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2013-03-25 09:54:09 UTC")
      invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2014-03-25 09:54:09 UTC")
      invoice_9 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2016-03-25 09:54:09 UTC")
      invoice_10 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2015-03-25 09:54:09 UTC")
      invoice_11 = Invoice.create!(customer_id: customer_1.id, status: 2, created_at: "2012-03-25 09:54:09 UTC")
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_7.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_8.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_9.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_10.id, result: 0)
      transaction_6 = create(:transaction, invoice_id: invoice_11.id, result: 0)
      invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 50)
      invoice_item_12 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, status: 2, quantity: 1, unit_price: 50)
      invoice_item_7 = create(:invoice_item, item_id: item_7.id, invoice_id: invoice_7.id, status: 1, quantity: 1, unit_price: 45)
      invoice_item_8 = create(:invoice_item, item_id: item_8.id, invoice_id: invoice_8.id, status: 1, quantity: 1, unit_price: 40)
      invoice_item_9 = create(:invoice_item, item_id: item_9.id, invoice_id: invoice_9.id, status: 1, quantity: 1, unit_price: 30)
      invoice_item_10 = create(:invoice_item, item_id: item_10.id, invoice_id: invoice_10.id, status: 1, quantity: 1, unit_price: 30)
      invoice_item_11 = create(:invoice_item, item_id: item_11.id, invoice_id: invoice_11.id, status: 1, quantity: 1, unit_price: 5)

      visit merchant_items_path(merchant_6)
      within '#top_five_items' do
        expect(page).to have_content("Top Sales Date: #{invoice_6.created_at.to_date}")
        expect(page).to have_content("Top Sales Date: #{invoice_7.created_at.to_date}")
        expect(page).to have_content("Top Sales Date: #{invoice_8.created_at.to_date}")
        expect(page).to have_content("Top Sales Date: #{invoice_9.created_at.to_date}")
        expect(page).to have_content("Top Sales Date: #{invoice_10.created_at.to_date}")
        expect(page).to_not have_content(invoice_12.created_at.to_date)
      end
    end
  end
end
