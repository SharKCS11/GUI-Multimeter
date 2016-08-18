 require 'gosu'
 require 'arduino_firmata'


 module Zorder
 	Background, Buttons, Text = *0..2;
 end

 class MeterWindow < Gosu::Window
 	def initialize
 		puts Zorder::Background
 		@first_draw=1;
 		@width_wrapper=720;
 		@height_wrapper=480;
 		@background_color=Gosu::Color.argb(0xff_808080);
 		@redr=true;
 		@font_large=Gosu::Font.new(72,{:name => "Lato Medium"});
 		@font_medium=Gosu::Font.new(45,{:name => "Lato Medium"})
 		@font_small=Gosu::Font.new(36,{:name => "Ubuntu"});
 		@measuring = false;
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
 		@measuring = false if stop_clicked?
 		@first_draw = 1 if stop_clicked?
 		if @measuring then @redr=true else @redr=false end;
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

 	def needs_cursor?
 		true;
 	end

 	def needs_redraw?
 		if @first_draw==1
 			return true;
 		else
 			return @redr;
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

 		# Voltage reader
 		stopped_str="Press \"Measure\" to start";
 		unless @measuring
 			@font_medium.draw(stopped_str,210,290,
 				              Zorder::Text,1,1,0xff_00FF44); 		
 		else
 			val = @ard.analog_read 1;
    		val = val * (5.0/1024.0) * 2;
 			@font_medium.draw("#{val.round(2)} V",320,290,
 				              Zorder::Text,1,1,0xff_00FF44);
 			sleep(0.5);
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