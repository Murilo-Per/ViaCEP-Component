unit ViaCEP.Intrfc;

interface

type
  IViaCEP = interface
    ['{A8285AA3-B4AC-4A0D-AB51-12067EA131D3}']

    procedure GetJson(const ACep: string); overload;
    procedure GetJson(const AUF, ACidade, ALogradouro: string); overload;
    procedure GetXml(const ACep: string); overload;
    procedure GetXml(const AUF, ACidade, ALogradouro: string); overload;
    function Validate(const ACep: string): Boolean; overload;
    function Validate(const AUF, ALocalidade, ALogradouro: string): Boolean; overload;
  end;

implementation

end.
