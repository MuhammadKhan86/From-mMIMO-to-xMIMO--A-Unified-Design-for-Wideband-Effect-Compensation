function [freqIndChan, effFreqIndChanCfr, freqDepChan, effFreqDepChanCfr, effSbCfr, effSbSaCfr, effDPPCfr, effDDPPCfr]  = ...
  MIMOChannel(anaBeamformer, anaCombiner, txSbBeamformer, rxSbCombiner, txSbSaBeamformer, rxSbSaCombiner, txDppBeamformer, rxDppCombiner, txDdppBeamformer, rxDdppCombiner, params)

delays        = params.pathDelay;
pdpPowLin     = 10.^(params.pathGain/10);
pdpPowLinNorm = pdpPowLin/sum(pdpPowLin);
pathGains     = 1/sqrt(2)*...
  (randn(length(params.pathDelay),1) + ...
  randn(length(params.pathDelay),1)*1j).*...
  sqrt(pdpPowLinNorm).';


effDelay    = zeros(size(delays,2), prod(params.nRx), prod(params.nTx));
CIR         = zeros(size(delays,2), prod(params.nRx), prod(params.nTx));
freqDepCFR  = zeros(size(delays,2), prod(params.nRx), prod(params.nTx), params.nCarr);
freqIndCFR  = zeros(size(delays,2), prod(params.nRx), prod(params.nTx), params.nCarr);
for pathIdx = 1:length(delays)
  for rxIdx = 1:prod(params.nRx)
    for txIdx = 1:prod(params.nTx)
      effDelay(pathIdx, rxIdx, txIdx) = delays(pathIdx) -  ...
        (txIdx-1) * params.antElemSpacing/physconst('LightSpeed') *sin(deg2rad(params.AoD(pathIdx))) + ...
        (rxIdx-1) * params.antElemSpacing/physconst('LightSpeed') *sin(deg2rad(params.AoA(pathIdx)));
      CIR(pathIdx, rxIdx, txIdx) = pathGains(pathIdx) * exp (-1j * 2*pi * params.carrFreq*effDelay(pathIdx, rxIdx, txIdx));
      % CIR1(pathIdx, rxIdx, txIdx) = pathGains(pathIdx) * exp (-1j * 2*pi * params.carrFreq*delays(pathIdx)) * ...
      %   exp (-1j *2*pi * (txIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoD(pathIdx))))  * ...
      %   exp (-1j *2*pi * (rxIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoA(pathIdx))));
      for carrIdx=1:params.nCarr
        fCarr = params.sampFreq / (params.nCarr) * (carrIdx - 1 - (params.nCarr - 1) / 2);
        freqDepCFR(pathIdx, rxIdx, txIdx, carrIdx) = CIR(pathIdx, rxIdx, txIdx) * exp (-1j * 2*pi * fCarr*effDelay(pathIdx, rxIdx, txIdx));
        freqIndCFR(pathIdx, rxIdx, txIdx, carrIdx) = CIR(pathIdx, rxIdx, txIdx) * exp (-1j * 2*pi * params.carrFreq*delays(pathIdx));
      end
    end
  end
end

cfrDimension  = size(freqDepCFR);
freqDepChan   = reshape(sum(freqDepCFR,1), [cfrDimension(2:end) 1]);
freqIndChan   = reshape(sum(freqIndCFR,1), [cfrDimension(2:end) 1]);


effFreqIndChanCfr = zeros(params.nCarr, 1);
effFreqDepChanCfr = zeros(params.nCarr, 1);
effSbCfr          = zeros(params.nCarr, 1);
effDPPCfr         = zeros(params.nCarr, 1);
effDDPPCfr        = zeros(params.nCarr, 1);
for carrIdx       = 1:params.nCarr
  effFreqIndChanCfr(carrIdx,:) = anaCombiner' * freqIndChan(:, :, carrIdx) * anaBeamformer;
  effFreqDepChanCfr(carrIdx,:) = anaCombiner' * freqDepChan(:, :, carrIdx) * anaBeamformer;
  effSbCfr(carrIdx,:)          = rxSbCombiner(:, carrIdx)' * freqDepChan(:, :, carrIdx) * txSbBeamformer(:, carrIdx);
  effSbSaCfr(carrIdx,:)        = rxSbSaCombiner(:, carrIdx)' * freqDepChan(1:prod(params.nRx)/params.subArraysRx,1:prod(params.nTx)/params.subArraysTx,carrIdx) * txSbSaBeamformer(:, carrIdx);
  effDPPCfr(carrIdx,:)  = (anaCombiner .* rxDppCombiner  (:, carrIdx))' * freqDepChan(:, :, carrIdx) * (anaBeamformer .* txDppBeamformer  (:, carrIdx)) ;
  effDDPPCfr(carrIdx,:) = (anaCombiner .* rxDdppCombiner (:, carrIdx))' * freqDepChan(:, :, carrIdx) * (anaBeamformer .* txDdppBeamformer (:, carrIdx)) ;
end




% % % % Alternate Implementation
% for pathIdx = 1:length(delays)
%   for rxIdx = 1:prod(params.nRx)
%     for txIdx = 1:prod(params.nTx)
%       effDelay(pathIdx, rxIdx, txIdx) = delays(pathIdx) -  ...
%         (txIdx-1) * params.antElemSpacing/physconst('LightSpeed') *sin(deg2rad(params.AoD(pathIdx))) - ...
%         (rxIdx-1) * params.antElemSpacing/physconst('LightSpeed') *sin(deg2rad(params.AoA(pathIdx)));
%       CIR(pathIdx, rxIdx, txIdx) = pathGains(pathIdx) * exp (-1j * 2*pi * params.carrFreq*delays(pathIdx)) * ...
%         exp (-1j *2*pi * (txIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoD(pathIdx))))  * ...
%         exp (-1j *2*pi * (rxIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoA(pathIdx))));
%       for carrIdx=1:params.nCarr
%         fCarr = params.carrFreq + params.sampFreq / (params.nCarr) * (carrIdx - 1 - (params.nCarr - 1) / 2);
%         freqDepCFR1(pathIdx, rxIdx, txIdx, carrIdx) = pathGains(pathIdx) * exp (-1j * 2*pi * params.carrFreq*delays(pathIdx)) * ...
%           exp (-1j *2*pi * (txIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoD(pathIdx))) * fCarr/params.carrFreq)   * ...
%           exp (-1j *2*pi * (rxIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoA(pathIdx)))* fCarr/params.carrFreq)   * ...
%           exp (-1j * 2*pi * fCarr*delays(pathIdx));
%         freqIndCFR1(pathIdx, rxIdx, txIdx, carrIdx) = pathGains(pathIdx) * exp (-1j * 2*pi * params.carrFreq*delays(pathIdx)) * ...
%           exp (-1j *2*pi * (txIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoD(pathIdx))) * params.carrFreq/params.carrFreq)   * ...
%           exp (-1j *2*pi * (rxIdx-1) *  params.antElemSpacing/params.waveLength * sin(deg2rad(params.AoA(pathIdx)))* params.carrFreq/params.carrFreq)   * ...
%           exp (-1j * 2*pi * params.carrFreq*delays(pathIdx));
%       end
%     end
%   end
% end
% cfrDimension = size(freqDepCFR1);
% freqDepChan1 = reshape(sum(freqDepCFR1,1), [cfrDimension(2:end) 1]);
% freqIndChan1 = reshape(sum(freqIndCFR1,1), [cfrDimension(2:end) 1]);

