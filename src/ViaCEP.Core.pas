unit ViaCEP.Core;

interface

uses System.SysUtils, IdHTTP, IdSSLOpenSSL, ViaCEP.Intrfc, ViaCEP.Model;

type
  TViaCEP = class(TInterfacedObject, IViaCEP)
  private
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FViaCEPClass: TViaCEPClass;
  public
    constructor Create;
    destructor Destroy; override;
    procedure GetJson(const ACep: string); overload;
    procedure GetJson(const AUF, ACidade, ALogradouro: string); overload;
    procedure GetXml(const ACep: string); overload;
    procedure GetXml(const AUF, ACidade, ALogradouro: string); overload;
    function Validate(const ACep: string): Boolean;  overload;
    function Validate(const AUF, ALocalidade, ALogradouro: string): Boolean; overload;
    property Endereco: TViaCEPClass read FViaCEPClass;
  end;

implementation

{ TViaCEP }

uses System.Classes, REST.Json, System.JSON, ViaCEP.Utils, XMLDoc, XMLIntf,  ViaCEP.ParseXML;

const
  URL = 'https://viacep.com.br/ws/%s/%s';
  URL2 = 'https://viacep.com.br/ws/%s/%s/%s/%s';
  INVALID_CEP = '{'#$A'  "erro": true'#$A'}';

constructor TViaCEP.Create;
begin
  FIdHTTP := TIdHTTP.Create;
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  FViaCEPClass := TViaCEPClass.Create;
end;

procedure TViaCEP.GetJson(const ACep: string);
var
  LResponse: TStringStream;
begin
  FViaCEPClass.Clear;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Get(Format(URL, [ACep.Trim, 'json']), LResponse);
    if (FIdHTTP.ResponseCode = 200) and (not (LResponse.DataString).Equals(INVALID_CEP)) then
      FViaCEPClass := TJson.JsonToObject<TViaCEPClass>(UTF8ToString(PAnsiChar(AnsiString(LResponse.DataString))));
  finally
    FreeAndNil(LResponse);
  end;
end;

procedure TViaCEP.GetJson(const AUF, ACidade, ALogradouro: string);
var
  LResponse: TStringStream;
begin
  FViaCEPClass.Clear;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Get(Format(URL2, [AUF.Trim, ConcatParam(ACidade), ConcatParam(ALogradouro), 'json']), LResponse);
    if (FIdHTTP.ResponseCode = 200) and (not (LResponse.DataString).Equals(INVALID_CEP)) and (Length(LResponse.DataString) > 2) then
      FViaCEPClass := TJson.JsonToObject<TViaCEPClass>(UTF8ToString(PAnsiChar(AnsiString(ParseArrayJson(LResponse.DataString)))));
  finally
    FreeAndNil(LResponse);
  end;
end;

procedure TViaCEP.GetXml(const ACep: string);
var
  LResponse: TStringStream;
begin
  FViaCEPClass.Clear;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Get(Format(URL, [ACep.Trim, 'xml']), LResponse);
    if (FIdHTTP.ResponseCode = 200) and not (lResponse.DataString.Contains('erro'))then
      TXmlCepParser.ParseXml(UTF8ToString(PAnsiChar(AnsiString(lResponse.DataString))), FViaCEPClass);

  finally
    FreeAndNil(LResponse);
  end;
end;

procedure TViaCEP.GetXml(const AUF, ACidade, ALogradouro: string);
var
  LResponse: TStringStream;
begin
  FViaCEPClass.Clear;
  LResponse := TStringStream.Create;
  try
    FIdHTTP.Get(Format(URL2, [AUF.Trim, ConcatParam(ACidade), ConcatParam(ALogradouro), 'xml']), LResponse);
    if (FIdHTTP.ResponseCode = 200) and not (lResponse.DataString.Contains('erro')) then
      TXmlCepParser.ParseXml(UTF8ToString(PAnsiChar(AnsiString(lResponse.DataString))), FViaCEPClass);

  finally
    FreeAndNil(LResponse);
  end;
end;

function TViaCEP.Validate(const ACep: string): Boolean;
const
  INVALID_CHARACTER = -1;
begin
  Result := True;
  if ACep.Trim.Length <> 8 then
    Exit(False);

  if StrToIntDef(ACep, INVALID_CHARACTER) = INVALID_CHARACTER then
    Exit(False);
end;

function TViaCEP.Validate(const AUF, ALocalidade, ALogradouro: string): Boolean;
begin
  Result := True;
  if (AUF.Trim.Length < 2) or (ALocalidade.Trim.Length < 3) or (ALogradouro.Trim.Length < 3) then
    Exit(False);
end;

destructor TViaCEP.Destroy;
begin
  FreeAndNil(FIdSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FIdHTTP);
  FreeAndNil(FViaCEPClass);
  inherited;
end;

end.
