program Act_Hora;

uses
  Forms,
  UAct_Hora in 'UAct_Hora.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Actualizar Fecha y Hora';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
