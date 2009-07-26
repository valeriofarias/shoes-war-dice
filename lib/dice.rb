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


#  Red and yellow dices for war game
class WarDices 
	attr_reader :red, :yellow, :reddices, :yellowdices, :result

	def initialize(red, yellow)
		@red, @yellow = red, yellow
		@red = rand(3) + 1 if @red.to_s.grep(/^[1-3]$/).empty?
		@yellow = rand(3) + 1 if @yellow.to_s.grep(/^[1-3]$/).empty?
		
		@reddices = []
		@yellowdices = []
		@result = []
		
		@dice = Dice.new		
		@red.times{|row| @reddices[row] = [@dice.play] }
		@yellow.times{ |row| @yellowdices[row] = [@dice.play] }
		
		@reddices.sort!{|x, y| y <=> x }
		@yellowdices.sort!{|x, y| y <=> x }
		attack
	end

	def attack
		@reddices.each_with_index  do |item, index| 
   		next if @yellowdices[index].nil?
   		reddice = item
   		yellowdice = @yellowdices[index]

			if reddice > yellowdice 
				@result << "Red Win"
			else
			 	@result << "Yellow Win"
			end
		end 		
	end

end

