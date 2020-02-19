instrreset;
param.afg=visa('ni','USB::0x0699::0x0341::C020167::INSTR');
fopen(param.afg);
fprintf(param.afg,'*RST');
fprintf(param.afg,'OUTP1:STAT OFF'); fprintf(param.afg,'OUTP2:STAT OFF');
fprintf(param.afg,'OUTP1:IMP INF'); fprintf(param.afg,'OUTP2:IMP INF');
fprintf(param.afg,'SOURCE1:FUNCTION SQUARE'); fprintf(param.afg,'SOURCE2:FUNCTION SQUARE');
fprintf(param.afg,'SOURce1:VOLTage:CONCurrent:STATe ON');
fprintf(param.afg,'SOURce1:FREQuency:CONCurrent ON');
fprintf(param.afg,'SOURce1:PHASe:INITiate');
fprintf(param.afg,'SOURce2:PHASe:ADJust 180 deg');
disp('Signal Generator initiated succesfully')
fprintf(param.afg,'SOURCE1:FREQ:FIXED 180HZ');
fprintf(param.afg,'SOURCE1:VOLTAGE 16.3');

n=1;
disp('Signal Generator cycling on and off every 5s, press Ctrl+C to stop')
p=1; % how long it pauses
while n
    fprintf(param.afg,'OUTP1:STAT ON'); fprintf(param.afg,'OUTP2:STAT ON');
    pause(p)
    fprintf(param.afg,'OUTP1:STAT OFF'); fprintf(param.afg,'OUTP2:STAT OFF');
    pause(p)
end
