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
      return if item.name == "Sulfuras, Hand of Ragnaros"

      # Deals with quility before sell by date
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"

          # removes quality
          single_quality_remover(item)

      # Aged Brie and Backstage Passes
      else
        if item.quality < 50
          # adds quality
          single_quality_increase(item)
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

      # Removes sell in day from all items apart from Sulfuras, Hand of Ragnaros
      single_sell_in_day_remover(item)

      # Deals with quility after sell by date
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"

              single_quality_remover(item)

          #sets Backstage pass quality to 0 after sell by date (gig)
          else
            item.quality = item.quality - item.quality
          end
        # stops quality going over 50
        else
        single_quality_increase(item)
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
    item.quality -= 1 if item.quality > 0
  end

  def single_quality_increase(item)
      item.quality += 1 if item.quality < 50
  end

# End of class below
end
