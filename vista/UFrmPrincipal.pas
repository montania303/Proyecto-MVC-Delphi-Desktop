unit UFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFrmPrincipal = class(TForm)
    btnCliente: TButton;
    procedure btnClienteClick(Sender: TObject);
  private
    procedure abrirPantallaCliente();
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  UFrmRegistroCliente;

{$R *.dfm}

procedure TFrmPrincipal.abrirPantallaCliente;
var FrmRegistrarCliente : TFrmRegistroCliente;
begin
 FrmRegistrarCliente := TFrmRegistroCliente.Create(nil);
 try
   FrmRegistrarCliente.ShowModal;
 finally
   FreeAndNil(FrmRegistrarCliente);
 end;
end;

procedure TFrmPrincipal.btnClienteClick(Sender: TObject);
begin
 abrirPantallaCliente;
end;

end.
