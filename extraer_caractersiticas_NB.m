function caract = extraer_caractersiticas_NB(x,fm,n)
  pkg load signal;
  X = fft(x); #Saco la transformada de x
  N = length(X); #Obtengo cantidad de muestras
  deltaf = fm/N;
  f = 0 : deltaf : fm-deltaf;
##  figure(n)
##  plot(f,X);
  Gamma = zeros(1,N);
  Theta = zeros(1,N);
  Alpha = zeros(1,N);
  LAlpha = zeros(1,N);
  HAlpha = zeros(1,N);
  Beta = zeros(1,N);
  Lbeta = zeros(1,N);
  HBeta = zeros(1,N);
  Total = zeros(1,N);
  fGamma1 = 25;
  fGamma2 = 40;
  theta1=4;
  theta2=7;
  alpha1=8;
  alpha2=13;
  Lalpha1=8;
  Lalpha2=10;
  fHAlpha1 = 10;
  fHAlpha2 = 12;
  fBeta1 = 14;
  fBeta2 = 30;
  Lbeta1=14;
  Lbeta2=25;
  fHBeta1 = 25;
  fHBeta2 = 35;
  fTotal1 = 4;
  fTotal2 = 35;
  X_pds = (1/(fm*N) * abs(X).^2); #Calculo de densidad espectral de potensia de la fft de x

  [b,a] = butter(5,([fGamma1, fGamma2] / (fm/2)), 'bandpass');
  Gamma = filter(b,a,X_pds);
  [b,a] = butter(5,([theta1, theta2] / (fm/2)), 'bandpass');
  Theta = filter(b,a,X_pds);
  [b,a] = butter(5,([alpha1, alpha2] / (fm/2)), 'bandpass');
  Alpha = filter(b,a,X_pds);
  [b,a] = butter(5,([Lalpha1, Lalpha2] / (fm/2)), 'bandpass');
  LAlpha = filter(b,a,X_pds);
  [b,a] = butter(5,([fHAlpha1, fHAlpha2] / (fm/2)), 'bandpass');
  HAlpha = filter(b,a,X_pds);
  [b,a] = butter(5,([fBeta1, fBeta2] / (fm/2)), 'bandpass');
  Beta = filter(b,a,X_pds);
  [b,a] = butter(5,([fHBeta1, fHBeta2] / (fm/2)), 'bandpass');
  HBeta = filter(b,a,X_pds);
  [b,a] = butter(5,([Lbeta1, Lbeta2] / (fm/2)), 'bandpass');
  Lbeta = filter(b,a,X_pds);
  [b,a] = butter(5,([fTotal1, fTotal2] / (fm/2)), 'bandpass');
  Total = filter(b,a,X_pds);

 % Crear una matriz para almacenar las estadísticas
  caract = zeros(9, 4);

  % Definir una función auxiliar para calcular las estadísticas
  function stats = calculate_stats(vector)
      stats = [min(vector), max(vector), mean(vector), std(vector)];
  end

    % Calcular las estadísticas y almacenarlas en la matriz
  caract(1, :) = calculate_stats(Gamma);
  caract(2, :) = calculate_stats(Theta);
  caract(3, :) = calculate_stats(Alpha);
  caract(4, :) = calculate_stats(LAlpha);
  caract(5, :) = calculate_stats(HAlpha);
  caract(6, :) = calculate_stats(Beta);
  caract(7, :) = calculate_stats(Lbeta);
  caract(8, :) = calculate_stats(HBeta);
  caract(9, :) = calculate_stats(Total);

  endfunction
