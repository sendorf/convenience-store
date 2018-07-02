# checkout_spec.rb
require_relative '../checkout.rb'

describe Checkout do
  let(:pricing_rules) do
    [
      { rule: 'buy_two_get_one_free', params: ['VOUCHER'] },
      { rule: 'bulk_discount', params: ['TSHIRT', 19.00, 3] }
    ]
  end

  subject { Checkout.new(pricing_rules) }

  describe '#scan' do
    it 'adds one item' do
      subject.scan('VOUCHER')
      expect(subject.items.size).to eq 1
    end

    it 'adds multiple items' do
      subject.scan('VOUCHER')
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      expect(subject.items.size).to eq 3
    end
  end

  describe '#buy_two_get_one_free' do
    let(:total) { subject.items.map{|x| x[:price].to_f}.reduce(:+).round(2) }

    it 'doesn\'t apply the discount for one element' do
      subject.scan('TSHIRT')
      subject.buy_two_get_one_free('TSHIRT')
      expect(total).to eq 20.00
    end

    it 'applies the discount for even elements' do
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.buy_two_get_one_free('TSHIRT')
      expect(total).to eq 40.00
    end

    it 'applies the discount for odd elements' do
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.buy_two_get_one_free('TSHIRT')
      expect(total).to eq 60.00
    end
  end

  describe '#bulk_discount' do
    let(:total) { subject.items.map{|x| x[:price].to_f}.reduce(:+).round(2) }

    it 'doesn\'t apply the discount for less elements than bulk_size' do
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.bulk_discount('MUG', 15.00, 5)
      expect(total).to eq 30.00
    end

    it 'applies the discount for same elements as bulk_size' do
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.bulk_discount('MUG', 15.00, 4)
      expect(total).to eq 60.00
    end

    it 'applies the discount for more elements than bulk_size' do
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.scan('MUG')
      subject.bulk_discount('MUG', 3.00, 4)
      expect(total).to eq 15.00
    end
  end

  describe '#total' do
    it 'without discounts the result should be 32.50.' do
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      subject.scan('MUG')
      expect(subject.total).to eq(32.50)
    end

    it 'with 2x1 discount the result should be 25.00.' do
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      subject.scan('VOUCHER')
      expect(subject.total).to eq(25.00)
    end

    it 'with bulk discount the result should be 81.00.' do
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      expect(subject.total).to eq(81.00)
    end

    it 'with all discounts the result should be 74.50.' do
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      subject.scan('VOUCHER')
      subject.scan('VOUCHER')
      subject.scan('MUG')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      expect(subject.total).to eq(74.50)
    end

    it 'called twice doesn\'t change the total' do
      subject.scan('VOUCHER')
      subject.scan('TSHIRT')
      subject.scan('VOUCHER')
      subject.scan('VOUCHER')
      subject.scan('MUG')
      subject.scan('TSHIRT')
      subject.scan('TSHIRT')
      subject.total
      expect(subject.total).to eq(74.50)
    end
  end
end
