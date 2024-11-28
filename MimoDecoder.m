function rxQamFrame = MimoDecoder(rxSigCombined, chanCfrEst)

% Equalization
rxQamFrameDecoded     = rxSigCombined./chanCfrEst;
rxQamFrame            = rxQamFrameDecoded(:);

