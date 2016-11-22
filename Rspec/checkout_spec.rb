# checkout_spec.rb
require_relative '../checkout.rb'

describe Checkout, "#Basket 1" do
  it "The result should be 22.45." do
    pricing_rules = [{:rule=>'buy_one_get_one_free', :params => ["GR1"]}, {:rule=>'bulk_discount', :params => ["SR1", 4.50]}]
    co = Checkout.new(pricing_rules)
    co.scan("GR1")
    co.scan("SR1")
    co.scan("GR1")
    co.scan("GR1")
    co.scan("CF1")
    expect(co.total).to eq(22.45)
  end
end

describe Checkout, "#Basket 2" do
  it "The result should be 3.11." do
    pricing_rules = [{:rule=>'buy_one_get_one_free', :params => ["GR1"]}, {:rule=>'bulk_discount', :params => ["SR1", 4.50]}]
    co = Checkout.new(pricing_rules)
    co.scan("GR1")
    co.scan("GR1")
    expect(co.total).to eq(3.11)
  end
end

describe Checkout, "#Basket 3" do
  it "The result should be 16.61." do
    pricing_rules = [{:rule=>'buy_one_get_one_free', :params => ["GR1"]}, {:rule=>'bulk_discount', :params => ["SR1", 4.50]}]
    co = Checkout.new(pricing_rules)
    co.scan("SR1")
    co.scan("SR1")
    co.scan("GR1")
    co.scan("SR1")
    expect(co.total).to eq(16.61)
  end
end