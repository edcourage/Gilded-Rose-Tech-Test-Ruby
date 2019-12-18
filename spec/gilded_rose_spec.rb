require 'gilded_rose'

describe GildedRose do

  context "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context '+5 Dexterity Vest' do
      it '+5 Dexterity Vest item will loss quility each day' do
          items = [Item.new("+5 Dexterity Vest", 3, 5)]
          GildedRose.new(items).update_quality()
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 3
      end

      it '+5 Dexterity Vest quality will double after sell by date' do
          items = [Item.new("+5 Dexterity Vest", 3, 10)]
          GildedRose.new(items).update_quality()
          GildedRose.new(items).update_quality()
          GildedRose.new(items).update_quality()
          GildedRose.new(items).update_quality()
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 3
      end
    end

  end



end
