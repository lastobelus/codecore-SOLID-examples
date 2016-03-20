class ProductImporter
  attr_reader :csv

  def initialize(csv)
    @csv = csv
  end

  def headers
    [:name, :description, :cost, :inventory]
  end

  def import
    csv.each_line do |product_line|
      columns = product_line.chomp.split(/ *, */)
      attrs = Hash[headers.zip(columns)]
      attrs[:cost] = attrs[:cost].to_f
      attrs[:inventory] = attrs[:inventory].to_i
      Product.all << Product.new(attrs)
    end
  end

end
