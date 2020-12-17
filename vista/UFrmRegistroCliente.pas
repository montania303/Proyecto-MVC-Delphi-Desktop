unit UFrmRegistroCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, UClienteController, UClienteModel,
  Datasnap.DBClient;

type
  Toperacion = (opNuevo, opActualizar, opNavegar);

type
  TFrmRegistroCliente = class(TForm)
    pnlPie: TPanel;
    btnCerrar: TButton;
    pgcPrincipal: TPageControl;
    TbBuscar: TTabSheet;
    TbDatos: TTabSheet;
    pnlFiltro: TPanel;
    TxtBuscar: TLabeledEdit;
    btnBuscar: TButton;
    pnlBtnBuscar: TPanel;
    btnNuevo: TButton;
    btnDetallar: TButton;
    btnEliminar: TButton;
    DBGrid1: TDBGrid;
    DsBuscar: TDataSource;
    txtId: TLabeledEdit;
    txtNombre: TLabeledEdit;
    txtTelefono: TLabeledEdit;
    pnlbtnReg: TPanel;
    btnCancelar: TButton;
    btnGrabar: TButton;
    btnActualizar: TButton;
    btnListar: TButton;
    TxtNacimiento: TLabeledEdit;
    TxtEdad: TLabeledEdit;
    TxtPais: TLabeledEdit;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCerrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnDetallarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnActualizarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FOperacion: Toperacion;
    var Fclientecontroller: TclienteController;
    procedure Nuevo;
    procedure Detallar;
    procedure Configuracion;
    procedure buscarCliente;
    procedure cargarCliente;
    procedure listarCliente;
    procedure ActualizarCliente;
    procedure EliminarCliente;
    procedure InsertarCliente;
    procedure GrabarCliente;
    procedure HabilitarBotones(aOPeracion: Toperacion);
  public

  end;

var
  FrmRegistroCliente: TFrmRegistroCliente;

implementation

uses
  UDMCliente;

{$R *.dfm}

procedure TFrmRegistroCliente.ActualizarCliente;
var
  ocliente: TCliente;
  oclientecontroller: TclienteController;
  sError: string;
begin
  ocliente := TCliente.Create;
  oclientecontroller := TclienteController.Create;
  try
    with ocliente do
    begin
      nombre           := txtNombre.Text;
      fecha_nacimiento := StrToDate(TxtNacimiento.Text);
      edad             := StrToIntDef(TxtEdad.Text, 0);
      pais             := TxtPais.Text;
      Telefono         := txtTelefono.Text;
      Id               := StrToIntDef(txtId.Text, 0);
      if oclientecontroller.ActualizarCliente(ocliente, sError) then
        raise Exception.Create(sError);
    end;
  finally
    FreeAndNil(ocliente);
    FreeAndNil(oclientecontroller);
  end;

end;

procedure TFrmRegistroCliente.btnActualizarClick(Sender: TObject);
begin
 FOperacion := opActualizar;
 HabilitarBotones(opActualizar);
end;

procedure TFrmRegistroCliente.btnBuscarClick(Sender: TObject);
begin
  buscarCliente;
end;

procedure TFrmRegistroCliente.btnCancelarClick(Sender: TObject);
begin
 HabilitarBotones(opNavegar);
end;

procedure TFrmRegistroCliente.btnCerrarClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmRegistroCliente.btnDetallarClick(Sender: TObject);
begin
Detallar;
end;

procedure TFrmRegistroCliente.btnEliminarClick(Sender: TObject);
begin
  EliminarCliente();
end;

procedure TFrmRegistroCliente.btnGrabarClick(Sender: TObject);
begin
 GrabarCliente;
 HabilitarBotones(opNavegar);
end;

procedure TFrmRegistroCliente.btnListarClick(Sender: TObject);
begin
  listarCliente;
end;

procedure TFrmRegistroCliente.btnNuevoClick(Sender: TObject);
begin
 Nuevo();
 HabilitarBotones(opNuevo);
end;

procedure TFrmRegistroCliente.buscarCliente;
begin
 Fclientecontroller.buscarCliente(TxtBuscar.Text);
end;

procedure TFrmRegistroCliente.cargarCliente;
var
  ocliente: TCliente;
  oclientecontroller: TclienteController;
begin
  ocliente := TCliente.Create;
  oclientecontroller := TclienteController.Create;
  try
    oclientecontroller.cargarCliente(ocliente,
      DsBuscar.DataSet.FieldByName('id').AsInteger);
    with ocliente do
    begin
      txtId.Text := IntToStr(Id);
      txtNombre.Text := nombre;
      TxtNacimiento.Text := DateToStr(fecha_nacimiento);
      TxtEdad.Text := IntToStr(edad);
      TxtPais.Text := pais;
      txtTelefono.Text := Telefono;
    end;
  finally
    FreeAndNil(oclientecontroller);

  end;

end;

procedure TFrmRegistroCliente.Configuracion;
begin
  TbBuscar.TabVisible := False;
  TbDatos.TabVisible := False;
  pgcPrincipal.ActivePage := TbBuscar;
end;

procedure TFrmRegistroCliente.DBGrid1DblClick(Sender: TObject);
begin
  Detallar;
end;

procedure TFrmRegistroCliente.Detallar;
begin
  cargarCliente;
  HabilitarBotones(opNavegar);
  FOperacion := opNavegar;
  pgcPrincipal.ActivePage := TbDatos;
end;

procedure TFrmRegistroCliente.EliminarCliente;
var
  oclientecontroller: TclienteController;
  sError: string;
begin
  oclientecontroller := TclienteController.Create;
  try
    if (DMCliente.CDSBuscar.Active) and (DMCliente.CDSBuscar.RecordCount > 0)
    then
    begin
      if MessageDlg('Legal pio queres borrar?', mtConfirmation, [mbYes, mbNo],
        0) = IDYES then
      begin
        if oclientecontroller.EliminarCliente(DMCliente.CDSBuscarID.AsInteger,
          sError) = False then
          raise Exception.Create(sError);
        oclientecontroller.buscarCliente(TxtBuscar.Text);
      end;
    end
    else
      raise Exception.Create('No hay nada para borrar amigo!!');
  finally
    FreeAndNil(oclientecontroller);
  end;

end;

procedure TFrmRegistroCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(Fclientecontroller);
end;

procedure TFrmRegistroCliente.FormCreate(Sender: TObject);
begin
 DMCliente := TDMCliente.Create(nil);
 Fclientecontroller := TclienteController.Create;
end;

procedure TFrmRegistroCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(DMCliente);
  inherited;
end;

procedure TFrmRegistroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TFrmRegistroCliente.FormShow(Sender: TObject);
begin
  Configuracion;
end;

procedure TFrmRegistroCliente.GrabarCliente;
var
  oclientecontroller: TclienteController;
begin
  oclientecontroller := TclienteController.Create;
  try
    case FOperacion of
      opNuevo:
        InsertarCliente;
      opActualizar:
        ActualizarCliente;
    end;
    oclientecontroller.buscarCliente(TxtBuscar.Text);
  finally
    FreeAndNil(oclientecontroller);

  end;

end;

procedure TFrmRegistroCliente.HabilitarBotones(aOPeracion: Toperacion);
begin
  case aOPeracion of
    opNuevo, opActualizar:
      begin
        txtNombre.Enabled := True;
        txtTelefono.Enabled := True;
        TxtPais.Enabled := True;
        btnGrabar.Enabled := True;
        btnCancelar.Enabled := True;
        btnListar.Enabled := False;
        btnCerrar.Enabled := False;
        btnActualizar.Enabled := False;
      end;
    opNAvegar:
      begin
        txtNombre.Enabled := False;
        txtTelefono.Enabled := False;
        TxtPais.Enabled := False;
        btnGrabar.Enabled := False;
        btnCancelar.Enabled := False;
        btnListar.Enabled := True;
        btnCerrar.Enabled := True;
        btnActualizar.Enabled := True;
      end;
  end;
end;

procedure TFrmRegistroCliente.InsertarCliente;
var
  ocliente: TCliente;
  oclientecontroller: TclienteController;
  sError: string;
begin
  ocliente := TCliente.Create;
  oclientecontroller := TclienteController.Create;
  try
    with ocliente do
    begin
      Id := 0;
      nombre := txtNombre.Text;
      fecha_nacimiento := StrToDate(TxtNacimiento.Text);
      edad := StrToInt(TxtEdad.Text);
      pais := TxtPais.Text;
      Telefono := txtTelefono.Text;
      if oclientecontroller.InsertarCliente(ocliente, sError) = False then
        raise Exception.Create(sError);
    end;
  finally
    FreeAndNil(ocliente);
    FreeAndNil(oclientecontroller);
  end;

end;

procedure TFrmRegistroCliente.listarCliente;
begin
  pgcPrincipal.ActivePage := TbBuscar;
end;

procedure TFrmRegistroCliente.Nuevo;
begin
  FOperacion := opNuevo;
  pgcPrincipal.ActivePage := TbDatos;
end;

end.