class Product < ApplicationRecord
  has_many :subscribers, dependent: :destroy
  has_one_attached :featured_image
  has_rich_text :description
  generates_token_for :unsubscribe

  validates :name, presence: true
  validates :inventory_count, numericality: { greater_than_or_equal_to: 0 }

  after_update_commit :notify_subscribers, if: :back_in_stock?

  def back_in_stock?
    inventory_count_previously_was.to_i.zero? && inventory_count.to_i > 0
  end

  def notify_subscribers
    subscribers.each do |subscriber|
      ProductMailer.with(product: self, subscriber: subscriber).in_stock.deliver_later
    end
  end
end
