function m = main_KNN()
  pkg load statistics;

  % Cargar los datos de entrenamiento
  X_train = cargar_en_matriz_caracterisitcas();
  Y_train = zeros(1, 120);  % Vector de etiquetas de longitud 120 lleno de ceros
  Y_train(1:60) = 1;
  Y_train(61:end) = 0;
  sumav=0;

  k = 1;

  for i = 1:15
    % Cargar datos de prueba
    filename = sprintf('C:\\Users\\pablo\\Desktop\\Trabajo Señales\\TpFinal\\Base de Datos EEG\\Pruebas\\solo_sesion1\\lying\\lying_subject%d_session1_probe.txt', i);
    data = load(filename);
    fm = 500;  % Frecuencia de muestreo
    caract = extraer_caractersiticas_NB(data, fm, 3);
    caract_vector = caract(:);
    X_test = caract_vector';



    % Implementación manual de KNN
    y_pred = knn_predict(X_train, Y_train, X_test, k);
    if(y_pred == 0)
      disp('KNN : MENTIRA');
       sumav++;
    else

      disp('KNN : VERDAD');
    endif
  endfor

  m = (sumav/15)*100

endfunction



