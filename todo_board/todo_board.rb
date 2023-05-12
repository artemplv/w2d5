require_relative 'list'

class TodoBoard
  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    print 'Enter a command and arguments: '
    cmd, *args = gets.chomp.split(' ')

    case cmd
      when 'mktodo'
        @list.add_item(*args)
      when 'up'
        @list.up(*args)
      when 'down'
        @list.down(*args)
      when 'swap'
        @list.swap(*args)
      when 'sort'
        @list.sort_by_date!
      when 'priority'
        @list.print_priority
      when 'print'
        if args.empty?
          @list.print
        else
          @list.print_full_item(*args)
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