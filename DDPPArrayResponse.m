function ddppBeamformer = DDPPArrayResponse (azimuth, nTx, nTtd, params)

% Delay phase precoding
ddppBeamformer = zeros(nTx, params.nCarr);
for carrIdx   = 1:params.nCarr
  fCarr                      = params.carrFreq + params.sampFreq / (params.nCarr) * (carrIdx-1-(params.nCarr - 1) / 2);
  ttdResp1                   = exp(-1j * pi * nTx / nTtd * sin(deg2rad(azimuth)) * (fCarr / params.carrFreq - 1)*(0:nTtd - 1).');
  ttdResp2                   = exp(-1j * pi * sin(deg2rad(azimuth)) * (fCarr / params.carrFreq - 1)*(0:nTx / nTtd - 1).');
  ddppBeamformer(:, carrIdx) = kron(ones(nTtd,1), ttdResp2) .* kron(ttdResp1, ones(nTx/nTtd,1));
end