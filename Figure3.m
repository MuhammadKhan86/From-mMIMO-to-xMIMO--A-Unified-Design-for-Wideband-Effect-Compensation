function Figure3

params.nTx        = 1024;
params.QT_DPP     = 2*sqrt(params.nTx);
params.PT_DPP     = params.nTx/params.QT_DPP;
params.QT_DDPP    = sqrt(params.nTx);
params.PT_DDPP    = sqrt(params.nTx);
params.nCarr      = 4;
params.sampFreq   = 800e6;
params.carrFreq   = 8e9;

beamAng = sin(deg2rad(45));

%%%% DPP
chanSteering = -1 : 0.0001 : 1;
for carrIdx = 1:params.nCarr
  fCarr     = params.carrFreq + ((params.sampFreq/params.nCarr)*(carrIdx-1-((params.nCarr-1)/2)));
  xiCarr    = fCarr/params.carrFreq;

  for chanIdx = 1:length(chanSteering)
    first_Term_DPP(chanIdx, carrIdx)  = 1/params.QT_DPP * sin(params.QT_DPP* params.PT_DPP * pi/2 *xiCarr *(beamAng - chanSteering(chanIdx))) / sin(params.PT_DPP * pi/2 *xiCarr *(beamAng - chanSteering(chanIdx)));
    second_Term_DPP(chanIdx, carrIdx) = 1/params.PT_DPP  * sin(params.PT_DPP  * pi/2 *(beamAng - xiCarr*chanSteering(chanIdx))) / sin(pi/2 *(beamAng - xiCarr*chanSteering(chanIdx)));
    arryGain_DPP(chanIdx, carrIdx)    = abs(kron(first_Term_DPP(chanIdx, carrIdx), second_Term_DPP(chanIdx, carrIdx)));
  end
end

%%%% DDPP
for carrIdx=1:params.nCarr
  fCarr   = params.carrFreq + ((params.sampFreq/params.nCarr)*(carrIdx-1-((params.nCarr-1)/2)));
  xiCarr  = fCarr/params.carrFreq;
  for chanIdx = 1:length(chanSteering)
    first_Term_DDPP(chanIdx, carrIdx)   = 1/params.QT_DDPP * sin(params.QT_DDPP* params.PT_DDPP * pi/2 *xiCarr *(beamAng - chanSteering(chanIdx))) / sin(params.PT_DDPP* pi/2 *xiCarr *(beamAng - chanSteering(chanIdx)));
    second_Term_DDPP(chanIdx, carrIdx)  = 1/params.PT_DDPP * sin(params.PT_DDPP * pi/2 *xiCarr *(beamAng - chanSteering(chanIdx))) / sin(pi/2 *xiCarr *(beamAng - chanSteering(chanIdx)));
    arryGain_DDPP(chanIdx, carrIdx)     = abs(kron(first_Term_DDPP(chanIdx, carrIdx), second_Term_DDPP(chanIdx, carrIdx))).^2;
  end
end

%%% Plotting
fontSize = 7;
figHeight= 4;
figWidth = 8.89;
IEEE_FIG(fontSize, figHeight, figWidth)
figure(3);
a = plot(chanSteering,abs(first_Term_DPP(:,1)).^2); hold on;
a.LineWidth = 0.5;
a.LineStyle = "-";
a.Color     = [0 0.4470 0.7410];

grid on;
xticks([0.5 0.6 0.7 0.8 0.9 1.0]);
xticklabels({'0.5', '0.6', '0.7', '0.8', '0.9', '1.0'})
xlim([0.5 1]);

b = plot(chanSteering,abs(second_Term_DPP(:,1)).^2); hold on;
b.LineWidth = 1;
b.LineStyle = "--";
b.Color     = [0.8500 0.3250 0.0980];

markerpoints = [0.5772 0.7071 0.837 0.9668];
yDPP = interp1(chanSteering,abs(second_Term_DPP(:,1)).^2,markerpoints);
c = plot(markerpoints,yDPP);
c.LineStyle = "none";
c.Marker    = "hexagram";
c.MarkerSize=4;
c.MarkerFaceColor = [0.8500 0.3250 0.0980];
c.MarkerEdgeColor = [0.8500 0.3250 0.0980];

d = plot(chanSteering,abs(second_Term_DDPP(:,1)).^2); hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0 0.5 0];

markerpoints = [0.5772 0.7071 0.837 0.9668];
yDDPP = interp1(chanSteering,abs(second_Term_DDPP(:,1)).^2,markerpoints);
e = plot(markerpoints,yDDPP);
e.LineStyle = "none";
e.Marker    = "pentagram";
e.MarkerSize=4;
e.MarkerFaceColor = [0 0.5 0];
e.MarkerEdgeColor = [0 0.5 0];

yticks([0:0.1:1]);

xlabel('sin(\theta)','FontSize',fontSize,'interpreter','tex');
ylabel('Normalized array gain','FontSize',fontSize);


x1 = plot(NaN, NaN);
x1.LineWidth = 1;
x1.LineStyle = "-";
x1.Color     = [0 0.4470 0.7410];
x1.Marker    = "none";
x1.MarkerSize=6;
x1.MarkerFaceColor = [0 0.4470 0.7410];
x1.MarkerEdgeColor = [0 0.4470 0.7410];

x2 = plot(NaN, NaN);
x2.LineWidth = 1;
x2.LineStyle = "--";
x2.Color     = [0.8500 0.3250 0.0980];
x2.Marker    = "hexagram";
x2.MarkerSize=4;
x2.MarkerFaceColor = [0.8500 0.3250 0.0980];
x2.MarkerEdgeColor = [0.8500 0.3250 0.0980];

x3 = plot(NaN, NaN);
x3.LineWidth = 1;
x3.LineStyle = "-";
x3.Color     = [0 0.5 0];
x3.Marker    = "pentagram";
x3.MarkerSize=4;
x3.MarkerFaceColor = [0 0.5 0];
x3.MarkerEdgeColor = [0 0.5 0];


legend('','','','','', ...
  'G_{Q_{{T}}}', ...
  'G_{P_{{T}}}- (13)' ...
  ,'G_{P_{{T}}}- (12)',  ...
  'fontsize', fontSize,'interpreter','tex')
e = legend;
e.ItemTokenSize = 3*[5 , 5, 5 ,5 , 5, 5, 5];
