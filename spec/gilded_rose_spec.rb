require 'gilded_rose'

describe GildedRose do

  context "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    context '+5 Dexterity Vest & Elixir of the Mongoose' do
      it 'item will loss quility each day' do
          items = [Item.new("+5 Dexterity Vest", 3, 5)]
          GildedRose.new(items).update_quality()
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to eq 3
      end

      it 'quality will double after sell by date' do
          items = [Item.new("Elixir of the Mongoose", 3, 10)]
          5.times { GildedRose.new(items).update_quality() }
          expect(items[0].quality).to eq 3
      end

      it 'sell in days will decreases' do
        items = [Item.new("+5 Dexterity Vest", 3, 5)]
        GildedRose.new(items).update_quality()
        expect(items[0].sell_in).to eq 2
      end
    end

    context "Sulfuras, Hand of Ragnaros" do
      it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
          5.times { GildedRose.new(items).update_quality() }
          expect(items[0].quality).to eq 80
          expect(items[0].sell_in).to eq 0
      end
    end

    context 'Aged Brie' do
      it "increases in Quality the older it gets" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 1
        expect(items[0].sell_in).to eq 1
      end

      it "Quality increase doubles after sell by date" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        5.times { GildedRose.new(items).update_quality() }
        expect(items[0].quality).to eq 8
        expect(items[0].sell_in).to eq -3
      end

      it "Quality can never be more than 50" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        60.times { GildedRose.new(items).update_quality() }
        expect(items[0].quality).to eq 50
      end
    end

  end



end
