unit UDMCliente;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.SqlExpr, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, UDMConexion, UClienteModel;

type
  TDMCliente = class(TDataModule)
    DSPBuscar: TDataSetProvider;
    CDSBuscar: TClientDataSet;
    SQLBuscar: TSQLDataSet;
    SQLActualizar: TSQLDataSet;
    SQLEliminar: TSQLDataSet;
    SQLInsertar: TSQLDataSet;
    CDSBuscarID: TIntegerField;
    CDSBuscarNOME: TStringField;
    CDSBuscarDATA_NASCIMENTO: TDateField;
    CDSBuscarIDADE: TLargeintField;
    CDSBuscarPAIS: TStringField;
    CDSBuscarTELEFONE: TStringField;
  private
    { Private declarations }
  public
    function GenerarID: Integer;
    procedure buscarCliente(Snombre: string);
    procedure cargarCliente(oCliente: TCliente; iCodigo: Integer);
    function InsertarCliente(oCliente: TCliente; out sErro: string): Boolean;
    function ActualizarCliente(oCliente: TCliente; out sErro: string): Boolean;
    function EliminarCliente(iCodigo: Integer; out sErro: string): Boolean;
    { Public declarations }
  end;

var
  DMCliente: TDMCliente;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TDataModule1 }

function TDMCliente.ActualizarCliente(oCliente: TCliente;
  out sErro: string): Boolean;
begin
  with SQLActualizar, oCliente do
  begin
    Params[0].AsString := Nombre;
    Params[1].AsDateTime := Fecha_nacimiento;
    Params[2].AsString := Pais;
    Params[3].AsString := Telefono;
    Params[4].AsInteger := Id;
    try
      ExecSQL();
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Error al intentar Actualizar los datos del cliente: ' +
          sLineBreak + E.Message;
        Result := False;
      end;

    end;
  end;

end;

procedure TDMCliente.buscarCliente(Snombre: string);
begin
//  if CDSBuscar.Active then
  begin
    CDSBuscar.Close;
    CDSBuscar.Params[0].AsString := '%' + Snombre + '%';
    CDSBuscar.Open;
    CDSBuscar.First;
  end;

end;

procedure TDMCliente.cargarCliente(oCliente: TCliente; iCodigo: Integer);
var
  sqlCliente: TSQLDataSet;
begin
  sqlCliente:= TSQLDataSet.Create(nil);
  try
    with sqlCliente do
    begin
      sqlCliente.SQLConnection := DMConexion.SQLConnection;
      CommandText := 'select * from cliente where (id =' +
        IntToStr(iCodigo) + ')';
      Open;
      with oCliente do
      begin
        Id := FieldByName('id').AsInteger;
        Nombre := FieldByName('nome').AsString;
        Fecha_nacimiento := FieldByName('data_nascimento').AsDateTime;
        Edad := FieldByName('idade').AsInteger;
        Pais := FieldByName('pais').AsString;
        Telefono := FieldByName('telefone').AsString;
      end;
    end;

  finally

  end;

end;

function TDMCliente.EliminarCliente(iCodigo: Integer;
  out sErro: string): Boolean;
begin
  with SQLEliminar do
  begin
    Params[0].AsInteger := iCodigo;
    try
      ExecSQL();
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Error al intentar Eliminar el cliente' + sLineBreak +
          E.Message;
        Result := False;
      end;

    end;
  end;
end;

function TDMCliente.GenerarID: Integer;
var
  sqlSecuencia: TSQLDataSet;
begin
  sqlSecuencia := TSQLDataSet.Create(nil);
  try
    with sqlSecuencia do
    begin
      SQLConnection := DMConexion.SQLConnection;
      CommandText := 'Select coalese(max(id), 0) + 1 seq from cliente';
      Open;
      Result := sqlSecuencia.FieldByName('seq').AsInteger;
    end;
  finally
    FreeAndNil(sqlSecuencia);

  end;
end;

function TDMCliente.InsertarCliente(oCliente: TCliente;
  out sErro: string): Boolean;
begin
  with SQLInsertar, oCliente do
  begin
    Params[0].AsInteger := GenerarID();
    Params[1].AsString := Nombre;
    Params[2].AsDateTime := Fecha_nacimiento;
    Params[3].AsInteger := Edad;
    Params[4].AsString := Pais;
    Params[5].AsString := Telefono;
    try
      ExecSQL();
      Result := True;
    except
      on E: Exception do
      begin
        sErro := 'Error al intentar realizar la inserci�n del cliente' +
          sLineBreak + E.Message;
        Result := False;
      end;

    end;
  end;
end;

end.