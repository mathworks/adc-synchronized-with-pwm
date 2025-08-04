%Copyright 2021 - 2025 The MathWorks, Inc.
%Auther Yuki Kamatani@ MathWorks Japan

%======================================
%PWM Unit Parameters
fsw = 100e3; %Hz
PWM_Resolution = 0.001;
TimerCountMax = 1/ PWM_Resolution;
CarrierSampleTime = 1 / fsw * PWM_Resolution;
DeadTime = 1/fsw*PWM_Resolution;

%Set Duty Limit
MinDuty = 0.01;
MaxDuty = 0.95;

%======================================
%Sensor ADC Quantization bit
ADC_QuantBit = 12;
QuantResolution = 1/(2^ADC_QuantBit);
MaxRange = 50;%[A]
MinRange = -50;%[A]
QuantUnit = (MaxRange - MinRange) * QuantResolution;%[V]
