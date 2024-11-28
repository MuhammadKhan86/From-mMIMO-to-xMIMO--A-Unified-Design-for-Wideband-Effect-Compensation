function params = ParamsInitialize

params.implenetaion = 'FreqDomain'; %FreqDomain, TimeDomain
% Simulation Parameters
params.nSims          = 10000*1;
params.snrVecDb       = -20:5:30;
params.snrVecLin      = 10.^(params.snrVecDb/10);

% System Parameters
params.sampFreq       = 8e9;
params.carrFreq       = 8e9;
params.waveLength     = physconst('LightSpeed')/params.carrFreq ;
params.antElemSpacing = 1/2 * params.waveLength;

% OFDM Params
params.nCarr          = 1024;
params.subCarrSpacing = params.sampFreq / params.nCarr;
params.nCp            = 72;

params.bitsPerSymb    = 1;
params.nBits          = params.nCarr * params.bitsPerSymb;

% Antenna Array Parameters
params.antElement     = phased.IsotropicAntennaElement;
params.nTx            = [1 256];
params.nRx            = [1 1];
params.aziSwpRng      = [-60 60];
params.eleSwpRng      = [-45 45];
params.eleSwpTx       = 0;
params.eleSwpRx       = 0;
params.nBeamsTx       = 1;
params.nBeamsRx       = 1;

% UE Specific Params
params.posTx              = [0, 0, 0];
params.posRxSph           = [100, 60, 0];
[xPosUe, yPosUe, zPosUe]  = sph2cart(deg2rad(params.posRxSph(:, 2)),...
  deg2rad(params.posRxSph(:, 3)), params.posRxSph(:, 1));
params.posRxCart          = [xPosUe, yPosUe, zPosUe];

% Channel Params
params.ricianFactor   = 1;
params.pathDelay      = [0 30 70 90 110 190 410]*1e-6;
params.pathGain       = [0 -10 -20 -30 -80 -17.2 -20.8];


% [params.pathDelayAligned, params.pdpPowAligned] = AlignPDP(params);
% % params.pathDelayAligned = 
% % params.AoD            = ones(length(params.pathDelay),1)*params.posRxSph(2);
% % params.AoA            = ones(length(params.pathDelay),1)*params.posRxSph(2) + 180;
% 
% params.pathDelay      = params.pathDelayAligned;
% params.pathGain       = 10*log10(params.pdpPowAligned);

% params.pathDelay      = [0 30 70 90 110 190 410]*1e-6;
% params.pathGain       = [0 -10 -20 -30 -80 -17.2 -20.8];
% rng(1)

params.AoD            = [params.posRxSph(2) randi([-60 60], 1 ,length(params.pathDelay))];
params.AoA            = [params.posRxSph(2) randi([-60 60], 1 ,length(params.pathDelay))] + 180;

%%% DDPP params
params.nTtdTx         = prod(params.nTx) / sqrt(prod(params.nTx));
params.nTtdRx         = prod(params.nRx) / sqrt(prod(params.nRx));

%%% DPP params
params.nTtdTxDPP      = (prod(params.nTx)/params.nTtdTx+params.nTtdTx);
params.nTtdRxDPP      = (prod(params.nRx)/params.nTtdRx+params.nTtdRx);
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


for carrIdx   = 1:params.nCarr
  fCarr(carrIdx)                      = params.carrFreq + params.sampFreq / (params.nCarr) * (carrIdx-1-(params.nCarr - 1) / 2);
end


params.nBands = 64;
for bandIdx = 1:params.nBands
  params.bandCarrFreq(bandIdx) = params.carrFreq - (params.nBands-1)* params.sampFreq/2*1/params.nBands + (bandIdx-1)*params.sampFreq/params.nBands;
end
carrPerband = params.nCarr/params.nBands;

for bandIdx = 1: params.nBands
  bandFreq = params.bandCarrFreq(bandIdx);
  for carrIdx   = 1:carrPerband
    bandDepFCarr(bandIdx, carrIdx) = bandFreq + params.sampFreq / (params.nBands*carrPerband) * (carrIdx-1-(carrPerband - 1) / 2);
  end
end

params.subArraysTx = 2;
params.subArraysRx = 1;