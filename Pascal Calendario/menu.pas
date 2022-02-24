unit menu;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, gestorDeTareas, registroDeTareas, dateUtils;

const
  ARR = 1; {constante para ajustes de arreglo}

type
  OPC = 1..6;
  DIA = 1..31;
  MES = 1..12;
  ANIO = 2019..2109;
  HORA = 1..23;
  MIN = 0..59;
  TFecha = array [1..5] of integer;
  tareas = array of Pendiente; {arreglo de pendientes}

 //definicion de procedimientos y funciones publicos
Procedure nuevoMenu (var agenda : tareas);
Procedure verAgenda (var agenda : tareas);
Procedure seleccionarOpcion(var agenda : tareas);
Procedure agregarPendiente(var agenda : tareas);
Procedure ingFechaHora (var datos : TFecha);
procedure getDia (var numero : dia);
procedure getMes (var numero : mes);
procedure getAnio (var numero : anio);
procedure getHora (var numero : hora);
procedure getMin (var numero : min);
Procedure eliminarPendiente(var agenda : tareas);
Procedure marcarCompletado(var agenda : tareas);
Procedure generarResumen(var agenda : tareas);
Procedure ayuda (var agenda : tareas);
procedure salir (var agenda : tareas);

implementation

Procedure nuevoMenu (var agenda : tareas);
begin
  writeln ('Bienvenido a su agenda!');
  verAgenda(agenda);
  writeln ('Que desea hacer?');
  writeln ('1 - Agregar Pendiente');
  writeln ('2 - Eliminar Pendiente');
  writeln ('3 - Marcar Tarea como completada');
  writeln ('4 - Generar archivo de tareas');
  writeln ('5 - Ayuda');
  writeln ('6 - Salir');
  writeln ('Elija una opcion: ');
  seleccionarOpcion(agenda);
end;

Procedure verAgenda (var agenda : tareas);
var
  lon, i : integer;
begin
  lon := length(agenda);
  lon := lon -ARR;
  write (' ');
  writeln ('Estas son las tareas en la agenda');
  for i:= 0 to lon do
  begin
    write (inttostr(i+ARR) + '- ');
    writeln(agenda[i].nombre + '---' + agenda[i].fechaHora + '---' + agenda[i].obs + '---' + agenda[i].completado);
  end;
  write (' ');
end;

Procedure seleccionarOpcion(var agenda : tareas);
var
  opcion : OPC;
begin
  try
  read(opcion);
  except
    begin
    writeln ('Porfavor introduzca una opcion valida: ');
    seleccionarOpcion(agenda);
    end;
  end;
  case opcion of
    1 : agregarPendiente(agenda);
    2 : eliminarPendiente(agenda);
    3 : marcarCompletado(agenda);
    4 : generarResumen (agenda);
    5 : ayuda (agenda);
    6 : salir (agenda);
  end;
end;

Procedure agregarPendiente(var agenda : tareas);
var
  tarea : pendiente;
  lon : integer;
  n, nomb, o, obs : String; {nombre, observacion}
  f : array [1..5] of integer; {fecha}
begin
  writeln ('Ingrese un nombre para la tarea: ');
  readln(n);
  readln(n);
  Writeln ('Ingrese alguna observacion: ');
  readln(o);
  ingFechaHora(f);
  tarea := agregarTarea(n,f[1],f[2],f[3],f[4],f[5],o);
  lon := length(agenda)+1;
  agenda[lon-1]:= tarea;
  registrar(agenda);
  writeln('Tarea ingresada con exito!');
  writeln('');
  nuevoMenu(agenda);
end;

Procedure ingFechaHora (var datos : TFecha);
var
  f : TFecha;
  d : DIA;
  m : MES;
  a : ANIO;
  hh : HORA;
  nn : MIN;
  SFecha: String;
  fecha : TDateTime;
begin
  Writeln ('Ingrese dia, mes y año DD/MM/AAAA');
  writeln ('Dia: ');
  getDia(d);
  writeln ('Mes: ');
  getMes(m);
  writeln ('Año: ');
  getAnio(a);
  writeln ('Hora: ');
  getHora(hh);
  writeln ('Minuto: ');
  getMin(nn);
  SFecha := (IntToStr(d)+'/'+IntToStr(m)+'/'+IntToStr(a)+' '+IntToStr(hh)+':'+IntToStr(nn)+':00');
  try
    fecha := StrToDateTime(SFecha);
  except
    begin
    writeln('Esa fecha/hora no es valida');
    ingFechaHora(datos);
    end;
  end;
  f[1] := d;
  f[2] := m;
  f[3] := a;
  f[4] := hh;
  f[5] := nn;
  datos := f;
end;

procedure getDia (var numero : dia);
begin
  try
    read (numero);
  except
    begin
    writeln ('Porfavor igrese un numero valido: ');
    getDia(numero);
    end;
  end;
end;

procedure getMes (var numero : mes);
begin
  try
    read (numero);
  except
    begin
    writeln ('Porfavor igrese un numero valido: ');
    getMes(numero);
    end;
  end;
end;

procedure getAnio(var numero : anio);
begin
  try
    read (numero);
  except
    begin
    writeln ('Porfavor igrese un numero valido: ');
    getAnio(numero);
    end;
  end;
end;

procedure getHora (var numero : hora);
begin
  try
    read (numero);
  except
    begin
    writeln ('Porfavor igrese un numero valido: ');
    getHora(numero);
    end;
  end;
end;

procedure getMin (var numero : min);
begin
  try
    read (numero);
  except
    begin
    writeln ('Porfavor igrese un numero valido: ');
    getMin(numero);
    end;
  end;
end;

Procedure eliminarPendiente(var agenda : tareas);
var
  index, i, lon : integer;
begin
  writeln ('Ingrese el numero del elemento que desea borrar: ');
  read (i);
  lon := length(agenda);
  if ((i <= 0) or (i > lon)) then
  begin
    repeat
      write ('Ese numero no es valido: ');
      read (i);
    until ((i > 0) and (i <= lon))
  end;
  i:= i-1;
  for index := i+1 to lon-1 do
  begin
    agenda[i-1] := agenda [i];
  end;
  setLength(agenda, lon-1);
  writeln('Tarea eliminada con exito!');
  writeln('');
  registrar(agenda);
  nuevoMenu(agenda);
end;

Procedure marcarCompletado(var agenda : tareas);
var
  i, lon : integer;
  o : char;
begin

  writeln ('Ingrese el numero del elemento que desea marcar: ');
  read (i);
  lon := length(agenda);
  if ((i <= 0) or (i > lon)) then
  begin
    repeat
      write ('Ese numero no es valido: ');
      read (i);
    until ((i > 0) and (i <= lon))
  end;
  i:= i-1;
  marcarTareaCompletado(agenda[i]);
  writeln('');
  registrar(agenda);
  nuevoMenu(agenda);
end;

Procedure generarResumen(var agenda : tareas);
var
  f1, f2 : array [1..5] of integer; {Fechas}
  f3, f4, f5, f6 : TDateTime;      {Fechas para comparacion}
  nombreArchivo, f7, f8 : String;
  Ttareas : tareas;
  lon, lastIndex, i, j, cmp1, cmp2: integer;
begin
  lon := 0;
  lastIndex := length(agenda)-1;
  writeln ('Ingrese dos fechas vaidas: ');
  ingFechaHora (f1);
  ingFechaHora (f2);
  f7 := concat(inttostr(f1[1]) , '/' , inttostr(f1[2]) , '/' , inttostr(f1[3]) , ' ' , inttostr(f1[4]) , ':' , inttostr(f1[5]), ':00');
  f8 := concat(inttostr(f2[1]) , '/' , inttostr(f2[2]) , '/' , inttostr(f2[3]) , ' ' , inttostr(f2[4]) , ':' , inttostr(f2[5]), ':00');
  f4 := StrToDateTime(f7);
  f5 := StrToDateTime(f8);
  cmp1 := compareDateTime(f4,f5);
  if (cmp1 >= 0 ) then
  begin
    f6 := f4;
    f4 := f5;
    f5 := f6;
  end;
  for i:= 0 to lastIndex do
  begin
       f3 := getFecha(agenda[i]);
       cmp1 := compareDateTime(f3, f4);
       cmp2 := compareDateTime(f3, f5);
       if (cmp1 >= 0) and (cmp2 <= 0) then
       begin
         lon := lon +ARR;
         setLength(ttareas,lon);
         ttareas[lon-ARR] := agenda[i]
       end;
  end;
  writeln ('Ingrese el nombre del archivo a generar: ');
  read (nombreArchivo);
  read (nombreArchivo);
  for j:= 0 to (length(nombreArchivo)-1) do
  if (nombreArchivo[i] = ' ') then nombreArchivo[i] := '_';
  nombreArchivo:=(nombreArchivo+'.txt');
  generarArchivo (ttareas, nombreArchivo, f4, f5);
  writeln ('Archivo Generado con exito!');
  writeln (' ');
  nuevoMenu(agenda);


end;

Procedure ayuda (var agenda : tareas);
begin
  writeln ('1- Para agregar un pendiente a la agenda');
  writeln ('2- Para eliminar un pendiente de la agenda');
  writeln ('3- Para marcar una tarea, de entre las que se encuentran en la agenda, como completada');
  writeln ('4- Para generar un archivo .txt de las tareas que tiene pendientes entre dos fechas');
  writeln ('5- Ayuda');
  writeln ('6- Para salir del programa ');
  writeln ('Elija una opcion: ');
  seleccionarOpcion(agenda);
end;

procedure salir (var agenda : tareas);
var
  s : char;
begin
  writeln ('Esta seguro de que desea salir? s/n: ' );
  readln (s);
  if ((s = 's') or (s = 'S')) then
  begin
    halt(0)
  end
  else if ((s = 'n') or (s = 'N')) then
  begin
    nuevoMenu (agenda);
  end
  else
  begin
        writeln ('Porfavor igrese una opcion valida: ');
        salir (agenda);
  end;
end;

begin
end.

