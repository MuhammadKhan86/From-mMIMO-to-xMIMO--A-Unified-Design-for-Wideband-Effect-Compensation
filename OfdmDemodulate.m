function freqDomSig = OfdmDemodulate(inputSig, params)

cPRemSig   = inputSig(params.nCp + 1 : params.nCp + params.nCarr);
freqDomSig = 1/sqrt(params.nCarr).*fft(cPRemSig, params.nCarr,1);