%w{rubygems spec lib/dice}.each {|lib| require lib}

describe Dice do 
	before(:each) do
		@dice = Dice.new
	end

	it "should have only numbers 1 to 6" do 
		group = (1..1_000).collect{ @dice.play }.join
		group.should match(/^[1-6]*[1-6]$/)
	end

	# Three groups of 1000 randomic numbers must be different each other
	it "should show the numbers ramdomly" do 
		group1 = (1..1_000).collect{ @dice.play }
		group2 = (1..1_000).collect{ @dice.play }
		group3 = (1..1_000).collect{ @dice.play }
		(group1 == group2).should be_false
		(group1 == group3).should be_false
		(group2 == group3).should be_false
	end

	it "should store the last number after the dice was played." do 
		group1 = (1..100).collect do 
		 	@dice.play 
		 	@dice.show_number 
		end
		group2 = (1..100).collect do 
			@dice.play
			@dice.show_number 
		end	
		(group1 == group2).should be_false
	end
	
	it "should play the dice when dice object was initialized." do
		@dice.show_number.to_s.should match(/^[1-6]*[1-6]$/)
	end

end

describe Array do
	it "should be comparable" do 
		([8,9,10] > [1,2,3]).should be_true 
	end
end

describe WarDice do
	it "The attack and defense should use 1, 2 or 3 dice" do 
		wardice = WarDice.new(0, 7)
		wardice.red.to_s.should match(/^[1-3]$/)
		wardice.yellow.to_s.should match(/^[1-3]$/)

		wardice2 = WarDice.new(2, 3)
		wardice2.red.should == 2
		wardice2.yellow.should == 3
	end
	
	it "Should provide yellow and red dice results with an array in decreasing sort" do
		wardice = WarDice.new(3, 3)
		wardice.reddice.is_a?(Array).should be_true
		wardice.yellowdice.is_a?(Array).should be_true
		
		wardice.reddice.sort{|x, y| y <=> x }.should == wardice.reddice
		wardice.yellowdice.sort{|x, y| y <=> x }.should == wardice.yellowdice
	
	end
	
	it "Should compare from bigger to less values and save in array result" do
		wardice = WarDice.new(3, 2)
		wardice.reddice.first.should > wardice.reddice.last
		wardice.attack

		wardice.result[0].should == "Red Win" if wardice.reddice[0] > wardice.yellowdice[0]
		wardice.result[0].should == "Yellow Win" if wardice.reddice[0] <= wardice.yellowdice[0]
	end
end
