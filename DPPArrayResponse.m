function dppBeamformer = DPPArrayResponse (azimuth, nTx, nTtd, params)

% Delay phase precoding
dppBeamformer = zeros(nTx, params.nCarr);
for carrIdx   = 1:params.nCarr
  fCarr                     = params.carrFreq + params.sampFreq / (params.nCarr) * (carrIdx-1-(params.nCarr - 1) / 2);
  ttdResp                   = exp(-1j * pi * nTx / nTtd * sin(deg2rad(azimuth)) * (fCarr / params.carrFreq - 1)*(0:nTtd - 1).');
  dppBeamformer(:, carrIdx) = kron(ttdResp, ones(nTx/nTtd,1));
end