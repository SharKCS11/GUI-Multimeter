# GUI Multimeter
This is a small project to construct a combined voltmeter and ammeter that will output results to a GUI. The GUI will be first built in Matlab and possibly C++. Diagrams may show any board, but all circuits and code files are being built around a Funduino Mega-2560.

Updates will be posted below, and this page will be replaced by a full README when the program is complete.

<h5> 2 August, 2016 </h5>
- Added initial code from Arduino IDE.
- Added circuit diagram

<h5> 6 August, 2016 </h5>
- Created a GUI in Matlab with start/stop button to use as counter.
- Adapted the voltage-measuring function from Arduino IDE to Matlab.

<h5> 7 August, 2016 </h5>
- Combined the voltage measuring function from 'voltm.m' into the app code in 'app_layout.m'.
- Voltmeter finished in debug mode: will try to run it through Matlab compiler later.

<h5> 11 August, 2016 </h5>
- Tweaked the circuit to make the wires a bit tidier: no change in sketch.
- Tried (and failed) to compile matlab GUI to executable.
- Uploaded screenshots of current view of app in three different circuit states.

<h5> 12 August, 2016 </h5>
- Began testing Arduino interfacing with Ruby. Instructions to run this test:
    First, install the "firmata" gem and arduino sketch using the instructions here: http://playground.arduino.cc/Interfacing/Ruby
    Next, download the file "Ruby Multimeter Testing.rb" and run it. The program should automatically detect your Arduino and connect to it.
- Current version is for command line only. Planning to add a GUI to it using Gosu.

<h5> 16 August, 2016 </h5>
- Finished a GUI prototype using Gosu. File has been added to the repository.
- Still some problems with timing and update cycles with the GUI. Once those are fixed, the command line voltmeter will be ready to be merged with the GUI.

<h5> 18 August, 2016 </h5>
- Combined the GUI with the initial voltmeter test: works fine except for a few things.
    1. The arduino arbitrarily fails to connect over firmata if it hasn't been plugged in long enough. Sometimes, many restarts are required. Once it connects, however, it stays put and does not disconnect.
    2. The Arduino's measurement cycles at 2 Hz are interfering with the GUI update cycles at 60 Hz. The plan to fix it is to keep both the updates at 60 Hz but create a timer so that the Arduino will only make a measurement every half-second.
- To run the Voltmeter GUI:
    First, install the "firmata" gem and run "standard firmata" through the Arduino IDE. Instructions here: http://playground.arduino.cc/Interfacing/Ruby . Then download the file "voltm.rb" and run it on command line. Press "Measure" to start measuring and *hold down* the stop button to stop measurement. This is because the GUI can only detect a mouse click every half-second due to the problem mentioned above. I'll be working to fix this shortly.

<h5> 22 August, 2016 </h5>
- Fixed "stop" button, and fixed firmata bugs: Arduino always connects now, and stop button always works (no need to hold it down anymore).
- Updates are back to 60 Hz: still trying to figure out a better way to solve that problem than using sleep(). Voltmeter is completely functional now. Set up the circuit, and run it using the instructions above. Adding an ammeter should now be a relatively trivial task.

<h5> 25 August, 2016 </h5>
- Added an ammeter, project now complete and functional
- Fixed circuit_setup PNG. New README on the way.
