# Dice and WarDices classes
# Author: Valério Farias
# email: valeriofc [at] gmail [dot] com

class Dice
	def initialize
		play
	end
	
	def play
		@number = rand(6) + 1
	end
	
	def show_number
		@number
	end
end

# We need to put the module comparable into array class
class Array; include Comparable; end


#  Red and yellow dice for war game
class WarDice 
	attr_reader :red, :yellow, :reddice, :yellowdice, :result

	def initialize(red, yellow)
		@red, @yellow = red, yellow
		@red = rand(3) + 1 if @red.to_s.grep(/^[1-3]$/).empty?
		@yellow = rand(3) + 1 if @yellow.to_s.grep(/^[1-3]$/).empty?
		
		@reddice = []
		@yellowdice = []
		@result = []
		
		@dice = Dice.new		
		@red.times{|row| @reddice[row] = [@dice.play] }
		@yellow.times{ |row| @yellowdice[row] = [@dice.play] }
		
		@reddice.sort!{|x, y| y <=> x }
		@yellowdice.sort!{|x, y| y <=> x }
		attack
	end

	def attack
		@reddice.each_with_index  do |item, index| 
   		next if @yellowdice[index].nil?
   		reddice = item
   		yellowdice = @yellowdice[index]

			if reddice > yellowdice 
				@result << "Red Win"
			else
			 	@result << "Yellow Win"
			end
		end 		
	end

end
