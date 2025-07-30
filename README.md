# コンバータ・モータの電流制御におけるモデリングスタイル
Copyright 2021 - 2025 The MathWorks, Inc.

# Version
Main Branch: R2021a<br>

## Background
2000年代初頭から、発電所から需要家までの単方向で電力を供給することが主流であった電力系システムですが、クリーンで持続可能なエネルギーシステム達成のために、”双方向に電力を供給するシステム”へのニーズが高まっています。

このようなニーズに対応するために、
システムで利用されるパワーエレクトロニクス機器において
双方向に電流を制御することに対する需要が高まっています。

具体的には特に、
- 双方向DCDCコンバータ
- モータ制御用途のインバータ出力電流制御
- UPS、系統連系インバータの出力電流制御

といった電流制御を行うパワーエレクトロニクス機器の設計要件を、
上流の”双方向に電力を供給するシステム”の要求と突き合わせて、妥当な設計を効率的に行うことが求められています。

そのような課題に対する手段として、
シミュレーションを用いてシステムやパワーエレクトロニクス機器の動作を確認し、設計の早期段階で要件を具体化するための開発手法である
モデルベースデザインが注目されています。

## Demo Introduction
本例題では、電流制御を行うパワーエレクトロニクス機器を
MathWorks製品を使ってモデリングした場合、

- シミュレーションソルバ設定
- PWM生成部のモデリング
- ADC部のモデリング

についてどのようにモデリングすべきかについて例を示しています。

本例題で紹介しているモデリングスタイルは、あらゆる回路において適応できる万能な例題ではありませんが、
本例題では最も基本的なハーフブリッジ回路を用いたBuck Converterを例題にしておりますので、多くのパワーエレクトロニクス回路に応用できる可能性があります。

可能な限りシミュレーション精度とシミュレーション速度を両立することを目指したモデリングスタイルでありますのでこのデモを参考に皆様が研究・開発で扱われているパワーエレクトロニクス機器をモデリングいただければ幸いです。

 <img src=https://user-images.githubusercontent.com/62166747/153810086-c810ee2a-48d8-44cb-84f9-69b1c4fd83dc.PNG width="60%" height="60%"
 />
 <img src=https://user-images.githubusercontent.com/62166747/153804864-ed1d8fee-7aaa-4ad6-a096-7b74018feee3.gif
 width="600" height="450"
 />

### How to Run
1.このリポイトリのProjectファイルを開いて、Modelsフォルダに保存されているモデルのいずれかを開きます。
2.シミュレーションを実行してデータインスペクターで波形を確認します。

## Model File Introduction: 
### BidirectionalCurrentControlConverter.slx
双方向のコンバータをシンプルなハーフブリッジで表現した回路モデルを制御対象とし、
シンプルなPIコントローラをベースとした制御モデルによって電流制御を実現しているモデルです。

モデリングスタイルやソルバの設定については、モデルファイル内の各サブシステム階層にわかれて
解説のコメントが日本語で記述されています。

<img width="1486" height="1070" alt="Image" src="https://github.com/user-attachments/assets/a2a50e90-db3b-45f0-8bd0-e0be4ef74d30" />

<img width="1635" height="910" alt="Image" src="https://github.com/user-attachments/assets/e81c8679-41f3-4c36-ad21-45cab0507b9a" />

### BuckConverter.slx
基本的なモデリングスタイルはBidirectionalCurrentControlConverter.slxと同様ですが、プラントモデルとなる回路モデル、制御モデルはMathWorksの公式でもモデルである、こちらの例題のものを一部引用しています。
そのため下記サンプルと動作を比較して、シミュレーション動作の精度とシミュレーション実行速度の違いを確認することができます。
https://jp.mathworks.com/help/sps/ug/buck-converter_example-ee_switching_power_supply.html
<img width="949" height="609" alt="Image" src="https://github.com/user-attachments/assets/9ef782a3-efa3-4679-98ad-0a0bedbe803a" />
大本のサンプルではパワーMOSFETライブラリに
[Nch-MOSFET](https://jp.mathworks.com/help/sps/ref/nchannelmosfet.html)
ライブラリが利用されていましたが、
[MOSFET(Ideal,Switching)](https://jp.mathworks.com/help/sps/ref/mosfetidealswitching.html)に変更されています。

[Nch-MOSFET](https://jp.mathworks.com/help/sps/ref/nchannelmosfet.html)はゲート電圧の立ち上がりダイナミクスまで詳細に表現したスイッチングデバイスであるため、厳密で詳細度の高いスイッチング表現が可能ですがその分シミュレーションステップの刻み幅が短くなり、シミュレーション速度低下を招くことがあります。

シミュレーションの目的が回路構成と制御構成および制御パラメータの整合性確認であれば、パワー半導体は[MOSFET(Ideal,Switching)](https://jp.mathworks.com/help/sps/ref/mosfetidealswitching.html)に代表される
**'理想スイッチングライブラリ'ブロックを利用することをおすすめします。**

これにより、スイッチングの挙動は簡略化されますが、
制御パラメータを調整するには十分な精度を得ることができるためシミュレーション速度と精度を両立性を高めることができます。


## 特筆するモデリング要素
本例で示したモデリングスタイルのうち、電流制御を行うパワーエレクトロニクス設計においてよく確認が必要だと挙げられる3つの要素がモデルに含まれています。

### 1.PWMタイマと同期したADC実行

平均電流を取得するにはパルス幅を生成する際に用いられるタイマカウンタに同期したアナログ・デジタル変換を実施することが一般的です。
このDemoではタイマカウンタ、すなわちPWMと同期したAD変換実行の例を示します。

このような実装方法は、モータ制御を行うエンジニアや、バッテリーの電流制御、系統連系インバーターの制御設計ではよく知られた手法です[^1]。

### 2.DeadTimeの付与
このモデルはPWM生成部にてDeadTimeを付与することができます。
DeadTimeはデバイスの短絡を回避するために挿入されれますが、DeadTimeを挿入することで誤差が発生するため[^2]、制御応答の収束性に課題が発生する場合があります。
そのような検討をを行う場合においても本モデルは有効です。


### 3.損失分析
理想スイッチングライブラリではゲート電圧やドレインソース電圧立ち上がり、および立ち下がりのダイナミクス表現は簡略化されますが、[スイッチング損失量をLookUpテーブル形式でパラメタライズ](https://jp.mathworks.com/help/sps/ref/mosfetidealswitching.html#mw_21c553da-2d08-4434-9eb4-4df1e356ead0)することができるため、LookUp値に基づく回路の[損失分析](https://jp.mathworks.com/help/sps/ref/ee_getefficiency.html)は可能です。

[^1]: Ricardo P. Aguilera et al. (2018). Digital Implementation of PI and Resonant Controller. In FREDE BLAABJERG(Eds.) CONTROL OF POWER ELECTRONIC CONVERTERS AND SYSTEMS volume1. Academic Press, pp.56-61
[^2]: Dead-time  Voltage  Error Correction  with Parallel Disturbance Observers  for High  Performance  V/f  Control 
http://itohserver01.nagaokaut.ac.jp/itohlab/paper/2007/IAS2007/hoshino.pdf
# Required Toolboxes
MATLAB&reg;/
Simulink&reg;/
Simscape&trade;/
Simscape Electrical&trade;/

# Recomend Toolbox
Control System Toolbox&trade; 

モデルの伝達関数を表示するのに必要です。
SycnADC_WithFBParam.mの13行目以降をコメントアウトすればこのToolboxがなくてもモデルは動作します。

It is needed to display the transfer function of the model.
If you comment out line 13 onwards of SycnADC_WithFBParam.m The model will work without this Toolbox.

# Reference


