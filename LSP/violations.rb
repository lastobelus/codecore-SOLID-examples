############################################################################
# refused bequest
############################################################################

class Rectangle
  attr_accessor :width, :height
  def area
    width * height
  end
end

class Square < Rectangle
  attr_accessor :side
  def height=(height)
    @side = height
  end

  def width=(width)
    @side = width
  end

  def width
    @side
  end

  def height
    @side
  end
end

class ShapeSetup
  WIDTH = 7
  HEIGHT = 5

  def setRectangleWidthHeight(shapes)
    shapes.each do |shape|
      shape.width = 7
      shape.height = 5
      raise "Refused Bequest" unless 35 == shape.area
    end
  end
end

############################################################################
# Exceptions
############################################################################

class Account
  class InsufficientFunds < RuntimeError; end
  attr_accessor :balance
  def initialize(balance)
    @balance = balance
  end
  def withdraw(amt)
    raise InsufficientFunds unless balance >= amt
    balance -= amt
    balance
  end
end

class BadOverdraftAccount < Account
  class ExceededOverdraftLimit < RuntimeError; end
  attr_accessor :overdraft_limit
  def initialize(balance, overdraft_limit)
    @overdraft_limit = overdraft_limit
    super(balance)
  end
  def withdraw(amt)
    raise ExceededOverdraftLimit unless balance >= (amt - overdraft_limit)
    balance -= amt
    balance
  end
end

class GoodOverdraftAccount < Account
  class ExceededOverdraftLimit < Account::InsufficientFunds; end
  attr_accessor :overdraft_limit
  def initialize(balance, overdraft_limit)
    @overdraft_limit = overdraft_limit
    super(balance)
  end
  def withdraw(amt)
    raise ExceededOverdraftLimit unless balance >= (amt - overdraft_limit)
    balance -= amt
    balance
  end
end

class Withdrawal
  attr_accessor :amount, :account, :succeeded
  def initialize(account, amount)
    @amount = amount
    @account = account
  end
  def take_money!
    account.withdraw(amount)
    succeeded = true
    amt
  rescue Account::InsufficientFunds
    succeeded = false
    0
  end
end


############################################################################
# Strengthen Pre-conditions
############################################################################

class Vehicle
  attr_accessor :position
  def move(amt)
    position += amt
  end
end

class CoasterBike < Vehicle
  def move(amt)
    raise "can't go backwards" if amt < 0
    super
  end
end

############################################################################
# Weaken Post-conditions
############################################################################

class DB
  def query(q)
    open_connection
    connection.run q
    close_connection
  end
end

class BadDBSubclass < DB
  def query(q)
    connection = connection_pool.get()
    connection.open
    connection.run q
  end
end




if __FILE__ == $0

  puts ARGV[0]
  case ARGV[0]
  when "refused-bequest"
    puts "Refused Bequest:"
    shapes = [Square.new, Rectangle.new]
    ShapeSetup.new.setRectangleWidthHeight(shapes)

  when "exceptions"

    bad = BadOverdraftAccount.new(5, 5)
    good = GoodOverdraftAccount.new(5, 5)

    money_1 = Withdrawal.new(good, 11).take_money!
    puts "money received: #{money_1}"

    money_2 = Withdrawal.new(bad, 11).take_money!
    puts "money received: #{money_2}"
  end
end