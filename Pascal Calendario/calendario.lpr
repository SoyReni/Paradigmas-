program calendario;

{$mode objfpc}{$H+} {$WARN 5057 OFF}

uses
  Sysutils,
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, gestorDeTareas, registrodetareas, menu;

var
  tareaNueva, tareaOtro : pendiente;
  agenda : array of pendiente;
  fech : TDateTime;
  testo : string;
begin
  agenda := extraer();
  nuevoMenu(agenda);
  {setLength (agenda, 2);
  agenda := extraer();
  writeln(getFecha(agenda[0]));
  ordenar (agenda);
  registrar (agenda);
  agenda := extraer();
  writeln (agenda[1].nombre);
  fech := StrToDateTime(agenda[1].fechaHora);
  writeln (fech);
  writeln (DateTimeToStr(fech));
  readln (testo); }
end.

