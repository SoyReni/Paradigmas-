program Padron;

{Libreria contacto}
uses
  gestorDePadron, gestorDeVotos, crt;

var
  criterio : String;
  datos : Array [1..4] of String;

begin
        WriteLn('Bienvenidos al padron...');
        WriteLn;
  repeat
        begin
        WriteLn('Ingrese el Numero de cedula a buscar:');

        ReadLn(criterio);
        WriteLn;

        datos := BuscarPadron(criterio);

        WriteLn(dondeVota(datos));
        end;
  until (criterio = '');

end.
