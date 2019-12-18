require_relative 'item'

class GildedRose

  def initialize(items)
    # An array of Item instances
    @items = items
  end

  def update_quality()
    # Iterates through loop
    @items.each do |item|

      # Deals with quility before sell by date
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          # removes quality
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      # Aged Brie and Backstage Passes
      else
        if item.quality < 50
          # adds quality
          item.quality = item.quality + 1
          # Backstage Passes for remainder of if statement
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                # adds quality
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              # stops quality going over 50
              if item.quality < 50
                # adds quality
                item.quality = item.quality + 1
              end
            end
          end
        end
      end

      # Removes sell in day from all items apart from Sulfuras, Hand of Ragnaros
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end

      # Deals with quility after sell by date
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          #sets Backstage pass quality to 0 after sell by date (gig)
          else
            item.quality = item.quality - item.quality
          end
        # stops quality going over 50
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end

      # End of iteration below
    end

  # End of method below
  end

# End of class below
end
