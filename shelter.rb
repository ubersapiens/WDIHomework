require 'pry'
require 'pg'

def show_clients (conn)
	conn.exec( "select * from clients" ) do |result|
	  result.each do |row|
	    puts row['name']
	  end
	end
end

def show_animals (conn)
	conn.exec( "select * from animals" ) do |result|
	  result.each do |row|
	    puts row['name']
	  end
	end
end

def add_clients (conn)
	print 'name: '
	name = gets.chomp

	sql = "insert into clients (name) values ('#{name}')"
	conn.exec(sql)
end

#Add animals method
def add_animals (conn)
	print 'name: '
	name = gets.chomp
	print 'nickname: '
	nickname = gets.chomp
	print 'age: '
	age = gets.chomp.to_i
	print 'number_of_toys: '
	number_of_toys = gets.chomp.to_i
	print 'breed: '
	breed = gets.chomp

	sql = "insert into animals (name, nickname, age, number_of_toys, breed) values ('#{name}', '#{nickname}', '#{age}', '#{number_of_toys}', '#{breed}')"
	conn.exec(sql)
end

def run_program
  conn = PG.connect(:dbname =>'shelter', :host => 'localhost')
  
	#Introduction to Animal Shelter
	puts "Welcome to Animal Shelter Database"

  while true do
  	#Choosing database entry type
  	puts "To choose type of operation type:"
  	puts "Adding clients (1)"
  	puts "Show clients (2)"
  	puts "Adding animals (3)"
  	puts "Show animals (4)"
    puts "Quit program (q)"
  
    case gets.chomp.to_s
  	when "1"
  		add_clients(conn)
  	when "2"
  		show_clients(conn)
  	when "3"
  		add_animals(conn)
  	when "4"
  		show_animals(conn)
  	else 
  		break
  	end
  end

  conn.close
end 

run_program