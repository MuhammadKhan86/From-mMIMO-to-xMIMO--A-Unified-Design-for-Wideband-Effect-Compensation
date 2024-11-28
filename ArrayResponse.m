function arrayResp = ArrayResponse(azimuth, nAntennas, freqOffset)

% Antenna Array Response
arrayResp = 1/sqrt(nAntennas) * exp(-1j*pi*freqOffset*sin(deg2rad(azimuth))*(0:nAntennas-1).');

if 0
azimuth = azimuth;
N = nAntennas;
d = lambda/2;
if N == 1
  arrayResp = 1;
else
  % case 'ULA'
  arrayResp = ULAArrayResponse(azimuth,N,d,lambda);
  % case 'UPA'
  %   a = UPAArrayResponse(azimuth,N,d,lambda);
end
end

function a=ULAArrayResponse(azimuth,N,d,lamada)
phi = azimuth(1);
a=[(sqrt(1/N))*(exp(1i*[0:N-1]*2*pi*d*sin(deg2rad(phi))/lamada)).'];
end

function a=UPAArrayResponse(azimuth,N,d,lamada)

N_H = sqrt(N);
N_V = sqrt(N);
% for UPA we assume equal number of elements in azimuth and elevation
phi = azimuth(1);
theta = azimuth(2);
aH=[(sqrt(1/N_H))*(exp(-1i*[0:N_H-1]*2*pi*d*sin(phi)*cos(theta)/lamada)).'];
aV=[(sqrt(1/N_V))*(exp(-1i*[0:N_V-1]*2*pi*d*sin(phi)/lamada)).'];
a = kron(aV, aH);
end
end