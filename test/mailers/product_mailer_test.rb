require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  test "in_stock" do
    product = Product.create!(name: "Sample Product", inventory_count: 1)

    subscriber = Subscriber.create!(
      email: "subscriber@example.com",
      product: product  # associate with product to satisfy validation
    )

    mail = ProductMailer.with(product: product, subscriber: subscriber).in_stock

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal [ "subscriber@example.com" ], mail.to
    assert_equal "Sample Product is back in stock!", mail.subject
  end
end
