unit ViaCEP;

interface

uses
  System.Classes, System.SysUtils, Vcl.Controls, ViaCEP.Intrfc, ViaCEP.Core;

type
  TConsultaCEP = class(TComponent)
  private
    FViaCEP: TViaCEP;
    FIsViaCEPInitialized: Boolean;
    procedure InitializeViaCEP;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ViaCEP: TViaCEP read FViaCEP;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MConsultaCEP', [TConsultaCEP]);
end;

constructor TConsultaCEP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIsViaCEPInitialized := False;
end;

destructor TConsultaCEP.Destroy;
begin
  FreeAndNil(FViaCEP);
  inherited Destroy;
end;

procedure TConsultaCEP.InitializeViaCEP;
begin
  if not FIsViaCEPInitialized then
  begin
    FViaCEP := TViaCEP.Create;
    FIsViaCEPInitialized := True;
  end;
end;

procedure TConsultaCEP.Loaded;
begin
  inherited Loaded;
  InitializeViaCEP;
end;

end.

