unit gestorDeTareas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils;

type
  Pendiente =  {tipo para almacenar pendientes/tareas/cosas de la agenda}
    Record
      nombre, fechaHora, obs, completado : String;
    end;

//definicion de funciones y procedimientos publicos
function agregarTarea (nombreTarea : String; anio : integer; mes : integer; dia : integer; hora: integer; minuto : integer; obsTarea:String) : pendiente;
procedure marcarTareaCompletado (var tarea : Pendiente);
function getFecha (tarea : Pendiente) : TDateTime;
function isCompletado (tarea : pendiente) : boolean;

implementation

{Funcion para generar una nueva tarea}
function agregarTarea (nombreTarea : String; anio : integer; mes : integer; dia : integer; hora: integer; minuto : integer; obsTarea:String) : pendiente;
var
   tarea : Pendiente;
   fechaH : String;
begin
   tarea.nombre := nombreTarea;
   fechaH := concat(inttostr(dia) , '/' , inttostr(mes) , '/' , inttostr(anio) , ' ' , inttostr(hora) , ':' , inttostr(minuto), ':00');
   tarea.fechaHora := fechaH;
   tarea.obs := obsTarea;
   tarea.completado := 'No completada';
   agregarTarea := tarea;
end;

{procedimiento para marcar pendiente como completado}
procedure marcarTareaCompletado (var tarea : Pendiente);
begin
   tarea.completado := 'Tarea Completada';
end;

{funcion para verificar si un pendiente esta completado}
function isCompletado (tarea : pendiente) : boolean;
var
   s: String;
begin
   s := tarea.completado;
   isCompletado := false;
   if (s = 'Tarea Completada') then isCompletado := true
   else if (s = 'No completada') then isCompletado := false;
end;

{funcion para obtener la fecha en formato TDateTime, que se utiliza luego para ordenar}
function getFecha (tarea : pendiente) : TDateTime;
var
   TFecha : TDateTime;
   fmt : TFormatSettings;
begin
   fmt.ShortDateFormat:='dd/mm/yyyy';
   fmt.DateSeparator  :='/';
   fmt.LongTimeFormat :='hh:nn:ss';
   fmt.TimeSeparator  :=':';
   TFecha := StrToDateTime(tarea.fechaHora,fmt);
   getfecha := TFecha;
end;

begin
end.

