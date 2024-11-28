function ofdmSig = OfdmModulate(inputSig, params)

timeDomSig = sqrt(params.nCarr) * ifft(inputSig, params.nCarr, 1);
ofdmSig    = [timeDomSig(params.nCarr - params.nCp+1 : params.nCarr); timeDomSig];
