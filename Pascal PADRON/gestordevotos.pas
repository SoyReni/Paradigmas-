unit gestorDeVotos;

{$mode objfpc}{$H+}

interface

const
     RegistroFile = 'registro.txt';

type
    Salida = String;

//Definicion de los procedimientos/functiones publicas
function dondeVota (quien : array of String) : Salida;
procedure escribir (mensaje : string);

implementation

uses
  Classes, SysUtils, crt, gestorDePadron;

function dondeVota (quien : array of String) : String;

var
aux : String;
num, error : Integer;
centro, uni, tecnico, no, noEncontrado, cedula, caso1, caso2, caso3, caso4: String;
mensaje : String;

begin
     cedula := (quien [1]+ ' de edad ' + quien [2] + ' y con numero de cedula ' + quien [0]);
     centro := ' vota en el Centro Regional de Encarnacion.';
     uni := ' vota en la Universidad Nacional de Itapua.';
     tecnico := ' vota en el Colegio Tecnico Nacional.';
     no := ' es menor de edad y no vota.';
     noEncontrado := 'No se ha encontrado el numero ';
     caso1:= (cedula + no);
     caso2:= (cedula + centro);
     caso3:= (cedula + tecnico);
     caso4:= (cedula + uni);

     aux:= quien[2];
     val(aux, num, error);

     if (num < 16) then
        begin
        mensaje :=  caso1;
        end;
     if (num < 51) then
        begin
            if (quien[4] = 'M') then
                begin
                mensaje := caso2;
                end;
            if (quien[4] = 'F') then
                begin
                mensaje := caso3
                end;
        end;
     if (num < 71) then
         begin
             mensaje := caso4;
         end;
     if (num > 70) then
         begin
             mensaje := caso2;
         end;
     if (quien[1] = '') then mensaje := noEncontrado;


     escribir (mensaje);
     dondeVota := mensaje;
end;

procedure escribir (mensaje : string);
var
   fichero : text;

begin
     assign (fichero, RegistroFile);
     append (fichero);
     writeln (fichero, mensaje);
     close (fichero);
end;

begin
end.

