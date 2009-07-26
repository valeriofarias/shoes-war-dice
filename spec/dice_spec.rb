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

describe WarDices do
	it "The attack and defense should use 1, 2 or 3 dices" do 
		wardices = WarDices.new(0, 7)
		wardices.red.to_s.should match(/^[1-3]$/)
		wardices.yellow.to_s.should match(/^[1-3]$/)

		wardices2 = WarDices.new(2, 3)
		wardices2.red.should == 2
		wardices2.yellow.should == 3
	end
	
	it "Should provide yellow and red dices results with an array in decreasing sort" do
		wardices = WarDices.new(3, 3)
		wardices.reddices.is_a?(Array).should be_true
		wardices.yellowdices.is_a?(Array).should be_true
		
		wardices.reddices.sort{|x, y| y <=> x }.should == wardices.reddices
		wardices.yellowdices.sort{|x, y| y <=> x }.should == wardices.yellowdices
	
	end
	
	it "Should compare from bigger to less values and save in array result" do
		wardices = WarDices.new(3, 2)
		wardices.reddices.first.should > wardices.reddices.last
		wardices.attack

		wardices.result[0].should == "Red Win" if wardices.reddices[0] > wardices.yellowdices[0]
		wardices.result[0].should == "Yellow Win" if wardices.reddices[0] <= wardices.yellowdices[0]
	end
end





