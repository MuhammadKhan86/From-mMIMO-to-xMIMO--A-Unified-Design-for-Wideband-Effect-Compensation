function Figure5

%%% This function loads presaved results to generate Fig 5.
%%% For new simulations, plese use the function "MIMO_BS_Sim.m"
%%%%% 5A
%% BER
%%% xMIMO-1
load('PreSavedResults\Fig5_xMIMO_1_Results.mat')
fontSize = 7;
figHeight= 4;
figWidth = 19;
IEEE_FIG(fontSize, figHeight, figWidth)
figure(5);
t = tiledlayout(1,4,'TileSpacing','Compact','Padding','Compact');
nexttile;

a = semilogy(params.snrVecDb,  results.berFI );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41 51 61 71 81];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = semilogy(params.snrVecDb,  results.berFD );grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41 51 61 71 81];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = semilogy(params.snrVecDb,  results.berSB );grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41 51 61 71 81];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = semilogy(params.snrVecDb,  results.berSBSA );grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41 51 61 71 81];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = semilogy(params.snrVecDb,  results.berDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = semilogy(params.snrVecDb,  results.berDDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];

yticks([1e-5 1e-4 1e-3 1e-2 1e-1 1])
ylim([1e-5 1]);
xticks([-20:5:25]);
xlim([-20 25]);
xtickangle(0)

params.figFontSize = 7;
xlabel('SNR [dB]','FontSize',fontSize);
ylabel('BER','FontSize',fontSize);


%%% xMIMO-2
load('PreSavedResults\Fig5_xMIMO_2_Results.mat')
nexttile

a = semilogy(params.snrVecDb,  results.berFI );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41 51 61 71 81];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = semilogy(params.snrVecDb,  results.berFD );grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41 51 61 71 81];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = semilogy(params.snrVecDb,  results.berSB );grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41 51 61 71 81];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = semilogy(params.snrVecDb,  results.berSBSA );grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41 51 61 71 81];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = semilogy(params.snrVecDb,  results.berDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = semilogy(params.snrVecDb,  results.berDDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];

yticks([1e-5 1e-4 1e-3 1e-2 1e-1 1])
set(gca,'YTickLabel',[]);
xlim([-20 15]);
xticks([-20:5:15]);
ylim([1e-5 1]);
xtickangle(0)

xlabel('SNR [dB]','FontSize',fontSize);


%%% mMIMO-1
load('PreSavedResults\Fig5_mMIMO_1_Results.mat')
nexttile

a = semilogy(params.snrVecDb,  results.berFI );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41 51 61 71 81];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = semilogy(params.snrVecDb,  results.berFD );grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41 51 61 71 81];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = semilogy(params.snrVecDb,  results.berSB );grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41 51 61 71 81];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = semilogy(params.snrVecDb,  results.berSBSA );grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41 51 61 71 81];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = semilogy(params.snrVecDb,  results.berDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = semilogy(params.snrVecDb,  results.berDDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];
xticks([-30:5:30]);
yticks([1e-5 1e-4 1e-3 1e-2 1e-1 1])
xlim([-20 30]);
ylim([1e-5 1]);
xticks([-20:5:30]);
set(gca,'YTickLabel',[]);
xtickangle(0)

xlabel('SNR [dB]','FontSize',fontSize);


%%% mMIMO-2
load('PreSavedResults\Fig5_mMIMO_2_Results.mat')
nexttile

a = semilogy(params.snrVecDb,  results.berFI );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41 51 61 71 81];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = semilogy(params.snrVecDb,  results.berFD );grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41 51 61 71 81];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = semilogy(params.snrVecDb,  results.berSB );grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41 51 61 71 81];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = semilogy(params.snrVecDb,  results.berSBSA );grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41 51 61 71 81];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = semilogy(params.snrVecDb,  results.berDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = semilogy(params.snrVecDb,  results.berDDPP);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41 51 61 71 81];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];
xticks([-20:5:20]);
yticks([1e-5 1e-4 1e-3 1e-2 1e-1 1])
xlim([-20 20]);
ylim([1e-5 1]);
xticks([-20:5:20]);
set(gca,'YTickLabel',[]);
xtickangle(0)

xlabel('SNR [dB]','FontSize',fontSize);


%% SE
%%% xMIMO-1
load('PreSavedResults\Fig5_xMIMO_1_Results.mat')
fontSize = 7;
figHeight= 4;
figWidth = 19;
IEEE_FIG(fontSize, figHeight, figWidth)
figure(6);
t = tiledlayout(1,4,'TileSpacing','Compact','Padding','Compact');
nexttile;

a = plot(params.snrVecDb(1:41),  results.specEffiFI(1:41)/max(results.specEffiFI(1:41)) );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = plot(params.snrVecDb(1:41),  results.specEffiFD(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = plot(params.snrVecDb(1:41),  results.specEffiSB(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = plot(params.snrVecDb(1:41),  results.specEffiSBSA(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = plot(params.snrVecDb(1:41),  results.specEffiDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = plot(params.snrVecDb(1:41),  results.specEffiDDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];

yticks([0:0.1:1])
ylim([0 1])
xticks([-40:5:0]);
xticklabels({'-20','-15','-10','-5','0','5','10','15','20'})
xtickangle(0)

xlabel('SNR [dB]','FontSize',fontSize);
ylabel('Normalized spectral efficiency','FontSize',fontSize);


%%% xMIMO-2
load('PreSavedResults\Fig5_xMIMO_2_Results.mat')
nexttile

a = plot(params.snrVecDb(1:41),  results.specEffiFI(1:41)/max(results.specEffiFI(1:41)) );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = plot(params.snrVecDb(1:41),  results.specEffiFD(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = plot(params.snrVecDb(1:41),  results.specEffiSB(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = plot(params.snrVecDb(1:41),  results.specEffiSBSA(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = plot(params.snrVecDb(1:41),  results.specEffiDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = plot(params.snrVecDb(1:41),  results.specEffiDDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];

yticks([0:0.1:1])
ylim([0 1])
xticks([-40:5:0]);
xticklabels({'-20','-15','-10','-5','0','5','10','15','20'})
xtickangle(0)
set(gca,'YTickLabel',[]);

params.figFontSize = 7;
xlabel('SNR [dB]','FontSize',fontSize);

%%% mMIMO-1
load('PreSavedResults\Fig5_mMIMO_1_Results.mat')
nexttile

a = plot(params.snrVecDb(1:41),  results.specEffiFI(1:41)/max(results.specEffiFI(1:41)) );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = plot(params.snrVecDb(1:41),  results.specEffiFD(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = plot(params.snrVecDb(1:41),  results.specEffiSB(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = plot(params.snrVecDb(1:41),  results.specEffiSBSA(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = plot(params.snrVecDb(1:41),  results.specEffiDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = plot(params.snrVecDb(1:41),  results.specEffiDDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];

yticks([0:0.1:1])
ylim([0 1])
xticks([-40:5:0]);
xticklabels({'-20','-15','-10','-5','0','5','10','15','20'})
xtickangle(0)
set(gca,'YTickLabel',[]);

params.figFontSize = 7;
xlabel('SNR [dB]','FontSize',fontSize);

%%% mMIMO-2
load('PreSavedResults\Fig5_mMIMO_2_Results.mat')
nexttile

a = plot(params.snrVecDb(1:41),  results.specEffiFI(1:41)/max(results.specEffiFI(1:41)) );grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerIndices = [1 11 21 31 41];
a.MarkerSize=6;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = plot(params.snrVecDb(1:41),  results.specEffiFD(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerIndices = [1 11 21 31 41];
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = plot(params.snrVecDb(1:41),  results.specEffiSB(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerIndices = [1 11 21 31 41];
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = plot(params.snrVecDb(1:41),  results.specEffiSBSA(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerIndices = [1 11 21 31 41];
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = plot(params.snrVecDb(1:41),  results.specEffiDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

e = plot(params.snrVecDb(1:41),  results.specEffiDDPP(1:41)/max(results.specEffiFI(1:41)));grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     =  [0 0.5 0];
e.Marker    = "pentagram";
e.MarkerIndices = [1 11 21 31 41];
e.MarkerSize=4;
e.MarkerFaceColor =  [0 0.5 0];
e.MarkerEdgeColor =  [0 0.5 0];

yticks([0:0.1:1])
ylim([0 1])
xticks([-40:5:0]);
xticklabels({'-20','-15','-10','-5','0','5','10','15','20'})
xtickangle(0)
set(gca,'YTickLabel',[]);
params.figFontSize = 7;
xlabel('SNR [dB]','FontSize',fontSize);



%% Legend
%%%%% Fig  Legend
fontSize = 7;
figHeight= 4;
figWidth = 19;
IEEE_FIG(fontSize, figHeight, figWidth)
figure(7);

a = plot(NaN,NaN);grid on; box on;hold on;
a.LineWidth = 1;
a.LineStyle = "--";
a.Color     = [0 0 0];
a.Marker    = "*";
a.MarkerSize=4;
a.MarkerFaceColor = [0 0 0];
a.MarkerEdgeColor = [0 0 0];

b = plot(NaN,NaN);grid on; box on;hold on;
b.LineWidth = 1;
b.LineStyle = "-";
b.Color     = [0 0.4470 0.7410];
b.Marker    = "square";
b.MarkerSize=4;
b.MarkerFaceColor = [0 0.4470 0.7410];
b.MarkerEdgeColor = [0 0.4470 0.7410];

c = plot(NaN,NaN);grid on; box on;hold on;
c.LineWidth = 1;
c.LineStyle = "-";
c.Color     = [0.4940 0.1840 0.5560];
c.Marker    = "o";
c.MarkerSize=4;
c.MarkerFaceColor = [0.4940 0.1840 0.5560];
c.MarkerEdgeColor = [0.4940 0.1840 0.5560];

d = plot(NaN,NaN);grid on; box on;hold on;
d.LineWidth = 1;
d.LineStyle = "-";
d.Color     = [0.9290 0.6940 0.1250];
d.Marker    = "diamond";
d.MarkerSize=4;
d.MarkerFaceColor = [0.9290 0.6940 0.1250];
d.MarkerEdgeColor = [0.9290 0.6940 0.1250];

e = plot(NaN,NaN);grid on; box on;hold on;
e.LineWidth = 1;
e.LineStyle = "-";
e.Color     = [0.8500 0.3250 0.0980];
e.Marker    = "hexagram";
e.MarkerSize=4;
e.MarkerFaceColor = [0.8500 0.3250 0.0980];
e.MarkerEdgeColor = [0.8500 0.3250 0.0980];

f = plot(NaN,NaN);grid on; box on;hold on;
f.LineWidth = 1;
f.LineStyle = "-";
f.Color     =  [0 0.5 0];
f.Marker    = "pentagram";
f.MarkerSize=4;
f.MarkerFaceColor =  [0 0.5 0];
f.MarkerEdgeColor =  [0 0.5 0];

set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
xtickangle(0)

legend('Digital', 'Analog phase shift', 'SB1','SBSA1','DPP', 'DDPP',  'fontsize', fontSize)
% set(a, 'visible', 'off');
% set(b, 'visible', 'off');
% set(c, 'visible', 'off');
% set(d, 'visible', 'off');
% set(e, 'visible', 'off');

set(gca, 'visible', 'off');

params.figFontSize = 7;

% ylabel('BER','FontSize',params.figFontSize);
legend('Digital', 'Analog phase shift', '[9]','[12]','[15]', 'DDPP',  'fontsize', fontSize)
n = legend;
set(n,'NumColumns',6,'FontSize',fontSize);
n.ItemTokenSize = 6*[5 , 5, 5 ,5 , 5, 5, 5];
box on;

