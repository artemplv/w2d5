require_relative "item"

class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = "")
    begin
      new_item = Item.new(title, deadline, description)
      @items.push(new_item)
      return true
    rescue => exception
      puts "Error: #{exception.message}"
      return false
    end
  end

  def size
    @items.length
  end

  def valid_index?(index)
    if @items[index] && index >= 0
      return true
    end
    false
  end

  def swap(index_1, index_2)
    if !valid_index?(index_1) || !valid_index?(index_2)
      return false
    end

    @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
    true
  end

  def [](index)
    @items[index]
  end

  def priority
    @items.first
  end

  def print    
    # list label
    puts Horizontal_border
    puts label.upcase.center(100)
    puts Horizontal_border
    
    # column titles
    puts make_print_row('Index', 'Item', 'Deadline')
    puts Horizontal_border

    # content rows
    @items.each_with_index do |item, i|
      puts make_print_row(i.to_s, item.title, item.deadline)
    end

    # closing border
    puts Horizontal_border
  end

  def print_full_item(index)
    if !valid_index?(index)
      return
    end

    item = @items[index]
    puts Horizontal_border
    puts item.title
    puts item.description
    puts item.deadline
    puts Horizontal_border
  end

  def print_priority
    print_full_item(0)
  end

  def up(index, amount = 1)
    if !valid_index?(index)
      return false
    end

    target_index = index
    amount.times do
      next_index = target_index - 1

      if !valid_index?(next_index)
        break
      end
      
      @items[target_index], @items[next_index] = @items[next_index], @items[target_index]
      target_index = next_index
    end

    true
  end

  def down(index, amount = 1)
    if !valid_index?(index)
      return false
    end

    target_index = index
    amount.times do
      next_index = target_index + 1

      if !valid_index?(next_index)
        break
      end
      
      @items[target_index], @items[next_index] = @items[next_index], @items[target_index]
      target_index = next_index
    end

    true
  end

  def sort_by_date!
    @items.sort_by! { |item| item.deadline }
  end
end


##
Horizontal_border = "".ljust(100, '-')
Vertical_border = "|".center(5)

def make_print_row(col_1, col_2, col_3)
  col_1_str = col_1.ljust(8)
  col_2_str = col_2.ljust(56)
  col_3_str = col_3.ljust(26)

  col_1_str + Vertical_border + col_2_str + Vertical_border + col_3_str
end
