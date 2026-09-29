program BasicORM;

uses
  Vcl.Forms,
  model.teste in 'test\model.teste.pas',
  attributes in 'class\attributes.pas',
  Interfaces.base in 'interface\Interfaces.base.pas',
  daouib in 'class\daouib.pas',
  U_Test in 'test\U_Test.pas' {F_Test};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TF_Test, F_Test);
  Application.Run;
end.
