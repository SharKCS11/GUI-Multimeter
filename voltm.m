clear;
ard=arduino('COM3','Mega2560');
for ct=1:100000
    redval = readVoltage(ard,'A1');
    fprintf('Voltage read is: %.2f \n',redval*2);
    pause(1);
end
