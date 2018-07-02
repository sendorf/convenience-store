# checkout.rb
class Checkout
  VOUCHER = {:name => "Cabify Voucher", :price => 5.00}
  TSHIRT = {:name => "Cabify T-Shirt", :price => 20.00}
  MUG = {:name => "Cafify Coffee Mug", :price => 7.50}

  attr_reader :items

  def initialize(pricing_rules = {})
    @pricing_rules = pricing_rules                 # Initializes the promotional rules that may be applied
    @items = []
  end

  def scan(item)
    @items << Checkout.const_get(item).clone       # Adds a copy of the item to item list of the instance
  end

  def buy_two_get_one_free(product)
    product = Checkout.const_get product
    @items.select{|x| x[:name] == product[:name]}.each_with_index do |item, index|
      item[:price] = 0 if index.odd?
    end
  end

  def bulk_discount(product, discount_price, bulk_size)
    product = Checkout.const_get product
    discountable_items = @items.select{|x| x[:name] == product[:name]}
    discountable_items.each{|x| x[:price] = discount_price} if discountable_items.size >= bulk_size
  end

  def total()                                      # Calculates the total price of the items in the basket
    @pricing_rules.each{|x| send(x[:rule], *x[:params])}
    @items.map{|x| x[:price].to_f}.reduce(:+).round(2)
  end
end