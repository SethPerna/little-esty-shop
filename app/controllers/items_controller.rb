class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])

    if params[:status]
      @item.update(name: params[:status])
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      @item.update(item_params)
      @merchant.save
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
