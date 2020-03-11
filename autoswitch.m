function[] = autoswitch(delay, time)
% AUTOSWITCH connects to a Tektronix AFG3022 Signal Generator to apply the
%   square wave for peak performance of the cell DJH-151118-01 190329-1 at
%   55°C. It switches this field on and off every 'delay' seconds for
%   'time' seconds.
%
%   AUTOSWITCH(1)
%
%   Delay is set to 1 second

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

tic
disp(['Signal Generator cycling on and off every ',num2str(delay),'s for ',num2str(time),'s'])
while toc < time
    fprintf(param.afg,'OUTP1:STAT ON'); fprintf(param.afg,'OUTP2:STAT ON');
    pause(delay)
    fprintf(param.afg,'OUTP1:STAT OFF'); fprintf(param.afg,'OUTP2:STAT OFF');
    pause(delay)
end
fprintf(param.afg,'OUTP1:STAT OFF'); fprintf(param.afg,'OUTP2:STAT OFF');

end