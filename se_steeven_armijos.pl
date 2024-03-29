programa:-proyecto_se,repeat, abolish(si_no/2),
    dynamic(si_no/2),
    diagnosticomedico,nl,nl,
    write('�Desea volver a intentarlo? (s/n)'),read(Respuesta),\+ Respuesta=s,nl,
    abolish(si_no,2).

%Encabezado para el programa donde se muestra el t�tulo del SE
proyecto_se:-nl,nl,
write('Sistema Experto para ayudar a determinar qu� enfermedad pone en riesgo de terminar en quir�fano a un paciente seg�n sus s�ntomas.'),nl,
write('_________________________________________________________________________________________________________________________________'),nl.

%Seg�n la bibliograf�a estos son los s�ntomas que determinan a qu� enfermedad de puede derivar
sintoma_principal_calculo_renal:-sintoma('�Tiene dolor fuerte que se origina a la altura del ri��n o de las v�as urinarias?'),!.
sintoma_principal_calculo_biliar:-sintoma('�Tiene dolor intenso que se localiza en la parte superior derecha y media del abdomen?'),!.
sintoma_principal_apendicitis:- sintoma('�Siente un dolor repentino que se desplaza hacia la parte inferior derecha del abdomen?'),!.

%Con esta regla se identifica si el paciente puede tener o no c�lculos renales.
enfermedad(calculos_renales):-
   sintoma_principal_calculo_renal,
   sintoma('�Tiene sensaci�n de una necesidad intensa de orinar?'),
   sintoma('�Tiene n�useas y v�mitos?'),
   sintoma('�Tiene fiebre'),
   (sintoma('�Su orina es de color rosa, rojo o marr�n?'); sintoma('�Su orina tiene un olor desagradable?')),
   (sintoma('Cuando va a orinar �orina en peque�as cantidades?');sintoma('�Siente sensaci�n de quemaz�n al orinar?')).

%Con esta regla se identifica si el paciente puede tener o no c�lculos biliares.
enfermedad(calculos_biliares):-
   sintoma_principal_calculo_biliar,
   sintoma('�Siente dolor de espalda justo entre las esc�pulas (om�platos)?'),
   sintoma('�Siente dolor en el hombro derecho?'),
   sintoma('�Tiene n�useas y v�mitos?'),
   sintoma('�Tiene color amarillento en la piel o en el blanco de los ojos?'),
   sintoma('�Tiene fiebre?'),
   sintoma('�Orina de color de t� y sus heces son de color claro?').

%Con esta regla se identifica si el paciente puede tener o no apendicitis.
enfermedad(apendicitis):-
   sintoma_principal_apendicitis,
   sintoma('�El dolor empeora cuando realiza movimientos bruscos?'),
   sintoma('�Siente p�rdida de apetito?'),

   (sintoma('�Tiene n�useas y v�mitos?');sintoma('�Tiene estre�imiento o diarrea?')),
   (sintoma('�Tiene fiebre?');sintoma('�Siente hinchaz�n abdominal?')).

% Con esta regla simplemente obtengo las respuestas a las preguntas de
% forma din�mica con la ayuda de dynamic que se define en la regla
% principal
sintoma(Sintoma):-nl,write(Sintoma ),nl,write(' (s/n)'),
                  nl, read(Respuesta),
                  ((Respuesta=s, assert(si_no(Sintoma, true)));
                  (assert(si_no(Sintoma, false)),fail)).

% Esta regla es la que se llama al iniciar el programa, en caso de no
% obtener un resultado positivo se pasa a la siguiente regla con el
% mismo nombre: diagnosticomedico
diagnosticomedico:-write(''),nl,
                   enfermedad(Enfermedad),!,nl,
                   write('||||||||||||||||CUADRO CL�NICO||||||||||||||||'),nl,nl,
                   write('Seg�n sus s�ntomas, es muy probable que Ud., corra el riesgo de terminar en el quir�fano por: '),nl,nl,
                   write('                  '), write(Enfermedad),nl,nl,
                   write('||||||||||||||||||||||||||||||||||||||||||||||').

diagnosticomedico:-nl,write('||||||||||||||||CUADRO CL�NICO||||||||||||||||'),nl,nl,
                   write('Los s�ntomas que presenta, puede que se deba a otra enfermedad distinta'),nl,nl,
                   write('||||||||||||||||||||||||||||||||||||||||||||||').

