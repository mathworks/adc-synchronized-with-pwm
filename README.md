# ADC synchronized with PWM
Copyright 2021 - 2022 The MathWorks, Inc.

## JP Introduction
PWMによってインダクタに印加する平均電圧を変更することで
インダクタに流れる電流をコントロールを実施するDemoモデルです。

 <img src=https://camo.qiitausercontent.com/4b168ebfce261ad9bf92cf5b12ce86a4f3d344e6/68747470733a2f2f71696974612d696d6167652d73746f72652e73332e61702d6e6f727468656173742d312e616d617a6f6e6177732e636f6d2f302f3333313633372f66326338663538322d356266642d376265312d633761362d6431316364633663376663392e676966
 width="600" height="450"
 />


このモデルは2つの要素について説明できます

### 1.PWMタイマと同期したADC実行

平均電流を取得するにはパルス幅を生成する際に用いられるタイマカウンタに同期したアナログ・デジタル変換を実施することが一般的です。
このDemoではタイマカウンタ、すなわちPWMと同期したAD変換実行の例を示します。

このような実装方法は、モータ制御を行うエンジニアや、バッテリーの電流制御、系統連系インバーターの制御設計ではよく知られた手法です。
この方法が有効であると述べた本[^1]は多く有るものの実際にその動作を示すデモモデルは少ないので、
顧客にその方法を提案する際に有効なデモモデルだと考えています。

### 2.DeadTimeの付与
このモデルはPWM生成部にてDeadTimeを付与することができます。
DeadTimeはデバイスの短絡を回避するために挿入されれますが、DeadTimeを挿入することで誤差が発生するため[^2]、制御応答の収束性に課題が発生する場合があります。
そのような検討をを行う場合においても本モデルは有効です。

[^1]: Ricardo P. Aguilera et al. (2018). Digital Implementation of PI and Resonant Controller. In FREDE BLAABJERG(Eds.) CONTROL OF POWER ELECTRONIC CONVERTERS AND SYSTEMS volume1. Academic Press, pp.56-61
[^2]: Dead-time  Voltage  Error Correction  with Parallel Disturbance Observers  for High  Performance  V/f  Control 
http://itohserver01.nagaokaut.ac.jp/itohlab/paper/2007/IAS2007/hoshino.pdf


## EN Introduction
This demo model shows how to control the current flowing in an inductor by changing the average voltage applied to the inductor by PWM.

The current flowing in the inductor changes nonlinearly with PWM, and to control the current, it is necessary to obtain the average current in the PWM cycle.
This model can be described in terms of two elements.

### 1.ADC execution synchronized with PWM timer
In order to obtain the average current, it is common to perform analog-to-digital conversion synchronized with a timer counter used to generate the pulse width.
This Demo shows an example of performing AD conversion synchronized with a timer counter, i.e. PWM.

This method of implementation is well known to engineers who control motors, battery current control, and grid-connected inverter control design.
Although there are many books that describe this method[^1], there are few demonstration models that actually show how it works, so I believe that this is an effective demonstration model for proposing the method to customers.
### 2.Assign Dead Time
The model can also be given a DeadTime in the PWM generator.
DeadTimes are inserted to avoid short-circuiting the device, but inserting DeadTimes introduces errors that can cause problems with convergence of the control response[^2].
This model is also effective in such cases.


# Required Toolboxes
MATLAB&reg;/
Simulink&reg;/
Simscape&trade;/
Simscape Electrical&trade;/
DSP System Toolboxes&trade;

# Recomend Toolbox
Control System Toolbox&trade; 

モデルの伝達関数を表示するのに必要です。
SycnADC_WithFBParam.mの13行目以降をコメントアウトすればこのToolboxがなくてもモデルは動作します。

It is needed to display the transfer function of the model.
If you comment out line 13 onwards of SycnADC_WithFBParam.m The model will work without this Toolbox.

# Reference


