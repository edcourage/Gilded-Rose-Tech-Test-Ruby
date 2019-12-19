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
        if past_sell_by_day?(item)
          # removes double quality
          quality_remover(item, amount: 2)
        else
          quality_remover(item)
        end

        # Aged Brie and Backstage Passes
      else
          if item.name == 'Aged Brie'
            if past_sell_by_day?(item)
              quality_increase(item, amount: 2)

            else
              quality_increase(item)
            end

          else # Backstage Passes for remainder of if statement
            

              if past_sell_by_day?(item)
                quality_remover(item, amount: item.quality)
              elsif item.sell_in < 6
                 quality_increase(item, amount: 3)
              elsif item.sell_in < 11
                quality_increase(item, amount: 2)
              else
                quality_increase(item)
              end


          end

      end


      single_sell_in_day_remover(item)


      # End of iteration below
    end

  # End of method below
  end


  private

  def single_sell_in_day_remover(item)
    item.sell_in -= 1
  end

  def quality_remover(item, amount:  1)
    item.quality -= amount if min_quality?(item)
  end

  def min_quality?(item)
    item.quality > 0
  end



  def quality_increase(item, amount:  1)
      item.quality += amount if max_quality?(item)
  end

  def max_quality?(item)
    item.quality < 50
  end

  def past_sell_by_day?(item)
    item.sell_in <= 0
  end
# End of class below
end
