function demodOut = BasebandDemodulate(rxQamEqzed,modOrder)

% constellation powers mean(abs(qamSymb).^2)
normalizationVec = [1 2 nan 9.94 nan 41.613333 nan 169.95333];
rxQamSymNorm     = rxQamEqzed*sqrt(normalizationVec(modOrder)); % Normalization

% Demodulation Object for hard decision
demodOut = qamdemod(rxQamSymNorm.',(2^modOrder),'Gray', 'OutputType','bit');