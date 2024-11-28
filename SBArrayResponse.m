function sbBeamformer = SBArrayResponse (azimuth, nAntennas, params)

% Delay phase precoding
sbBeamformerPerBand = zeros(nAntennas, params.nBands);
for bandIdx = 1:params.nBands
    fCarr                     = params.bandCarrFreq(bandIdx);
    sbResp                    = 1/sqrt(nAntennas) *exp(-1j * pi * sin(deg2rad(azimuth)) * (fCarr / params.carrFreq)*(0:nAntennas - 1).');
    sbBeamformerPerBand(:, bandIdx)  = sbResp;
end

sbBeamformer = repelem(sbBeamformerPerBand, 1, params.nCarr/params.nBands);