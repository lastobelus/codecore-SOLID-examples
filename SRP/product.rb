require 'awesome_print'
require_relative 'product_importer'
class Product
  attr_accessor :name, :description, :cost, :inventory

  def self.all
    @all ||= []
  end

  def initialize(args)
    @name = args[:name]
    @description = args[:description]
    @cost = args[:cost]
    @inventory = args[:inventory] || 0
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
  importer = ProductImporter.new <<-eos.gsub(/^ {4}/, '')
    mop, a tool for cleaning, 4.00, 100
    shiny tool, a tool for playing, 2.00, 200
  eos

  importer.import

  puts "All Products:"
  ap Product.all

  puts "Product Header of first Product:"
  puts Product.all.first.header
end
