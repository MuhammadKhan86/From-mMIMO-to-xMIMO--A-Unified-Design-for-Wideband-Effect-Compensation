function [rxSignal, effFreqIndChanCfr] = ChannelImpairments(qamSymb, antWeightsTx, antWeightsRx, freqChan, params)

for carrIdx = 1:params.nCarr
  effFreqIndChanCfr(carrIdx,:) = antWeightsRx'* freqChan(:, :, carrIdx) * antWeightsTx;
end

rxSignal = effFreqIndChanCfr.*qamSymb;

