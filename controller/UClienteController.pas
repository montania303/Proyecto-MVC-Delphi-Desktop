unit UClienteController;

interface

uses UClienteModel, UDMCliente, System.SysUtils;

type
  TclienteController = class

  public
    constructor Create;
    destructor Destroy; override;
    procedure CargarCliente(oCliente: TCliente; icodigo: Integer);
    procedure BuscarCliente(sNombre: string);
    function InsertarCliente(oCliente: TCliente; var sError: String): Boolean;
    function ActualizarCliente(oCliente: TCliente; var sError: String): Boolean;
    function EliminarCliente(oCodigo: Integer; var sError: String): Boolean;
  end;

implementation

{ TclienteController }

function TclienteController.ActualizarCliente(oCliente: TCliente;
  var sError: String): Boolean;
begin
  Result := DMCliente.ActualizarCliente(oCliente, sError);
end;

procedure TclienteController.BuscarCliente(sNombre: string);
begin
  DMCliente.BuscarCliente(sNombre);
end;

procedure TclienteController.CargarCliente(oCliente :TCliente; icodigo:Integer);
begin
  DMCliente.cargarCliente(oCliente, icodigo);
end;

constructor TclienteController.Create;
begin
  //DMCliente := TDMCliente.Create(nil);
end;

destructor TclienteController.Destroy;
begin
 // FreeAndNil(DMCliente);
 // inherited;
end;

function TclienteController.EliminarCliente(oCodigo: Integer;
  var sError: String): Boolean;
begin
  Result := DMCliente.EliminarCliente(oCodigo, sError);
end;

function TclienteController.InsertarCliente(oCliente: TCliente;
  var sError: String): Boolean;
begin
  Result := DMCliente.InsertarCliente(oCliente, sError);
end;

end.
