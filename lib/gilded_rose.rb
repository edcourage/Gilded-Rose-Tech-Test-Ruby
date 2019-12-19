require_relative 'item'

class GildedRose

  def initialize(items)
    # An array of Item instances
    @items = items
  end

  def update_quality()
    # Iterates through loop
    @items.each do |item|
      # Nothing is run for Sulfuras, Hand of Ragnaros
      next if item.name == "Sulfuras, Hand of Ragnaros"

      # Deals with quility before sell by date
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if pasted_sell_by_day?(item)
          # removes double quality
          single_quality_remover(item)
          single_quality_remover(item)
        else
          single_quality_remover(item)
        end
        # Aged Brie and Backstage Passes
      else
        if item.quality < 50
          # adds quality
          if pasted_sell_by_day?(item)
            single_quality_increase(item)
            single_quality_increase(item)
          else
            single_quality_increase(item)
          end
          # Backstage Passes for remainder of if statement
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
            single_quality_increase(item)
            end
            if item.sell_in < 6
              # stops quality going over 50
            single_quality_increase(item)
            end
          end
        end
      end


      single_sell_in_day_remover(item)

      # Deals with quility after sell by date
      if item.sell_in < 0
        if item.name != "Aged Brie"

          # #sets Backstage pass quality to 0 after sell by date (gig)

            if item.name == "Backstage passes to a TAFKAL80ETC concert"
              item.quality = item.quality - item.quality
            end


        else
        # single_quality_increase(item)
        end
      end

      # End of iteration below
    end

  # End of method below
  end


  private

  def single_sell_in_day_remover(item)
    item.sell_in -= 1
  end

  def single_quality_remover(item)
    item.quality -= 1 if min_quality?(item)
  end

  def min_quality?(item)
    item.quality > 0
  end


  def single_quality_increase(item)
      item.quality += 1 if max_quality?(item)
  end

  def max_quality?(item)
    item.quality < 50
  end

  def pasted_sell_by_day?(item)
    item.sell_in <= 0
  end
# End of class below
end
