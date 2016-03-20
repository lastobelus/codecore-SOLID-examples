class ProductImporter
  attr_reader :csv

  def initialize(csv)
    @csv = csv
  end

  def import
    csv.each_line do |product_line|
      name, description, cost, inventory = product_line.chomp.split(/ *, */)
      cost = cost.to_f
      inventory = inventory.to_i
      Product.all << Product.new(name, description, cost, inventory)
    end
  end

end
