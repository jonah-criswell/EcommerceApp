require "test_helper"

class ProductMailerTest < ActionMailer::TestCase
  fixtures :subscribers, :products

  test "in_stock" do
    subscriber = subscribers(:david)    # your user fixture named "david"
    product = products(:tshirt)   # your product fixture named "tshirt"

    mail = ProductMailer.with(product: product, subscriber: subscriber).in_stock

    assert_equal "In stock", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
