%Copyright 2021 - 2021 The MathWorks, Inc.
%Auther Yuki Kamatani 

%PWM Unit Parameters
fsw = 200e3; %Hz
PWM_Resolution = 0.001;
TimerCountMax = 1/ PWM_Resolution;
CarrierSampleTime = 1 / fsw * PWM_Resolution;
DeadTime = 1/fsw/1000;

MinDuty = PWM_Resolution * 5;
MaxDuty = 1 - MinDuty;

%Circuit components Parameters
L = 500e-6;%[H]
RdsON_FET = 10e-3;%[Ω]
VinDC = 100;%[V]
VoutDC = 50;%[V]


%Sensor ADC Quantization bit
ADC_QuantBit = 12;
QuantResolution = 1/(2^ADC_QuantBit);
MaxRange = 50;%[A]
MinRange = -50;%[A]
QuantUnit = (MaxRange - MinRange) * QuantResolution;%[V]


%Control Design
s = tf('s');

%制御対象回路の伝達関数をモデリング
Plant = 1/(L*s + RdsON_FET);

%制御の帯域幅を設定
TargetCntF = 2*pi*500;
Tcnt = 1 / TargetCntF;

%内部モデル原理に基づきコントローラーを設計
Controller = 1 / Plant * 1 / (Tcnt * s);

%等価な伝達関数を持つPIパラメータを算出
Ti = 1/TargetCntF/RdsON_FET;
Kp = L/RdsON_FET / Ti;
PICnt = (Kp*Ti*s+1) / Ti/s;

