require_relative 'list'

class TodoBoard
  def initialize
    @lists = Hash.new
  end

  def get_command
    print 'Enter a command: '
    cmd, *args = gets.chomp.split(' ')

    label = args.shift

    case cmd
      when 'mklist'
        @lists[label] = List.new(label)
      when 'ls'
        @lists.keys.each { |key| puts key }
      when 'showall'
        @lists.values.each { |list| list.print }
      when 'mktodo'
        @lists[label].add_item(*args)
      when 'up'
        @lists[label].up(*args)
      when 'down'
        @lists[label].down(*args)
      when 'swap'
        @lists[label].swap(*args)
      when 'sort'
        @lists[label].sort_by_date!
      when 'priority'
        @lists[label].print_priority
      when 'toggle'
        @lists[label].toggle_item(*args)
      when 'rm'
        @lists[label].remove_item(*args)
      when 'purge'
        @lists[label].purge
      when 'print'
        if args.empty?
          @lists[label].print
        else
          @lists[label].print_full_item(*args)
        end
      when 'quit'
        return false
      else
        puts 'Sorry, that command is not recognized.'
    end

    true
  end

  def run
    running = true
    
    while running do
      puts "\n-------------------------"
      running = get_command()
    end
  end
end

# my_board = TodoBoard.new
# my_board.run