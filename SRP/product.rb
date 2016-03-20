require 'awesome_print'

class Product
  attr_accessor :name, :description, :cost, :inventory

  def self.all
    @all ||= []
  end

  def initialize(columns)
    @name = columns[0]
    @description = columns[1]
    @cost = columns[2]
    @inventory = columns[3]
  end

  def self.import_products(csv)
    csv.each_line do |product_line|
      columns = product_line.chomp.split(/ *, */)
      columns[2] = columns[2].to_f
      columns[3] = columns[3].to_i
      all << new(columns)
    end
  end

  def price
    cost * 2
  end

  def order(qty)
    if inventory >= qty
      inventory -= qty
      true
    else
      false
    end
  end

  def resupply(qty)
    inventory += qty
  end

  def header
    <<-eos.gsub(/^ {6}/, '')
      <div class="product-header">
        <h1>#{@name}</h1>
        <p>#{@description}<p>
      </div>
    eos
  end
end


if __FILE__ == $0
  Product.import_products <<-eos.gsub(/^ {4}/, '')
    mop, a tool for cleaning, 4.00, 100
    shiny tool, a tool for playing, 2.00, 200
  eos

  puts "All Products:"
  ap Product.all

  puts "Product Header of first Product:"
  puts Product.all.first.header
end
