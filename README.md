Convenience Store
===============

We sell only three products:

Code         | Name                |  Price
-------------------------------------------------
VOUCHER      | Voucher      |   5.00€
TSHIRT       | T-Shirt      |  20.00€
MUG          | Coffee Mug   |   7.50€
 
 * The marketing department believes in 2-for-1 promotions (buy two of the same product, get one free), and would like for there to be a 2-for-1 special on `VOUCHER` items.

 * The CFO insists that the best way to increase sales is with discounts on bulk purchases (buying x or more of a product, the price of that product is reduced), and demands that if you buy 3 or more `TSHIRT` items, the price per unit should be 19.00€.
 

Our checkout process allows for items to be scanned in any order, and should return the total amount to be paid. The interface for the checkout process looks like this (ruby):
 
The interface to our checkout looks like this (shown in ruby):
 
```Ruby
  co = Checkout.new(pricing_rules)
  co.scan("VOUCHER")
  co.scan("VOUCHER")
  co.scan("TSHIRT")
  price = co.total
```
Implement a checkout system that fulfills these requirements.
 
Test data
---------
 
Items: VOUCHER, TSHIRT, MUG
Total: 32.50€

Items: VOUCHER, TSHIRT, VOUCHER
Total: 25.00€

Items: TSHIRT, TSHIRT, TSHIRT, VOUCHER, TSHIRT
Total: 81.00€

Items: VOUCHER, TSHIRT, VOUCHER, VOUCHER, MUG, TSHIRT, TSHIRT
Total: 74.50€
