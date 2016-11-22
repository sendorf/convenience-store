# checkout.rb
class Checkout

  GR1 = {:name => "Green tea", :price => 3.11}
  SR1 = {:name => "Strawberries", :price => 5.00}
  CF1 = {:name => "Coffee", :price => 11.23}

  def initialize(pricing_rules = {})
    @pricing_rules = pricing_rules                                   # Initializes the promotional rules that may be applied
    @items = []
  end

  def scan(item)
    @items << Checkout.const_get(item).clone                                                         # Adds the key of every item to an array of keys
  end                                                                       # of scanned items

  def buy_one_get_one_free(product)
    product = Checkout.const_get product
    (@items.select{|x| x[:name] == product[:name]}.size/2).times do
      free_item = @items.select{|x| x[:name] == product[:name] && x[:price] != 0}.last
      free_item[:price] = 0
    end
  end

  def bulk_discount(product, discount_price)
    product = Checkout.const_get product
    discountable_items = @items.select{|x| x[:name] == product[:name]}
    if discountable_items.size >= 3
      discountable_items.each{|x| x[:price] = discount_price}
    end
  end

  def total()
    @pricing_rules.each{|x| send(x[:rule], *x[:params])}
    @items.map{|x| x[:price].to_f}.reduce(:+).round(2)
  end
end