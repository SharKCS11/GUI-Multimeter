# GUI Multimeter
This is a small multimeter that can be used to measure voltage and current in a circuit. The electronics are built using an Arduino Mega2560 (Arduino UNO will suffice as well), which can interface with both Ruby and Matlab code.

The project build updates are detailed in Changelog.md. Below are the instructions for building and running the multimeter.

<h3> The Circuit </h3>
The multimeter was built using a Funduino Mega2560, but can also be replicated with an Arduino Mega2560 or Arduino UNO. Any other microcontroller that supports 5V GPIO should work too.
To build the circuit, you will need: _a breadboard, four or five wires to go with it, and two resistors_. I used two 1.2 kΩ resistors, but any value between 100Ω and 10kΩ will work, as long as you adjust any calculations that require those resistance values.

The circuit diagram and pin connections to the Arduino can be found in this repository (circuit_diagram.png). First connect the negative rail on the breadboard to "ground" on the Arduino. Then put a wire into the analog input pin "A1" and connect it to a point on the breadboard. A single resistor should come both before and after the analog-in wire; by connecting a positive probe to the first resistor, a negative probe to the second resistor, and a wire to the negative rail after the second resistor, you will have created a voltage divider. Refer to the diagram for a better understanding of the circuit setup.

The arduino/breadboard combination will now accept up to 10V of input. **Important: Do not connect a voltage greater than 10V to the probes.** The Arduino Mega's analog-in pins are only designed to accept up to 5V. If you want to change the maximum voltage, you will have to choose a different resistor ratio, or wire more resistors up in series.

Before running either the Matlab or Ruby program, connect the 

<h3> Running the Voltmeter on Matlab (Windows or Linux) </h3>
Only the voltmeter has been implemented in Matlab. In order to run it, first make sure you have Matlab and the Arduino support package installed. Instructions here: http://www.allaboutcircuits.com/projects/arduino-interface-with-matlab/
Then, download the files "app\_layout.fig" and "app\_layout.m" from the repository. Make sure they are in your working directory, and run "app\_layout.m". The voltmeter should run automatically. Press "Measure" to start measuring the voltage between the two probes. Remember to connect the negative source to the negative probe and positive to positive!

<h3> Running the Multimeter on Ruby (Linux Recommended) </h3>
Requirements: Arduino IDE and latest Ruby version should be installed.

1. Install the Firmata gem. Instructions here: http://playground.arduino.cc/Interfacing/Ruby
2. Next, open Arduino IDE and run the "Standard Firmata" program with the Arduino connected to the computer. 
3. Install the gosu dependency by running `$ gem install gosu` on command line.
4. Download the files "connect.rb" and "voltm.rb" from the repository.
5. To test the arduino connection, run `$ ruby connect.rb`. If successful, the program will confirm the firmata connection and the version. Sometimes, it can take about one minute for a ruby program to actually detect the arduino. If the connection fails, press Ctrl+C to terminate the program, and try again until it connects.
6. You are ready to run the voltmeter now. Enter `$ ruby voltm.rb` in command line and a window should open up with a "measure" and "stop" button.
7. Press the "Measure" button to start measuring the voltage between two probes. If you want to measure current through the analog-input wire instead, press the "switch to amps" button below. You can switch between the voltmeter and ammeter at any time.

**Note**: The ammeter calculates the current passing through the point at which the analog-in wire intersects the circuit using the measured voltage. It assumes a voltage divider using two 1.2kΩ resistors. If you use a different resistor value, replace line 12 in voltm.rb that reads ` @@single_resistor = 1200 ` with your own resistance value in Ohms.
Additionally, by performing this calculation, _the ammeter ignores its own internal impedance_. As a result, the measurement will always be slightly inaccurate.
