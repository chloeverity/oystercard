class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_TRAVEL_BALANCE = 1
attr_reader :balance
attr_accessor :status

  def initialize(status = false)
    @balance = 0
    @status = status
  end

  def top_up(amount)
    raise "Limit exceeded" if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
   @status
  end

  def touch_in
    fail "Not enough money" if @balance < MINIMUM_TRAVEL_BALANCE
    change_status
  end

  def touch_out
    change_status
  end

  def change_status
    @status = (@status == true ? false : true)
  end
end
