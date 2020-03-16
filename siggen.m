classdef siggen
    %SIGGEN Connect to lab hardware
    %   Detailed explanation goes here
    
    properties
        deviceid
    end
    
    methods
        function obj = siggen(deviceid)
            %SIGGEN Construct a siggen (Signal Generator) instance
            %   Provide the device id, eg:
            %   'USB::0x0699::0x0341::C020167::INSTR'
            %   If deviceid is empty, use default option below
            if nargin == 0
                % Default device ID
                obj.deviceid = 'USB::0x0699::0x0341::C020167::INSTR';
            else
                obj.deviceid = deviceid;
            end
            param.afg=visa('ni',obj.deviceid);
            fopen(param.afg);
            fprintf(param.afg,'*RST');
            fprintf(param.afg,'OUTP1:STAT OFF'); fprintf(param.afg,'OUTP2:STAT OFF');
        end
        
        function [] = setup(~,flags)
            %SETUP Set starting properties
            %   i: infinite impedence
            %   q: square wave
            %   v: voltage concurrent
            %   f: frequency concurrent
            %   p: 180° phase change between sources
            if contains (flags, 'i')
                fprintf(param.afg,'OUTP1:IMP INF'); fprintf(param.afg,'OUTP2:IMP INF');
            end
            if contains (flags, 'q')
                fprintf(param.afg,'SOURCE1:FUNCTION SQUARE'); fprintf(param.afg,'SOURCE2:FUNCTION SQUARE');
            end
            if contains (flags, 'v')
                fprintf(param.afg,'SOURce1:VOLTage:CONCurrent:STATe ON');
            end
            if contains (flags, 'f')
                fprintf(param.afg,'SOURce1:FREQuency:CONCurrent ON');
            end
            if contains (flags, 'p')
                fprintf(param.afg,'SOURce1:PHASe:INITiate');
                fprintf(param.afg,'SOURce2:PHASe:ADJust 180 deg');
            end
            disp('Signal Generator initiated succesfully')
        end
        
        function [] = setv1(~,v1set)
            %SETV1 sets source 1 voltage to v1set
            fprintf(param.afg,['SOURCE1:VOLTAGE ',num2str(v1set)]);
        end
        
        function [] = setf1(~,f1set)
            %SETF1 sets source 1 frequency to f1set
            fprintf(param.afg,['SOURCE1:FREQ:FIXED ',num2str(f1set)]);
        end
        
        function[] = on(~)
            %ON switches both sources off
            fprintf(param.afg,'OUTP1:STAT ON'); fprintf(param.afg,'OUTP2:STAT ON');
        end
        
        function[] = off(~)
            %OFF switches both sources off
            fprintf(param.afg,'OUTP1:STAT OFF'); fprintf(param.afg,'OUTP2:STAT OFF');
        end
    end
end

