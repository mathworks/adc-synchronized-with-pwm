%Copyright 2021 - 2025 The MathWorks, Inc.
%Auther Yuki Kamatani@ MathWorks Japan

%Parameter Call
Param_BidCnv;

%ボード線図描画オプション設定
opts = bodeoptions;
opts.Title.FontSize = 11;
opts.Grid ='on';
opts.FreqUnits = 'Hz';
%ボード線図描画
bodeplot(Plant,opts);
hold on;
bodeplot(Controller,opts);
legend('Plant','Controller');

%一巡伝達関数特性
figure;
bodeplot(Plant*Controller*exp(-s*Tcnt),opts);
legend('Closed-loop');