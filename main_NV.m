 pkg load statistics;
 X_train = zeros(120,37);
 X_train = cargar_en_matriz_caracterisitcas();
 X_train(1:60,37) = 1;
 X_train(61:end,37) = 0;
  a = [0;1;0.5;2];
  classification=zeros(15,1);
  errorRate=zeros(size(a,1),1);
  for i = 1:15
    % Cargar datos de prueba                                                                                                     #lying
    filename = sprintf('C:\\Ingenieria Informatica\\4to año\\Proc de Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion2\\honest\\honest_subject%d_session2_probe.txt', i);
    filename1 = sprintf('C:\\Ingenieria Informatica\\4to año\\Proc de Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion2\\lying\\lying_subject%d_session2_probe.txt', i);
    data = load(filename);
    data1 = load(filename1);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract1 = extraer_caractersiticas_NB(data1, fm, 3);
    caract_vector = caract(:);
    X_test = caract_vector';
    caract_vector1 = caract1(:);
    X_test1 = caract_vector1';
      for k=1 :4
      [classification(:,i),errorRate(k,i)]=myBayesClassifier(X_train,X_test,a(k));
       endfor
 endfor
 classification


