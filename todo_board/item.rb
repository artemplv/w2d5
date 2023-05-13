class Item
  attr_accessor :title, :description
  attr_reader :deadline, :done

  def initialize(title, deadline, description)
    unless Item.valid_date?(deadline)
      raise ArgumentError.new "Deadline is invalid date"
    end

    @title = title
    @deadline = deadline
    @description = description
    @done = false
  end

  def self.valid_date?(date)
    date_arr = date.split('-')
    check_date(date_arr)
  end

  def deadline=(date)
    unless Item.valid_date?(date)
      raise ArgumentError.new "Deadline is invalid date"
    end

    @deadline = date
  end

  def toggle
    @done = !@done
  end
end


##
def check_date(date)
  year = date[0]
  month = date[1]
  day = date[2]

  valid_year?(year) && valid_month?(month) && valid_day?(day)
end

def valid_year?(year)
  year.length == 4
end

def valid_month?(month)
  month.length == 2 && month.to_i > 0 && month.to_i < 13
end

def valid_day?(day)
  day.length == 2 && day.to_i > 0 && day.to_i < 32
end
