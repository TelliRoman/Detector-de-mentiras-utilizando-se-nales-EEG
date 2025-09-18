function caract = extraer_caractersiticas(x, fm, n)
  pkg load signal;

  % Inicialización de la matriz de características
  caract = zeros(1, 5);

  % Cálculo de la Transformada de Fourier
  X = fft(x);
  N = length(X); % Obtención de la cantidad de muestras
  deltaf = fm / N;
  f = 0 : deltaf : fm - deltaf;

  % Inicialización de los vectores de características de bandas de frecuencia
  Gamma = zeros(1, N);
  HAlpha = zeros(1, N);
  Beta = zeros(1, N);
  HBeta = zeros(1, N);
  Total = zeros(1, N);

  % Definición de los límites de frecuencia para cada banda
  fGamma1 = 25; fGamma2 = 40;
  fHAlpha1 = 10; fHAlpha2 = 12;
  fBeta1 = 14; fBeta2 = 30;
  fHBeta1 = 25; fHBeta2 = 35;
  fTotal1 = 4; fTotal2 = 35;

  % Cálculo de la densidad espectral de potencia de la FFT de x
  #X_pds = (1 / (fm * N)) * abs(X).^2;

  % Aplicación de filtros de paso de banda para cada banda de frecuencia
  [b, a] = butter(5, ([fGamma1, fGamma2] / (fm / 2)), 'bandpass');
  Gamma = (1 / (fm * N)) * abs(filter(b, a, X)).^2;
   %plot(f,Gamma)
  [b, a] = butter(5, ([fHAlpha1, fHAlpha2] / (fm / 2)), 'bandpass');
  HAlpha = (1 / (fm * N)) * abs(filter(b, a, X)).^2;

  [b, a] = butter(5, ([fBeta1, fBeta2] / (fm / 2)), 'bandpass');
  Beta = (1 / (fm * N)) * abs(filter(b, a, X)).^2;

  [b, a] = butter(5, ([fHBeta1, fHBeta2] / (fm / 2)), 'bandpass');
  HBeta = (1 / (fm * N)) * abs(filter(b, a, X)).^2;

  [b, a] = butter(5, ([fTotal1, fTotal2] / (fm / 2)), 'bandpass');
  Total = (1 / (fm * N)) * abs(filter(b, a, X)).^2;

  % Cálculo de las características y almacenamiento en la matriz 'caract'
  caract(5) = mean(Gamma);
  caract(2) = std(HAlpha);
  caract(3) = mean(Beta);
  caract(4) = max(HBeta);
  caract(1) = mean(Total);

endfunction

