 require 'gosu'
 require 'arduino_firmata'


 module Zorder
 	Background, Buttons, Text = *0..2;
 end

 class MeterWindow < Gosu::Window
 	def initialize
 		
 		@@single_resistor = 1200 # The resistance of ONE resistor in the voltage divider

 		@@unit_mode_strings=["Volts","Amps"];
 		@first_draw=1;
 		@width_wrapper=720;
 		@height_wrapper=480;
 		@background_color=Gosu::Color.argb(0xff_808080);
 		@redr=true;
 		@font_large=Gosu::Font.new(72,{:name => "Lato Medium"});
 		@font_medium=Gosu::Font.new(45,{:name => "Lato Medium"})
 		@font_small=Gosu::Font.new(36,{:name => "Ubuntu"});
 		@font_tiny=Gosu::Font.new(24,{:name => "Ubuntu"});
 		@measuring = false;
 		@counter=0;
 		@val = 0.00;
 		@unit_mode=1; # 1 for volts, 2 for amps 
 		needs_cursor=true;
 		super(720,480);
 		self.caption = "Voltmeter test";

 		print "Connecting..."
 		@ard = ArduinoFirmata.connect
 		puts "Connection successful: Firmata version #{@ard.version}"

 	end

 	def update
 		@redr=false;
 		@msx=mouse_x;
 		@msy=mouse_y;
 		@measuring = true if measure_clicked?
 		if stop_clicked?
 			@measuring=false;
 			@first_draw=1;
 			@counter=0;
 		end

 		if switch_clicked?
 			@unit_mode=3-@unit_mode;
 			sleep(0.5);
 		end

 		if @measuring
 			@redr=true
 			@counter = (@counter + 1)%30;
 		else
 			@redr=false 
 		end;
 	end

 	def measure_clicked?
 		if button_down?(Gosu::MsLeft)
 			if (@msx.between?(100,250) and @msy.between?(110,190))
 				return true;
 			end
 		end
 		return false;
 	end

 	def stop_clicked?
 		if button_down?(Gosu::MsLeft)
 			if (@msx.between?(489,639) and @msy.between?(110,190))
 				return true;
 			end
 		end
 		return false;
 	end

 	def switch_clicked?
 		if @measuring and button_down?(Gosu::MsLeft)
 			if(@msx.between?(275,465) and @msy.between?(380,415))
 				return true;
 			end
 		end
 		return false;
 	end

 	def needs_cursor?
 		true
 	end

 	def needs_redraw?
 		if @first_draw==1
 			return true
 		else
 			return @redr
 		end
 	end

 	def draw
 		# puts "Redrawing..."; # use for debugging drawing updates
 		draw_rect(0,0,@width_wrapper,@height_wrapper, \
 			      @background_color,Zorder::Background);
 		@font_large.draw("VOLTAGE",257,30,Zorder::Text,1,1,0xff_00FF44);

 		# Measure and Stop buttons
 		draw_rect(100,110,150,80,0xff_AAAAAA,Zorder::Buttons);
 		@font_small.draw("MEASURE",118,132,Zorder::Text,1,1,0xff_000000);
 		draw_rect(489,110,150,80,0xff_AAAAAA,Zorder::Buttons);
 		@font_small.draw("STOP",530,132,Zorder::Text,1,1,0xff_000000);
 		#Mode switch button
 		if @measuring
	 		draw_rect(275,380,190,35,0xff_FF889B,Zorder::Buttons);
	 		@font_tiny.draw("Switch to #{@@unit_mode_strings[2-@unit_mode]}", \
	 			             304,388,Zorder::Text,1,1,0xff_000000);
 		end

 		# Voltage reader
 		stopped_str="Press \"Measure\" to start";
 		unless @measuring
 			@font_medium.draw(stopped_str,210,290,
 				              Zorder::Text,1,1,0xff_00FF44); 		
 		else
 			# The final value of "val" is the voltage between ground
 			# and one resistor.  Current will be measured at the point
 			# at which the analog-in probe is connected to any circuit.
 			if(@counter==0)
 				@val = @ard.analog_read 1;
    			@val = @val * (5.0/1024.0) * 2;
    		end
    		if @unit_mode==1 # measuring volts
    			val_str=sprintf("%.2f",@val) + " V";
    		elsif @unit_mode==2 # measuring amps
    			curr=@val/(2*@@single_resistor) * 1000;
    			val_str=sprintf("%.2f",curr) + " mA";
    		end
 			@font_medium.draw(val_str,320,290,
 				              Zorder::Text,1,1,0xff_00FF44);
 			# sleep(0.5);
 		end
 		@first_draw=0;
 	end

 	def draw_rect(x_in,y_in,width_in,height_in,color_in,z)
 		draw_quad(x_in,y_in,color_in, \
 			 	  x_in+width_in,y_in,color_in, \
 			 	  x_in+width_in,y_in+height_in,color_in, \
 			 	  x_in,y_in+height_in,color_in,z);
 	end

 end

 Window=MeterWindow.new;
 Window.show;