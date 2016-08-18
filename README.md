# GUI Multimeter
This is a small project to construct a combined voltmeter and ammeter that will output results to a GUI. The GUI will be first built in Matlab and possibly C++. Diagrams may show any board, but all circuits and code files are being built around a Funduino Mega-2560.

Updates will be posted below, and this page will be replaced by a full README when the program is complete.

<h5> 2 August, 2016 </h2>
- Added initial code from Arduino IDE.
- Added circuit diagram

<h5> 6 August, 2016 </h2>
- Created a GUI in Matlab with start/stop button to use as counter.
- Adapted the voltage-measuring function from Arduino IDE to Matlab.

<h5> 7 August, 2016 </h5>
- Combined the voltage measuring function from 'voltm.m' into the app code in 'app_layout.m'.
- Voltmeter finished in debug mode: will try to run it through Matlab compiler later.

<h5> 11 August, 2016 </h6>
- Tweaked the circuit to make the wires a bit tidier: no change in sketch.
- Tried (and failed) to compile matlab GUI to executable.
- Uploaded screenshots of current view of app in three different circuit states.

<h5> 12 August, 2016 </h6>
- Began testing Arduino interfacing with Ruby. Instructions to run this test:
    First, install the "firmata" gem and arduino sketch using the instructions here: http://playground.arduino.cc/Interfacing/Ruby
    Next, download the file "Ruby Multimeter Testing.rb" and run it. The program should automatically detect your Arduino and connect to it.
- Current version is for command line only. Planning to add a GUI to it using Gosu.

<h5> 16 August, 2016 </h6>
- Finished a GUI prototype using Gosu. File has been added to the repository.
- Still some problems with timing and update cycles with the GUI. Once those are fixed, the command line voltmeter will be ready to be merged with the GUI.
