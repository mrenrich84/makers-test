require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'

describe Discount do
  let(:order) { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }

  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  let(:broadcaster_1) {Broadcaster.new(1, 'Viacom')}
  let(:broadcaster_2) {Broadcaster.new(2, 'Disney')}
  let(:broadcaster_3) {Broadcaster.new(3, 'Discovery')}
  let(:broadcaster_4) {Broadcaster.new(4, 'Horse and Country')}

  subject { Discount.new(order)}

  context 'empty order' do
    it 'calculate discount to 0' do
      expect(subject.calculate).to eq(0)
    end
  end

  context 'with items' do
    it 'returns 0 if no conditions apply' do
      order.add broadcaster_1, standard_delivery
      order.add broadcaster_2, express_delivery

      expect(subject.calculate).to eq(0)
    end

    it 'calculates a 10% off on order above 30$' do
      order.add broadcaster_1, standard_delivery
      order.add broadcaster_2, standard_delivery
      order.add broadcaster_3, standard_delivery
      order.add broadcaster_4, express_delivery

      expect(subject.calculate).to eq(5.0)
    end

    it 'calculates a discount of 5$ on each express_delivery when more than 2 of them are choosen' do
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery

      expect(subject.calculate).to eq(10.0)
    end

    it 'calculates a discount of 5$ on each express_delivery when more than 2 of them are choosen' do
      order.add broadcaster_1, express_delivery
      order.add broadcaster_2, express_delivery
      order.add broadcaster_3, express_delivery

      expect(subject.calculate).to eq(19.5)
    end
  end
end