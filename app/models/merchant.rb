class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  enum status: {enable: 0, disable: 1}

  def self.enabled_merchants
    Merchant.where(status: 'enable')
  end

  def self.disabled_merchants
    Merchant.where(status: 'disable')
  end

  def self.top_five_merchants
    joins(invoices: :transactions).where(transactions: { result: 0 })
    .joins(:invoice_items)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as rev_count')
    .group(:id)
    .order(rev_count: :desc)
    .limit(5)
  end
end
