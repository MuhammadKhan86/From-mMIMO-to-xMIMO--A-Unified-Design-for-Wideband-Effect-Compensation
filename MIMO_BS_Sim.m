function MIMO_BS_Sim
clear all; clc;
params = ParamsInitialize;

% SNR_dB to Eb-N0_dB Conversion
offsetDueToModulation = 10*log10(params.bitsPerSymb);
ebNoVecDb             = params.snrVecDb - ( offsetDueToModulation );

% Main Processing loop --> If possible run on parallel clusters
params = parallel.pool.Constant(params); params = params.Value;

for simIdx = 1:params.nSims
  [ perCarrgainFI(simIdx,:),   arayGainFI(simIdx,:),   specEffiFI(simIdx,:),   berFI(simIdx,:) , ...
    perCarrgainFD(simIdx,:),   arayGainFD(simIdx,:),   specEffiFD(simIdx,:),   berFD(simIdx,:) , ...
    perCarrgainSB(simIdx,:),   arayGainSB(simIdx,:),   specEffiSB(simIdx,:),   berSB(simIdx,:) , ...
    perCarrgainSBSA(simIdx,:), arayGainSBSA(simIdx,:), specEffiSBSA(simIdx,:), berSBSA(simIdx,:) , ...
    perCarrgainDPP(simIdx,:),  arayGainDPP(simIdx,:),  specEffiDPP(simIdx,:),  berDPP(simIdx,:), ...
    perCarrgainDDPP(simIdx,:), arayGainDDPP(simIdx,:), specEffiDDPP(simIdx,:), berDDPP(simIdx,:)] = BeamSquintSim(params);
end

% Frequency Independent Channel or Full TTD Implementation as both are equal
results.perCarrgainFI = mean(perCarrgainFI,1);  results.arryGainFI  = mean(arayGainFI,1);
results.specEffiFI    = mean(specEffiFI,1);     results.berFI       = mean(berFI,1);

% Analog beamforming with frequency dependent channel
results.perCarrgainFD = mean(perCarrgainFD,1); results.arryGainFD  = mean(arayGainFD,1);
results.specEffiFD    = mean(specEffiFD,1);    results.berFD       = mean(berFD,1);

% SUB-Band Approach Fully Connected
results.perCarrgainSB = mean(perCarrgainSB,1); results.arryGainSB  = mean(arayGainSB,1);
results.specEffiSB    = mean(specEffiSB,1);    results.berSB       = mean(berSB,1);

% SUB-Band Approach Partially Connected
results.perCarrgainSBSA = mean(perCarrgainSBSA,1); results.arryGainSBSA   = mean(arayGainSBSA,1);
results.specEffiSBSA    = mean(specEffiSBSA,1);    results.berSBSA       = mean(berSBSA,1);

% Delay Phase Precoding
results.perCarrgainDPP  = mean(perCarrgainDPP,1); results.arryGainDPP = mean(arayGainDPP,1);
results.specEffiDPP     = mean(specEffiDPP,1);    results.berDPP      = mean(berDPP,1);

% Double Delay Phase Precoding
results.perCarrgainDDPP  = mean(perCarrgainDDPP,1); results.arryGainDDPP = mean(arayGainDDPP,1);
results.specEffiDDPP     = mean(specEffiDDPP,1);    results.berDDPP      = mean(berDDPP,1);


% Gain Per Carrier
figure(1); plot(1:params.nCarr, 10*log10(results.perCarrgainFI)   ,'-','LineWidth',1); grid on; hold on;
figure(1); plot(1:params.nCarr, 10*log10(results.perCarrgainFD)   ,'-','LineWidth',1); grid on; hold on;
figure(1); plot(1:params.nCarr, 10*log10(results.perCarrgainSB)   ,'-','LineWidth',1); grid on; hold on;
figure(1); plot(1:params.nCarr, 10*log10(results.perCarrgainSBSA) ,'-','LineWidth',1); grid on; hold on;
figure(1); plot(1:params.nCarr, 10*log10(results.perCarrgainDPP)  ,'-','LineWidth',1); grid on; hold on;
figure(1); plot(1:params.nCarr, 10*log10(results.perCarrgainDDPP) ,'-','LineWidth',1); grid on; hold on;

% Effective Array Gain
figure(2); plot(ebNoVecDb, 10*log10(results.arryGainFI)  ,'-','LineWidth',1); grid on; hold on;
figure(2); plot(ebNoVecDb, 10*log10(results.arryGainFD)  ,'-','LineWidth',1); grid on; hold on;
figure(2); plot(ebNoVecDb, 10*log10(results.arryGainSB)  ,'-','LineWidth',1); grid on; hold on;
figure(2); plot(ebNoVecDb, 10*log10(results.arryGainSBSA),'-','LineWidth',1); grid on; hold on;
figure(2); plot(ebNoVecDb, 10*log10(results.arryGainDPP) ,'-','LineWidth',1); grid on; hold on;
figure(2); plot(ebNoVecDb, 10*log10(results.arryGainDDPP),'-','LineWidth',1); grid on; hold on;

% Spectral Efficiency
figure(3); plot(ebNoVecDb, results.specEffiFI  ,'-','LineWidth',1); grid on; hold on;
figure(3); plot(ebNoVecDb, results.specEffiFD  ,'-','LineWidth',1); grid on; hold on;
figure(3); plot(ebNoVecDb, results.specEffiSB  ,'-','LineWidth',1); grid on; hold on;
figure(3); plot(ebNoVecDb, results.specEffiSBSA,'-','LineWidth',1); grid on; hold on;
figure(3); plot(ebNoVecDb, results.specEffiDPP ,'-','LineWidth',1); grid on; hold on;
figure(3); plot(ebNoVecDb, results.specEffiDDPP,'-','LineWidth',1); grid on; hold on;

% BER
figure(4); semilogy(ebNoVecDb,  results.berFI  ,'-','LineWidth',1); grid on; hold on;
figure(4); semilogy(ebNoVecDb,  results.berFD  ,'-','LineWidth',1); grid on; hold on;
figure(4); semilogy(ebNoVecDb,  results.berSB  ,'-','LineWidth',1); grid on; hold on;
figure(4); semilogy(ebNoVecDb,  results.berSBSA,'-','LineWidth',1); grid on; hold on;
figure(4); semilogy(ebNoVecDb,  results.berDPP ,'-','LineWidth',1); grid on; hold on;
figure(4); semilogy(ebNoVecDb,  results.berDDPP,'-','LineWidth',1); grid on; hold on;
