program MVC;

uses
  Vcl.Forms,
  UFrmPrincipal in 'vista\UFrmPrincipal.pas' {FrmPrincipal} ,
  UFrmRegistroCliente in 'vista\UFrmRegistroCliente.pas' {FrmRegistroCliente} ,
  UClienteModel in 'modelo\UClienteModel.pas',
  UClienteController in 'controller\UClienteController.pas',
  UDMConexion in 'dao\UDMConexion.pas' {DMConexion: TDataModule} ,
  UDMCliente in 'dao\UDMCliente.pas' {DMCliente: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDMConexion, DMConexion);
  Application.Run;

end.
