require_relative 'item'

class GildedRose

  def initialize(items)
    # An array of Item instances
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if sulfuras?(item)

      if item_quality_decreases_with_age?(item)
        decreases_with_age_quality_updater(item)
      elsif aged_brie?(item)
        past_sell_by_day?(item) ? quality_increase(item, amount: 2) : quality_increase(item)
      else
        bookings_quality_updater(item)
      end
      single_sell_in_day_remover(item)
    end
  end

  private

  def bookings_quality_updater(item)
    quality_remover(item, amount: item.quality) if past_sell_by_day?(item)
    quality_increase(item, amount: 3) if five_days_to_go?(item)
    quality_increase(item, amount: 2) if ten_days_to_go?(item)
    quality_increase(item) if more_than_ten_days_to_go?(item)
  end

  def decreases_with_age_quality_updater(item)
    if conjured?(item)
      past_sell_by_day?(item) ? quality_remover(item, amount: 4) : quality_remover(item, amount: 2)
    else
      past_sell_by_day?(item) ? quality_remover(item, amount: 2) : quality_remover(item)
    end
  end

  def single_sell_in_day_remover(item)
    item.sell_in -= 1
  end

  def quality_remover(item, amount: 1)
    item.quality -= amount unless min_quality?(item)
    item.quality = 0 if min_quality?(item)
  end

  def min_quality?(item)
    !item.quality.positive?
  end

  def item_quality_decreases_with_age?(item)
    !aged_brie?(item) && !backstage_passes?(item)
  end

  def quality_increase(item, amount: 1)
    item.quality += amount if max_quality?(item)
  end

  def max_quality?(item)
    item.quality < 50
  end

  def past_sell_by_day?(item)
    item.sell_in <= 0
  end

  def ten_days_to_go?(item)
    item.sell_in < 11 && item.sell_in > 5
  end

  def more_than_ten_days_to_go?(item)
    item.sell_in > 10
  end

  def five_days_to_go?(item)
    item.sell_in < 6 && item.quality.positive?
  end

  def sulfuras?(item)
    item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def aged_brie?(item)
    item.name == 'Aged Brie'
  end

  def backstage_passes?(item)
    item.name == 'Backstage passes to a TAFKAL80ETC concert'
  end

  def conjured?(item)
    item.name == "Conjured Mana Cake"
  end

end
