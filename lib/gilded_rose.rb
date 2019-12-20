require_relative 'item'

class GildedRose

  def initialize(items)
    # An array of Item instances
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if item_matcher?(item, 'Sulfuras, Hand of Ragnaros')

      if item_quality_decreases_with_age?(item)
        decreases_with_age_quality_updater(item) #See line 27
      elsif item_matcher?(item, 'Aged Brie')
        past_sell_by_day?(item) ? quality_increase(item, amount: 2) : quality_increase(item)
      else
        bookings_quality_updater(item) #See line 35
      end
      single_sell_in_day_remover(item)
    end
  end

  private
  # big update quality methods for items... add to itemUpdater class
  def decreases_with_age_quality_updater(item)
    if item_matcher?(item, "Conjured Mana Cake")
      past_sell_by_day?(item) ? quality_remover(item, amount: 4) : quality_remover(item, amount: 2)
    else
      past_sell_by_day?(item) ? quality_remover(item, amount: 2) : quality_remover(item)
    end
  end

  def bookings_quality_updater(item)
    quality_increase(item) if select_sell_in_day_range?(item, start_day: Float::INFINITY, end_day: 11)
    quality_increase(item, amount: 2) if select_sell_in_day_range?(item, start_day: 10, end_day: 6)
    quality_increase(item, amount: 3) if select_sell_in_day_range?(item, start_day: 5, end_day: 0)
    quality_remover(item, amount: item.quality) if past_sell_by_day?(item)
  end

  # update sell in day helper methods
  def single_sell_in_day_remover(item)
    item.sell_in -= 1
  end

  def past_sell_by_day?(item)
    item.sell_in <= 0
  end

  def select_sell_in_day_range?(item,start_day:, end_day:)
    item.sell_in <= start_day && item.sell_in >= end_day
  end



  # small abstracted update quality methods/helpers
  def item_quality_decreases_with_age?(item)
    !item_matcher?(item, 'Aged Brie') && !item_matcher?(item, 'Backstage passes to a TAFKAL80ETC concert')
  end

  def quality_remover(item, amount: 1)
    item.quality -= amount unless min_quality?(item)
    item.quality = 0 if min_quality?(item)
  end

  def quality_increase(item, amount: 1)
    item.quality += amount unless max_quality?(item)
    item.quality = 50 if max_quality?(item)
  end

  def min_quality?(item)
    item.quality.negative?
  end

  def max_quality?(item)
    item.quality >= 50
  end

  # item matcher
  def item_matcher?(item, item_name)
    item.name == item_name
  end

end
