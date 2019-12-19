require_relative 'item'

class GildedRose

  def initialize(items)
    # An array of Item instances
    @items = items
  end

  def update_quality()
    # Iterates through loop
    @items.each do |item|

      next if sulfuras?(item)

      # Deals with quility before sell by date
      if item_quality_decreases_with_age?(item)
        past_sell_by_day?(item) ? quality_remover(item, amount: 2) : quality_remover(item)
      else
        if aged_brie?(item)
          past_sell_by_day?(item) ? quality_increase(item, amount: 2) : quality_increase(item)
        else
          bookings_quality_calculator(item)
        end
      end
      single_sell_in_day_remover(item)
    end

  # End of method below
  end


  private

  def single_sell_in_day_remover(item)
    item.sell_in -= 1
  end

  def quality_remover(item, amount: 1)
    item.quality -= amount if min_quality?(item)
  end

  def min_quality?(item)
    item.quality > 0
  end

  def item_quality_decreases_with_age?(item)
    item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert"
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

  def bookings_quality_calculator(item)
    quality_remover(item, amount: item.quality) if past_sell_by_day?(item)
    quality_increase(item, amount: 3) if five_days_to_go?(item)
    quality_increase(item, amount: 2) if ten_days_to_go?(item)
    quality_increase(item) if more_than_ten_days_to_go?(item)
  end

  def ten_days_to_go?(item)
    item.sell_in < 11 && item.sell_in > 5
  end

  def more_than_ten_days_to_go?(item)
    item.sell_in > 10
  end

  def five_days_to_go?(item)
    item.sell_in < 6 && item.sell_in > 0
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def aged_brie?(item)
    item.name == 'Aged Brie'
  end
# End of class below
end
