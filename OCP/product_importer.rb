require 'json'

class ProductImporter
  attr_reader :supplier

  def initialize(args)
    @supplier = args[:supplier]
  end

  def import
    raise "Not implemented"
  end

  def create_product(attrs)
    product = Product.new(attrs)
    product.supplier = supplier
    product.create
  end

  def cast_column_values!(attrs)
    attrs[:cost] = attrs[:cost].to_f
    attrs[:inventory] = attrs[:inventory].to_i
  end

end

class ProductCSVImporter < ProductImporter
  attr_accessor :delimiter, :headers

  def initialize(args)
    @delimiter = args[:delimiter] || / *, */
    @headers = args[:headers] || [:name, :description, :cost, :inventory]
    super(args)
  end

  def import(data)
    data.each_line do |product_line|
      attrs = csv_line_to_hash(product_line)
      cast_column_values!(attrs)
      create_product(attrs)
    end
  end

  def csv_line_to_hash(line)
    columns = line.chomp.split(delimiter)
    attrs = Hash[headers.zip(columns)]
  end

end

class ProductJSONImporter < ProductImporter
  attr_accessor :keymap

  def initialize(args)
    @keymap = args[:keymap] || {}
    super(args)
  end

  def import(data)
    json_hash = JSON.parse(data)
    json_hash["products"].each do |product_hash|
      attrs = {}
      product_hash.each do |key, value|
        key = keymap.fetch(key, key)
        attrs[key.to_sym] = value
      end
      cast_column_values!(attrs)
      create_product(attrs)
    end
  end
end
