function [perCarrGainFI, arayGainFI, specEffiFI,  berFI, ...
  perCarrGainFD, arayGainFD, specEffiFD,  berFD, ...
  perCarrGainSB, arayGainSB, specEffiSB,  berSB, ...
  perCarrGainSBSA, arayGainSBSA, specEffiSBSA,  berSBSA, ...
  perCarrGainDPP, arayGainDPP, specEffiDPP,  berDPP, ...
  perCarrGainDDPP, arayGainDDPP, specEffiDDPP,  berDDPP] = BeamSquintSim(params)


% Frequency Independent Analog Beamformer & Combiner
%%% freqOffset = f_m/f_c, 180 UE offset for perfect orientation
txAnaBeamformer = ArrayResponse(params.posRxSph(2),       prod(params.nTx), 1);
rxAnaCombiner   = ArrayResponse(params.posRxSph(2) + 180, prod(params.nRx), 1);

% Sub band Beamformer
txSbBeamformer = SBArrayResponse (params.posRxSph(2), prod(params.nTx), params);
rxSbCombiner   = SBArrayResponse (params.posRxSph(2)+180, prod(params.nRx), params);

% Sub band Sub array Beamformer
txSbSaBeamformer = SBArrayResponse (params.posRxSph(2), prod(params.nTx)/params.subArraysTx, params);
rxSbSaCombiner   = SBArrayResponse (params.posRxSph(2)+180, prod(params.nRx)/params.subArraysRx, params);

% Delay Phase Precoding (DPP) Beamformer & Combiner
txDppBeamformer = DPPArrayResponse (params.posRxSph(2), prod(params.nTx), params.nTtdTxDPP, params);
rxDppCombiner   = DPPArrayResponse (params.posRxSph(2) + 180, prod(params.nRx), params.nTtdRxDPP, params);

% Double Delay Phase Precoding (DPP) Beamformer & Combiner
txDdppBeamformer = DDPPArrayResponse (params.posRxSph(2), prod(params.nTx), params.nTtdTx, params);
rxDdppCombiner   = DDPPArrayResponse (params.posRxSph(2) + 180, prod(params.nRx), params.nTtdRx, params);

% Payload Bits
payloadBits   = randi([0 1],[params.nBits 1]);

% Bits to QAM Symbol
qamSymb       = BasebandModulate(payloadBits, params.bitsPerSymb);

% Freq Independent Tx Beamforming
beamFormedSig = ArrayResponse(params.posRxSph(2), prod(params.nTx), 1)*qamSymb.';

% DPP Beamforming
sbBeamformedSig   = zeros(prod(params.nTx), params.nCarr);
sbSaBeamformedSig = zeros(prod(params.nTx)/params.subArraysTx, params.nCarr);
dppBeamformedSig  = zeros(prod(params.nTx), params.nCarr);
ddppBeamformedSig = zeros(prod(params.nTx), params.nCarr);
for carrIdx = 1:params.nCarr
  sbBeamformedSig (:, carrIdx) = txSbBeamformer (:, carrIdx) * qamSymb(carrIdx);
  sbSaBeamformedSig (:, carrIdx) = txSbSaBeamformer (:, carrIdx) * qamSymb(carrIdx);
  dppBeamformedSig (:, carrIdx) = (txAnaBeamformer .* txDppBeamformer (:, carrIdx)) * qamSymb(carrIdx);
  ddppBeamformedSig(:, carrIdx) = (txAnaBeamformer .* txDdppBeamformer(:, carrIdx)) * qamSymb(carrIdx);
end

% Chanel Generation and Effective Channel
% [freqIndCfr, effFreqIndCfr, freqDepCfr, effFreqDepCfr, effFreqDepDPPCfr, effFreqDepDDPPCfr] = ChannelGenerator(txAnaBeamformer, rxAnaCombiner, txDppBeamformer, rxDppCombiner, txDdppBeamformer, rxDdppCombiner, params);

[freqIndCfr, effFreqIndCfr, freqDepCfr, effFreqDepCfr, effSbCfr, effSbSaCfr, effFreqDepDPPCfr, effFreqDepDDPPCfr] = ...
  MIMOChannel(txAnaBeamformer, rxAnaCombiner, txSbBeamformer, rxSbCombiner, txSbSaBeamformer, rxSbSaCombiner, txDppBeamformer, rxDppCombiner, txDdppBeamformer, rxDdppCombiner, params);

% Introduce channel impairments
rxSignalFI   = zeros(prod(params.nRx), params.nCarr);
rxSignalFD   = zeros(prod(params.nRx), params.nCarr);
rxSignalSB   = zeros(prod(params.nRx), params.nCarr);
rxSignalSBSA = zeros(prod(params.nRx)/params.subArraysRx, params.nCarr);
rxSignalDPP  = zeros(prod(params.nRx), params.nCarr);
rxSignalDDPP = zeros(prod(params.nRx), params.nCarr);
for carrIdx = 1:params.nCarr
  rxSignalFI  (:, carrIdx)     = squeeze(freqIndCfr(:,:,carrIdx)) * beamFormedSig    (:, carrIdx);
  rxSignalFD  (:, carrIdx)     = squeeze(freqDepCfr(:,:,carrIdx)) * beamFormedSig    (:, carrIdx);
  rxSignalSB  (:, carrIdx)     = squeeze(freqDepCfr(:,:,carrIdx)) * sbBeamformedSig    (:, carrIdx);
  rxSignalSBSA(:, carrIdx)     = squeeze(freqDepCfr(1:prod(params.nRx)/params.subArraysRx,1:prod(params.nTx)/params.subArraysTx,carrIdx)) * sbSaBeamformedSig    (:, carrIdx);
  rxSignalDPP (:, carrIdx)     = squeeze(freqDepCfr(:,:,carrIdx)) * dppBeamformedSig (:, carrIdx);
  rxSignalDDPP(:, carrIdx)     = squeeze(freqDepCfr(:,:,carrIdx)) * ddppBeamformedSig(:, carrIdx);
end

% For Noise Generation
sigPwr          = mean(abs(qamSymb(:)).^2);
noiseComplexSig = 1/sqrt(2)*(randn(size(rxSignalFI)) + 1j*randn(size(rxSignalFI)));

for snrIdx = 1:size(params.snrVecLin, 2)

  % Noise Power
  snrLin   = params.snrVecLin(snrIdx);
  noisePwr = sigPwr / snrLin;

  % Noise Addition
  rxSigNoisyFI      = rxSignalFI   + sqrt(noisePwr) * noiseComplexSig;
  rxSigNoisyFD      = rxSignalFD   + sqrt(noisePwr) * noiseComplexSig;
  rxSigNoisySB      = rxSignalSB   + sqrt(noisePwr) * noiseComplexSig;
  rxSigNoisySBSA    = rxSignalSBSA   + sqrt(noisePwr) * noiseComplexSig;
  rxSigNoisyDPP     = rxSignalDPP  + sqrt(noisePwr) * noiseComplexSig;
  rxSigNoisyDDPP    = rxSignalDDPP + sqrt(noisePwr) * noiseComplexSig;

  % Freq Independent Rx Combiner
  rxCombinedSigFI   = ArrayResponse(params.posRxSph(2) + 180, prod(params.nRx), 1)' * rxSigNoisyFI;
  rxCombinedSigFD   = ArrayResponse(params.posRxSph(2) + 180, prod(params.nRx), 1)' * rxSigNoisyFD;
  % DPP Beamforming
  rxCombinedSigSB   = zeros(1, params.nCarr);
  rxCombinedSigSBSA = zeros(1, params.nCarr);
  rxCombinedSigDPP  = zeros(1, params.nCarr);
  rxCombinedSigDDPP = zeros(1, params.nCarr);
  for carrIdx = 1:params.nCarr
    rxCombinedSigSB (:, carrIdx)  = rxSbCombiner(:,carrIdx)' * rxSigNoisySB(:, carrIdx);
    rxCombinedSigSBSA(:, carrIdx) = rxSbSaCombiner(:,carrIdx)' * rxSigNoisySBSA(:, carrIdx);
    rxCombinedSigDPP (:, carrIdx) = (rxAnaCombiner .* rxDppCombiner (:,(carrIdx)))' * rxSigNoisyDPP(:, carrIdx);
    rxCombinedSigDDPP(:, carrIdx) = (rxAnaCombiner .* rxDdppCombiner(:,(carrIdx)))' * rxSigNoisyDDPP(:, carrIdx);
  end

  % Equalization
  rxQamSigDecodedFI   = MimoDecoder(rxCombinedSigFI  (:), effFreqIndCfr   (:));
  rxQamSigDecodedFD   = MimoDecoder(rxCombinedSigFD  (:), effFreqDepCfr   (:));
  rxQamSigDecodedSB   = MimoDecoder(rxCombinedSigSB  (:), effSbCfr   (:));
  rxQamSigDecodedSBSA = MimoDecoder(rxCombinedSigSBSA  (:), effSbSaCfr   (:));
  rxQamSigDecodedDPP  = MimoDecoder(rxCombinedSigDPP (:), effFreqDepDPPCfr(:));
  rxQamSigDecodedDDPP = MimoDecoder(rxCombinedSigDDPP(:), effFreqDepDDPPCfr(:));

  % QAM symbols to bits
  rxBitsFI          = BasebandDemodulate(rxQamSigDecodedFI  , params.bitsPerSymb);
  rxBitsFD          = BasebandDemodulate(rxQamSigDecodedFD  , params.bitsPerSymb);
  rxBitsSB          = BasebandDemodulate(rxQamSigDecodedSB  , params.bitsPerSymb);
  rxBitsSBSA        = BasebandDemodulate(rxQamSigDecodedSBSA, params.bitsPerSymb);
  rxBitsDPP         = BasebandDemodulate(rxQamSigDecodedDPP , params.bitsPerSymb);
  rxBitsDDPP        = BasebandDemodulate(rxQamSigDecodedDDPP, params.bitsPerSymb);

  % Results
  perCarrGainFI  (1:params.nCarr)      = abs(effFreqIndCfr.')    .^2;
  perCarrGainFD  (1:params.nCarr)      = abs(effFreqDepCfr.')    .^2;
  perCarrGainSB  (1:params.nCarr)      = abs(effSbCfr.')         .^2;
  perCarrGainSBSA(1:params.nCarr)      = abs(effSbSaCfr.')       .^2;
  perCarrGainDPP (1:params.nCarr)      = abs(effFreqDepDPPCfr.') .^2;
  perCarrGainDDPP(1:params.nCarr)      = abs(effFreqDepDDPPCfr.').^2;


  arayGainFI  (snrIdx)                = mean(abs(effFreqIndCfr)    .^2);
  arayGainFD  (snrIdx)                = mean(abs(effFreqDepCfr)    .^2);
  arayGainSB  (snrIdx)                = mean(abs(effSbCfr)         .^2);
  arayGainSBSA(snrIdx)                = mean(abs(effSbSaCfr)       .^2);
  arayGainDPP (snrIdx)                = mean(abs(effFreqDepDPPCfr) .^2);
  arayGainDDPP(snrIdx)                = mean(abs(effFreqDepDDPPCfr).^2);

  specEffiFI  (snrIdx)                 = log2(1 + arayGainFI  (snrIdx) / noisePwr);
  specEffiFD  (snrIdx)                 = log2(1 + arayGainFD  (snrIdx) / noisePwr);
  specEffiSB  (snrIdx)                 = log2(1 + arayGainSB  (snrIdx) / noisePwr);
  specEffiSBSA(snrIdx)                 = log2(1 + arayGainSBSA(snrIdx) / noisePwr);
  specEffiDPP (snrIdx)                 = log2(1 + arayGainDPP (snrIdx) / noisePwr);
  specEffiDDPP(snrIdx)                 = log2(1 + arayGainDDPP(snrIdx) / noisePwr);

  errVecFI                            = abs ( payloadBits(:) - rxBitsFI  (:) );
  errVecFD                            = abs  (payloadBits(:) - rxBitsFD  (:) );
  errVecSB                            = abs  (payloadBits(:) - rxBitsSB  (:) );
  errVecSBSA                          = abs  (payloadBits(:) - rxBitsSBSA(:) );
  errVecDPP                           = abs ( payloadBits(:) - rxBitsDPP (:) );
  errVecDDPP                          = abs ( payloadBits(:) - rxBitsDDPP(:) );

  berFI(snrIdx)                       = nnz ( errVecFI)   / length(payloadBits(:) );
  berFD(snrIdx)                       = nnz ( errVecFD)   / length(payloadBits(:) );
  berSB(snrIdx)                       = nnz ( errVecSB)   / length(payloadBits(:) );
  berSBSA(snrIdx)                     = nnz ( errVecSBSA) / length(payloadBits(:) );
  berDPP(snrIdx)                      = nnz ( errVecDPP)  / length(payloadBits(:) );
  berDDPP(snrIdx)                     = nnz ( errVecDDPP) / length(payloadBits(:) );
end
