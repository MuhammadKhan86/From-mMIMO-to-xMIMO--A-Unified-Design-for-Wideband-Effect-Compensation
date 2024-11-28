function Figure1_4

%%% Enable new simulations or load pre saved data
simType     = 'PreSavedResults';  %'PreSavedResults' or 'NewSimulation'

if strcmp (simType, 'NewSimulation')
  
  params          = ParamsInitialize;
  params.nSims    = 10; %% Increase number of simulations to get exact results. Deafult is 10000
  params.snrVecDb = 100;


  %%% Configure Params
  params.nTx            = [1 256];
  params.carrFreq       = 8e9;
  params.bnadWidth      = linspace(10e6, 8e9, 25).'; %% Controls the step size. deafult is 512
  params.symbDuration   = prod(params.nTx)*1/params.carrFreq*params.bnadWidth/2;

  %%% DDPP params
  params.nTtdTx         = prod(params.nTx) / sqrt(prod(params.nTx));
  params.nTtdRx         = prod(params.nRx) / sqrt(prod(params.nRx));

  %%% DPP params
  params.nTtdTxDPP      = 1*(prod(params.nTx)/params.nTtdTx+params.nTtdTx);
  params.nTtdRxDPP      = 1*(prod(params.nRx)/params.nTtdRx+params.nTtdRx);
  if prod(params.nRx) == 1
    params.nTtdRxDPP  = 1;
  elseif params.nTtdRxDPP > params.nRx
    params.nTtdRxDPP = prod(params.nRx);
  end
  if prod(params.nTx) == 1
    params.nTtdTxDPP  = 1;
  elseif params.nTtdTxDPP > params.nTx
    params.nTtdTxDPP = prod(params.nTx);
  end

  %%% Start Parallel Pool
  % parpool('HPCServer',100);
  for wIdx = 1:size(params.bnadWidth,1)
    params.sampFreq = params.bnadWidth(wIdx,:);

    params.nBands =params.nTtdTxDPP;
    for bandIdx = 1:params.nBands
      params.bandCarrFreq(bandIdx) = params.carrFreq - (params.nBands-1)* params.sampFreq/2*1/params.nBands + (bandIdx-1)*params.sampFreq/params.nBands;
    end

    % Main Processing loop --> If possible run on parallel clusters
    params = parallel.pool.Constant(params); params = params.Value;
    for simIdx = 1:params.nSims
      [ perCarrgainFI(simIdx,:),   ~,   ~,   ~, ...
        perCarrgainFD(simIdx,:),   ~,   ~,   ~, ...
        perCarrgainSB(simIdx,:),   ~,   ~,   ~, ...
        perCarrgainSBSA(simIdx,:), ~,   ~,   ~, ...
        perCarrgainDPP(simIdx,:),  ~,   ~,   ~, ...
        perCarrgainDDPP(simIdx,:), ~,   ~,   ~] ...
        = BeamSquintSim(params);
    end

    results.perCarrgainFI(wIdx)   = mean(mean(perCarrgainFI,1));
    results.perCarrgainFD(wIdx)   = mean(mean(perCarrgainFD,1));
    results.perCarrgainSB(wIdx)   = mean(mean(perCarrgainSB,1));
    results.perCarrgainSBSA(wIdx) = mean(mean(perCarrgainSBSA,1));
    results.perCarrgainDPP(wIdx)  = mean(mean(perCarrgainDPP,1));
    results.perCarrgainDDPP(wIdx) = mean(mean(perCarrgainDDPP,1));


    results.normalizedGainFI(wIdx)    = results.perCarrgainFI(wIdx)/results.perCarrgainFI(wIdx);
    results.normalizedGainFD(wIdx)    = results.perCarrgainFD(wIdx)/results.perCarrgainFI(wIdx);
    results.normalizedGainSB(wIdx)    = results.perCarrgainSB(wIdx)/results.perCarrgainFI(wIdx);
    results.normalizedGainSBSA(wIdx)  = results.perCarrgainSBSA(wIdx)/results.perCarrgainFI(wIdx);
    results.normalizedGainDPP(wIdx)   = results.perCarrgainDPP(wIdx)/results.perCarrgainFI(wIdx);
    results.normalizedGainDDPP(wIdx)  = results.perCarrgainDDPP(wIdx)/results.perCarrgainFI(wIdx);

  end

elseif strcmp (simType, 'PreSavedResults')
  load('PreSavedResults\Fig1-4_1TTD_Results.mat')
end

%%%% Figure 1
fontSize = 7;
figHeight= 4;
figWidth = 8.89;
IEEE_FIG(fontSize, figHeight, figWidth)
figure(1);
a = plot(params.symbDuration, abs(results.normalizedGainFI)); hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];

grid on;
xticks([min(params.symbDuration)  32 64 128 256]);
xticklabels({'2^0T_{s}', '2^5T_{s}', '2^6T_{s}', '2^7T_{s}', '2^8T_{s}'})
xlim([min(params.symbDuration) 256]);


markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,results.normalizedGainFI,markerpoints);
b = plot(markerpoints,yi);
b.LineStyle = "none";
b.Marker    = "*";
b.MarkerSize=6;
b.MarkerFaceColor = [0 0 0];
b.MarkerEdgeColor = [0 0 0];

c = plot(params.symbDuration, abs(results.normalizedGainFD));
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0 0.4470 0.7410];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainFD),markerpoints);
d = plot(markerpoints,yi);
d.LineStyle = "none";
d.Marker    = "square";
d.MarkerSize=4;
d.MarkerFaceColor = [0 0.4470 0.7410];
d.MarkerEdgeColor = [0 0.4470 0.7410];
yticks([0:0.1:1]);

xlabel('Maximum induced delay','FontSize',fontSize);
ylabel('Normalized array gain','FontSize',fontSize);


x1 = plot(nan, nan);
x1.LineWidth = 1;
x1.LineStyle = "--";
x1.Color     = [0 0 0];
x1.Marker    = "*";
x1.MarkerSize=6;
x1.MarkerFaceColor = [0 0 0];
x1.MarkerEdgeColor = [0 0 0];

x2 = plot(nan, nan);
x2.LineWidth = 1;
x2.LineStyle = "-";
x2.Color     = [0 0.4470 0.7410];
x2.Marker    = "square";
x2.MarkerSize=4;
x2.MarkerFaceColor = [0 0.4470 0.7410];
x2.MarkerEdgeColor = [0 0.4470 0.7410];


legend('','', '', '', 'Digital', 'Analog phase shift',  'fontsize', fontSize)
e = legend;
e.ItemTokenSize = 6*[5 , 5, 5 ,5 , 5, 5, 5];


%%%% Figure 4
IEEE_FIG(fontSize, figHeight, figWidth)
figure(4);
hold on;
box on;
a = plot(params.symbDuration, abs(results.normalizedGainFI)); hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];

grid on;
xticks([min(params.symbDuration)  32 64 128 256]);
xticklabels({'2^0T_{s}', '2^5T_{s}', '2^6T_{s}', '2^7T_{s}', '2^8T_{s}'})
xlim([min(params.symbDuration) 256]);


markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128];
yi = interp1(params.symbDuration,results.normalizedGainFI,markerpoints);
b = plot(markerpoints,yi);
b.LineStyle = "none";
b.Marker    = "*";
b.MarkerSize=6;
b.MarkerFaceColor = [0 0 0];
b.MarkerEdgeColor = [0 0 0];

c = plot(params.symbDuration, abs(results.normalizedGainFD));
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0 0.4470 0.7410];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainFD),markerpoints);
d = plot(markerpoints,yi);
d.LineStyle = "none";
d.Marker    = "square";
d.MarkerSize=4;
d.MarkerFaceColor = [0 0.4470 0.7410];
d.MarkerEdgeColor = [0 0.4470 0.7410];
yticks([0:0.1:1]);

f = plot(params.symbDuration, abs(results.normalizedGainSB));
f.LineWidth = 1;
f.LineStyle = "-";
f.Color     = [0.4940 0.1840 0.5560];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainSB),markerpoints);
g = plot(markerpoints,yi);
g.LineStyle = "none";
g.Marker    = "o";
g.MarkerSize=4;
g.MarkerFaceColor = [0.4940 0.1840 0.5560];
g.MarkerEdgeColor = [0.4940 0.1840 0.5560];
yticks([0:0.1:1]);


h = plot(params.symbDuration, abs(results.normalizedGainSBSA));
h.LineWidth = 1;
h.LineStyle = "-";
h.Color     = [0.9290 0.6940 0.1250];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainSBSA),markerpoints);
i = plot(markerpoints,yi);
i.LineStyle = "none";
i.Marker    = "diamond";
i.MarkerSize=4;
i.MarkerFaceColor = [0.9290 0.6940 0.1250];
i.MarkerEdgeColor = [0.9290 0.6940 0.1250];
yticks([0:0.1:1]);


j = plot(params.symbDuration, abs(results.normalizedGainDPP));
j.LineWidth = 1;
j.LineStyle = "-";
j.Color     = [0.8500 0.3250 0.0980];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainDPP),markerpoints);
k = plot(markerpoints,yi);
k.LineStyle = "none";
k.Marker    = "hexagram";
k.MarkerSize=4;
k.MarkerFaceColor = [0.8500 0.3250 0.0980];
k.MarkerEdgeColor = [0.8500 0.3250 0.0980];
yticks([0:0.1:1]);

if strcmp (simType, 'PreSavedResults')
  load('PreSavedResults\Fig1-4_2TTD_Results.mat')
end

f = plot(params.symbDuration, abs(results.normalizedGainSB));
f.LineWidth = 1;
f.LineStyle = "--";
f.Color     = [0.4940 0.1840 0.5560];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainSB),markerpoints);
g = plot(markerpoints,yi);
g.LineStyle = "none";
g.Marker    = "o";
g.MarkerSize=4;
g.MarkerFaceColor = [0.4940 0.1840 0.5560];
g.MarkerEdgeColor = [0.4940 0.1840 0.5560];
yticks([0:0.1:1]);


h = plot(params.symbDuration, abs(results.normalizedGainSBSA));
h.LineWidth = 1;
h.LineStyle = "--";
h.Color     = [0.9290 0.6940 0.1250];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainSBSA),markerpoints);
i = plot(markerpoints,yi);
i.LineStyle = "none";
i.Marker    = "diamond";
i.MarkerSize=4;
i.MarkerFaceColor = [0.9290 0.6940 0.1250];
i.MarkerEdgeColor = [0.9290 0.6940 0.1250];
yticks([0:0.1:1]);


j = plot(params.symbDuration, abs(results.normalizedGainDPP));
j.LineWidth = 1;
j.LineStyle = "--";
j.Color     = [0.8500 0.3250 0.0980];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainDPP),markerpoints);
k = plot(markerpoints,yi);
k.LineStyle = "none";
k.Marker    = "hexagram";
k.MarkerSize=4;
k.MarkerFaceColor = [0.8500 0.3250 0.0980];
k.MarkerEdgeColor = [0.8500 0.3250 0.0980];
yticks([0:0.1:1]);
ylim([0 1]);

if strcmp (simType, 'PreSavedResults')
  load('PreSavedResults\Fig1-4_2TTD_Results.mat')
end
l = plot(params.symbDuration, abs(results.normalizedGainDDPP.^2));
l.LineWidth = 1;
l.LineStyle = "-";
l.Color     = [0 0.5 0];
markerpoints = [min(params.symbDuration) 1 2 4 8 16 32 64 128 256];
yi = interp1(params.symbDuration,abs(results.normalizedGainDDPP),markerpoints);
m = plot(markerpoints,yi);
m.LineStyle = "none";
m.Marker    = "pentagram";
m.MarkerSize=4;
m.MarkerFaceColor = [0 0.5 0];
m.MarkerEdgeColor = [0 0.5 0];
yticks([0:0.1:1]);


xlabel('Maximum induced delay','FontSize',fontSize);
ylabel('Normalized array gain','FontSize',fontSize);

%%% Fig 4 Legend
fontSize = 7;
figHeight= 4;
figWidth = 8.89;
IEEE_FIG(fontSize, figHeight, figWidth)
figure(10); grid on; hold on;
x1 = plot(NaN, NaN);
x1.LineWidth = 1;
x1.LineStyle = "--";
x1.Color     = [0 0 0];
x1.Marker    = "*";
x1.MarkerSize=6;
x1.MarkerFaceColor = [0 0 0];
x1.MarkerEdgeColor = [0 0 0];

x2 = plot(NaN, NaN);
x2.LineWidth = 1;
x2.LineStyle = "-";
x2.Color     = [0 0.4470 0.7410];
x2.Marker    = "square";
x2.MarkerSize=4;
x2.MarkerFaceColor = [0 0.4470 0.7410];
x2.MarkerEdgeColor = [0 0.4470 0.7410];

x3 = plot(NaN, NaN);
x3.LineWidth = 1;
x3.LineStyle = "-";
x3.Color     = [0.4940 0.1840 0.5560];
x3.Marker    = "o";
x3.MarkerSize=4;
x3.MarkerFaceColor = [0.4940 0.1840 0.5560];
x3.MarkerEdgeColor = [0.4940 0.1840 0.5560];

x4 = plot(NaN, NaN);
x4.LineWidth = 1;
x4.LineStyle = "-";
x4.Color     = [0.9290 0.6940 0.1250];
x4.Marker    = "diamond";
x4.MarkerSize=4;
x4.MarkerFaceColor = [0.9290 0.6940 0.1250];
x4.MarkerEdgeColor = [0.9290 0.6940 0.1250];

x5 = plot(NaN, NaN);
x5.LineWidth = 1;
x5.LineStyle = "-";
x5.Color     = [0.8500 0.3250 0.0980];
x5.Marker    = "hexagram";
x5.MarkerSize=4;
x5.MarkerFaceColor = [0.8500 0.3250 0.0980];
x5.MarkerEdgeColor = [0.8500 0.3250 0.0980];

x6 = plot(NaN, NaN);
x6.LineWidth = 1;
x6.LineStyle = "--";
x6.Color     = [0.4940 0.1840 0.5560];
x6.Marker    = "o";
x6.MarkerSize=4;
x6.MarkerFaceColor = [0.4940 0.1840 0.5560];
x6.MarkerEdgeColor = [0.4940 0.1840 0.5560];

x7 = plot(NaN, NaN);
x7.LineWidth = 1;
x7.LineStyle = "--";
x7.Color     = [0.9290 0.6940 0.1250];
x7.Marker    = "diamond";
x7.MarkerSize=4;
x7.MarkerFaceColor = [0.9290 0.6940 0.1250];
x7.MarkerEdgeColor = [0.9290 0.6940 0.1250];

x8 = plot(NaN, NaN);
x8.LineWidth = 1;
x8.LineStyle = "--";
x8.Color     = [0.8500 0.3250 0.0980];
x8.Marker    = "hexagram";
x8.MarkerSize=4;
x8.MarkerFaceColor = [0.8500 0.3250 0.0980];
x8.MarkerEdgeColor = [0.8500 0.3250 0.0980];

x9 = plot(NaN, NaN);
x9.LineWidth = 1;
x9.LineStyle = "-";
x9.Color     = [0 0.5 0];
x9.Marker    = "pentagram";
x9.MarkerSize=4;
x9.MarkerFaceColor = [0 0.5 0];
x9.MarkerEdgeColor = [0 0.5 0];

set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
xtickangle(0)


legend('Digital', 'Analog phase shift',...
  '[9] N_{RF} =N_{TTD}^{DDPP}', ...
  '[12] N_{RF}=N_{TTD}^{DDPP}', ...
  '[15] N_{TTD}=N_{TTD}^{DDPP}',...
  '[9] N_{RF}=2N_{TTD}^{DDPP}',...
  '[12] N_{RF}=2N_{TTD}^{DDPP}',...
  '[15] N_{TTD}=2N_{TTD}^{DDPP}',...
  'DDPP',  'fontsize',fontSize,'interpreter','tex', 'FontName', 'Times')
n = legend;
set(n,'NumColumns',3,'FontSize',fontSize);
n.ItemTokenSize = 3*[5 , 5, 5 ,5 , 5, 5, 5];
set(gca, 'visible', 'off');








