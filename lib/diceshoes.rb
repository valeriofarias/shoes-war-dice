require 'dice'

Shoes.app :title => "Dices of War game", :width => 500, :height => 500 do
	background gradient(black, teal)

   para "Red", :stroke => tomato
   @numberreddices = list_box :items => ["1", "2", "3"],
      :width => 70, :choose => "3" do |list|
   end
   
   para " X ", :stroke => snow
   @numberyellowdices = list_box :items => ["1", "2", "3"],
      :width => 70, :choose => "3" do |list|
   end
   
   para "Yellow", :stroke => yellow
 
   # Define a aleatory position
  	@a = @b = @c = []

  	(40..200).step(10){  | x | @a << x }
  	(230..450).step(10){ | y | @b << y }
	(80..450).step(10){  | z | @c << z }
  
  	# inicialize war dices object
	@reddices = []
	@yellowdices = []
  	@names2 = []
  	
  	button "Attack", :width => 80 do
  	
  		@dice.each{  | d | d.remove }
		@names2.each{| a | a.remove }	
		
		wardices = WarDices.new( @numberreddices.text.to_i, @numberyellowdices.text.to_i ) 
  		@reddices = wardices.reddices
  		@yellowdices = wardices.yellowdices
 		@result = wardices.result
  		
  	   @reddices.each{ |item| draw(@a[rand(@a.length)], @c[rand(@c.length)], item.to_s.to_i, 1, true) }
 	   @yellowdices.each{ |item| draw(@b[rand(@b.length)], @c[rand(@c.length)], item.to_s.to_i, 2, true)}

 	end 
 	
 	button "Verify", :width => 80 do
  	
  		@dice.each{  | d | d.remove }
  		@names2.each{| a | a.remove }	

   	yellowx = 250
		redx = 150
		redy = yellowy = 100  
  	
  	   @reddices.each do  | item | 
  	   	draw( redx, redy, item.to_s.to_i, 1, false )  
  	   	redy += 100
  	   end		
  	   	
 	   @yellowdices.each do | item | 
 	   	draw( yellowx, yellowy, item.to_s.to_i, 2, false )
 	   	yellowy += 100
 	   end
 	   
 	   resultx = 300
 	   resulty = 80
 	   @result.each do | item |
 	   	@names = para item.to_s, :stroke => snow, :top => resulty, :left => resultx
 	   	resulty += 100
 	   	@names2 << @names
 	   end
 	    

 	end
 	
 
	# Method draw was based in the Pretty Dice project written by Ed Heil 
 
  	@dice = []
  	
  	def draw( left, top, number, color, rotate )
  		 
    imagewidth  = 60
    imageheight = 60 

    i = image( imagewidth, imageheight, 
           :top  => top - imagewidth / 2, 
           :left => left - imagewidth / 2,
           :shadow => 10, :center => true ) do
      
      if color == 1 
      	strokecolor = red
      	fillrectanglecolor = tomato
      	filldotscolor = darkred
      else
         strokecolor = yellow
      	fillrectanglecolor = lightgoldenrodyellow
      	filldotscolor = chocolate
      end 


      sw = 1
      strokewidth sw
      stroke strokecolor
      
      fill fillrectanglecolor
		
      inset  = 2
      inset2 = 8

      rect( inset, inset, imagewidth-inset-sw, imageheight-inset-sw, 10 )

      fill filldotscolor
      
      ovalradius = 10
      low  = inset2
      high = imagewidth - inset2 - ovalradius
      mid  = (imagewidth - ovalradius ) / 2

      oval( mid, mid, ovalradius ) if number % 2 == 1

      if number > 1
        oval( low, low, ovalradius )
        oval( high, high, ovalradius )
      end

      if number > 3
        oval(low, high, ovalradius )
        oval(high, low, ovalradius )
      end

      if number > 5
        oval( mid, low, ovalradius )
        oval( mid, high, ovalradius )
      end
    
    end # end of image block

    i.rotate(rand(359)) if rotate

    @dice << i 

  end
	
end
