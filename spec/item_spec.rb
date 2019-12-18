require 'item'

describe Item do

  context "#initialize" do
    it "Item has correct info" do
      item = Item.new("+5 Dexterity Vest", 10, 20)
      expect(item.to_s).to eq "+5 Dexterity Vest, 10, 20"
    end
  end

end
