require  'tty-table'                    # Tablemaker
require 'io/console'                    # For the press any key method

# Arrays
table_headers = ["Name", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
employee_hours = [['James','n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a'], ['Tim','n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a' ], ['John','n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a']]
awful_array_of_nothing = 'n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a'    ##### Gross yet effective #####
# Variables
employee_roster = 0
name = 0
day = 0
day_array = 0
name_remove = 0

def continue                            # Press any key to continue function                                                                      
    print "Press any key to continue"                                                                                                    
    STDIN.getch                                                                                                              
    print "            \r" # extra space to overwrite in case next sentence is short  
    system('clear')                                                                                                            
end  

def get_roster(name,employee_hours)             # Retrieves the roster from within the nested array
    employee_hours.each do |roster|
        if name == roster[0]
            return roster
        end
    end
end
def find_day(day, table_headers)
    table_headers.index(day)
end
system('clear')
puts "Welcome to rostr app"       # Smooth talking for the opener
continue
loop do
    system('clear')
    puts "What would you like to do?"
    puts "[E]dit (Roster), [C]reate (New employee), [D]isplay (Current Roster), [Q]uit"
    menu_selection = gets.chomp.capitalize
    case menu_selection
    when "Edit", "E"                  # Creates or edits the current roster with any changes.
        system('clear')
        puts "Enter employee name"
        name = gets.chomp.capitalize
        employee_roster = get_roster(name,employee_hours)
        
        puts "Which day would you like to make changes to?"# Finds the day and returns the index of the required input
        day = gets.chomp.capitalize 
        day_array = table_headers.index(day)
        
        loop do
            puts "Is #{name} working on #{day}? y/n" #If y then input is required to edit the roster n will default to n/a
            employee_roster.delete_at(0)
            employee_roster.insert(0, name)
            day_working = gets.chomp.downcase
            if day_working == "y"
                puts "What time do they start?"     #Start time of shift for that day
                time_start = gets.chomp
                puts "What time do they finish?"    #End time of shift for that day
                time_end = gets.chomp
                employee_roster.delete_at(day_array)
                employee_roster.insert(day_array, "#{time_start} - #{time_end}")
                break
            elsif day_working == "n"
                employee_hours.insert(day_array, "n/a")  #the default for unnassigned spaces in roster
                break               
            else 
                puts "Invalid selection"   #If the user tries to go off the rails
            end        
        end
        
    when "Create", "C"                       # Allows entry of a new employee into the roster
        system('clear')
        puts "What is the name of this newly acquired individual?"
        employee_hours << awful_array_of_nothing.unshift(gets.chomp.capitalize)
        
    when "Display", "D"                     # Displays the current scheduled roster
        system('clear')
        puts "Your current roster is:"
        table = TTY::Table.new table_headers, employee_hours
        puts table.render(:ascii)
        continue
        
        # when "Remove", "R"
        #     puts "What is the name of the employee you are removing?"
        #     name_remove = get_roster((gets.chomp.capitalize), employee_hours)
        #     name_remove.delete
        
    when "Quit", "Q"                        # Quits out of the application
        continue
        system('clear')
        break
    else
        puts "Invalid selection"
    end
end
puts "Your completed roster is:"
table = TTY::Table.new table_headers, employee_hours
puts table.render(:ascii)