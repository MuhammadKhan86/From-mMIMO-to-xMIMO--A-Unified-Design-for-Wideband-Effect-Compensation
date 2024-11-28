function qamSymbNormalized=BasebandModulate(payloadBits,bitsPerSymb)

qamSymb=qammod(payloadBits(:),2^bitsPerSymb,'Gray', 'InputType','Bit');
% constellation powers mean(abs(qamSymb).^2)
normalizationVec=[1 2 nan 9.94 nan 41.613333 nan 169.95333];
% Normalized QAM Symbols
qamSymbNormalized=qamSymb/sqrt(normalizationVec(bitsPerSymb));