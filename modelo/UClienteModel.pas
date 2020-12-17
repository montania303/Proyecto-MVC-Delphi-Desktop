unit UClienteModel;

interface

uses
  System.SysUtils;

type
  TCliente = class
  private
    FId: Integer;
    Fnombre: String;
    FFecha_nacimiento: TDate;
    Fedad: Integer;
    FPais: string;
    FTelefono: string;
    procedure Setnombre(const Value: String);
    { private declarations }
  protected
    { protected declarations }
  public
    property Id: Integer read FId write FId;
    property nombre: String read Fnombre write Setnombre;
    property fecha_nacimiento: TDate read FFecha_nacimiento write FFecha_nacimiento;
    property edad: Integer read Fedad write Fedad;
    property pais: string read FPais write FPais;
    property Telefono: string read FTelefono write FTelefono;
  published
    { published declarations }
  end;

implementation

{ TCliente }

procedure TCliente.Setnombre(const Value: String);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create
      ('Es Necesario Digitar un mombre para el cliente');
  Fnombre := Value;
end;

end.
