class ProductImporter
  attr_reader :csv
  attr_writer :delimiter

  def initialize(csv)
    @csv = csv
  end

  def delimiter
    @delimiter ||= / *, */
  end

  def headers
    [:name, :description, :cost, :inventory]
  end

  def import
    csv.each_line do |product_line|
      attrs = csv_line_to_hash(product_line)
      cast_column_values!(attrs)
      create_product(attrs)
    end
  end

  def cast_column_values!(attrs)
    attrs[:cost] = attrs[:cost].to_f
    attrs[:inventory] = attrs[:inventory].to_i
  end

  def csv_line_to_hash(line)
    columns = line.chomp.split(delimiter)
    attrs = Hash[headers.zip(columns)]
  end

  def create_product(attrs)
    product = Product.new(attrs)
    product.create
  end
end

class WonkyOrderProductImporter < ProductImporter
  def headers
    [:_dontcare, :_dontcare, :description, :cost, :name, :inventory]
  end
end

class XMLProductImporter < ProductImporter
  def cast_column_values!(attrs)
    super
    attrs[:description] = attrs[:description].gsub(/<[^>]+>/, '')
  end
end