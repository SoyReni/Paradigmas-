unit registroDeTareas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, crt, gestorDeTareas, DateUtils, variants, StrUtils;

const
  registro = 'registro.txt'; {archivo de registro de datos}
  tam      = 4;              {cantidad de datos por pendiente}

type
  tareas = array of Pendiente; {arreglo de pendientes}
  tParts = array [1..tam] of string; {arreglo para extraer pendientes de un archivo}

//funciones y procedimientos publicos
procedure registrar (L : tareas);
function extraer () : tareas;
procedure ordenar (var agenda : tareas);
procedure generarArchivo (L : tareas; t : String; f1 : TDateTime; f2 : TDateTime);

implementation

{procedimiento para registrar pendientes de un arreglo en un archivo}
procedure registrar (L : tareas);
var
   fichero : text;
   longitud, contador : integer;
   otro : pendiente;
   reg  : String;
begin
   ordenar (l);
   longitud := length(l)-1;
   assign (fichero, registro);
   rewrite (fichero);
   close (fichero);
   for contador:= 0 to longitud do
   begin
     otro := l[contador];
     reg := (otro.nombre + '*' + otro.fechahora + '*' + otro.obs + '*' + otro.completado);
     assign (fichero, registro);
     append (fichero);
     writeln (fichero, reg);
     close (fichero)
   end;
end;

procedure generarArchivo (L : tareas; t : String; f1 : TDateTime; f2 : TDateTime);
var
   fichero : text;
   longitud, contador : integer;
   otro : pendiente;
   reg  : String;
begin
   ordenar (l);
   longitud := length(l)-1;
   assign (fichero, t);
   rewrite (fichero);
   close (fichero);
   reg := ('Estas son las tareas que tiene desde ' + DateTimeToStr(f1) + ' hasta ' + DateTimeToStr(f2));
   assign (fichero, t);
   append (fichero);
   writeln (fichero, reg);
   close (fichero);
   for contador:= 0 to longitud do
   begin
     otro := l[contador];
     reg := (otro.nombre + '---' + otro.fechahora + '--- Observaciones:' + otro.obs);
     assign (fichero, t);
     append (fichero);
     writeln (fichero, reg);
     close (fichero)
   end;
end;

{funcion para separar un string con un separador, proveido por el profesor Tapia}
function splitString (cadena : String; separador : Char) : tParts;
var
   linea : tParts;
   i, j : integer;
   word : string;
begin
   word := '';
   j := 1;
   for i := 1 to length (cadena) do
   begin
     if cadena [i] <> separador then
     begin
     word := word + cadena[i];
     end
     else
     begin
        linea[j] := word;
        word := '';
        inc (j);
     end
   end;
   linea[j] := word;
   splitString := linea;
end;

{funcion para extraer pendientes de un archivo a un arreglo}
function extraer () : tareas;
var
   L : tareas;
   fichero : text;
   longitud, contador, j : integer;
   uno : pendiente;
   linea: String;
   dato : Array [1 .. tam] of String;
begin
   contador := 0;
   j := 0;
   assign (fichero, registro);
   reset (fichero);
   {primero cuenta la cantidad de pendientes para definir el tamaño del arreglo}
   while not eof (fichero) do
   begin
     readln (fichero, linea);
     contador := (contador +1);
   end;
   setLength (l, contador);   {define el tamaño del arreglo}
   close (fichero);

   assign (fichero, registro); {recorre el archivo y convierte cada linea en un pendiente}
   reset (fichero);
   while not eof (fichero) do
   begin
     readln (fichero, linea);
     dato := splitString(linea, '*');
     uno.nombre:= dato[1];
     uno.fechaHora:= dato[2];
     uno.obs:=dato[3];
     uno.completado:=dato[4];
     l[j] := uno;             {se asigna el pendiente en una posicion del arreglo}
     j := j+1;                {la posicion del arreglo ba aumentando}
   end;
   {ultima linea del registro}
   readln (fichero, linea);
   dato := splitString(linea, '*');
   uno.nombre:= dato[1];
   uno.fechaHora:= dato[2];
   uno.obs:=dato[3];
   uno.completado:=dato[4];
   close (fichero);
   ordenar(l);
   extraer := l;

end;

{funcion para ordenar por fecha y hora los pendientes en un archivo
 selection sort: se compara la fecha de una posicion con todas las posteriores
 las fechas que son anteriores se van intercambiando en esa posicion hasta que
 queda la menor fehca en la posicion correspondiente, luego se realiza el mismo
 procedimiento con las posiciones posteriores hasta la ultima}
procedure ordenar (var agenda : tareas);
var
   i,j, lon, cmp : integer;
   cambio : pendiente; {variable para intercambiar valores}
   fecha1, fecha2 : TDateTime;
begin
   lon := length (agenda);
   lon := lon-1;
   if (lon>= 1) then {si hay un solo elemento en el arreglo, ya esta ordenado}
   begin
   for i:= 0 to lon-1 do
     for j := i+1 to lon do
       begin
         fecha1 := getFecha(agenda[i]);
         fecha2 := getFecha(agenda[j]);
         cmp := CompareDateTime(fecha1, fecha2);
         if (cmp >= 0) then begin
           cambio := agenda[i];
           agenda[i] := agenda [j];
           agenda[j] := cambio;
         end;
       end;
   end;
end;

begin
end.

