require 'gilded_rose'

describe GildedRose do

  context "#update_quality" do

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq "foo"
    end

    context '+5 Dexterity Vest & Elixir of the Mongoose' do
      it 'item will loss quility each day' do
          items = [Item.new("+5 Dexterity Vest", 3, 5)]
          GildedRose.new(items).update_quality
          GildedRose.new(items).update_quality
          expect(items[0].quality).to eq 3
      end

      it 'quality loss will double after sell by date' do
          items = [Item.new("Elixir of the Mongoose", 3, 10)]
          5.times { GildedRose.new(items).update_quality }
          expect(items[0].quality).to eq 3
      end

      it 'quality can never go below 0' do
        items = [Item.new("Elixir of the Mongoose", 5, 8)]
        7.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 0
      end

      it 'sell in days will decrease' do
        items = [Item.new("+5 Dexterity Vest", 3, 5)]
        GildedRose.new(items).update_quality
        expect(items[0].sell_in).to eq 2
      end

    end

    context "Sulfuras, Hand of Ragnaros" do
      it "Sulfuras, being a legendary item, never has to be sold or decreases in Quality" do
          items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
          5.times { GildedRose.new(items).update_quality }
          expect(items[0].quality).to eq 80
          expect(items[0].sell_in).to eq 0
      end
    end

    context 'Aged Brie' do
      it "increases in Quality the older it gets" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 1
      end

      it "Quality increase doubles after sell by date" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        5.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 8
      end

      it "Quality can never be more than 50" do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        60.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 50
      end

      it 'sell in days will decrease' do
        items = [Item.new(name="Aged Brie", sell_in=2, quality=0)]
        5.times { GildedRose.new(items).update_quality }
        expect(items[0].sell_in).to eq -3
      end
    end

    context 'Backstage passes' do
      it 'quality goes up by 1 each day more than 10 days before gig' do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
        5.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 25
      end

      it 'quality goes up by 2 each day less than 10 days before gig' do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
        8.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 31
      end

      it 'quality goes up by 3 each day less than 5 days before gig' do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
        12.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 41
      end

      it 'quality goes after sell by date quality is 0' do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
        16.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 0
      end

      it "Quality can never be more than 50" do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=50, quality=30)]
        50.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 50
      end

      it 'sell in days will decrease' do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20)]
        20.times { GildedRose.new(items).update_quality }
        expect(items[0].sell_in).to eq -5
      end

    end

    context 'Conjured item' do
      it 'degrades at double by 2 before sell by date' do
        items = [Item.new(name="Conjured Mana Cake", sell_in=3, quality=6)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 4
      end

      it 'degrades at double by 4 after sell by date' do
        items = [Item.new(name="Conjured Mana Cake", sell_in=3, quality=20)]
        5.times { GildedRose.new(items).update_quality }
        expect(items[0].quality).to eq 6
      end
    end

  end



end
