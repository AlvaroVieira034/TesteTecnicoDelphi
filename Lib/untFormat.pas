/////////////////////////////////////////////////////////////////////////////
{
    Unit Format
    Criação: 99 Coders (Heber Stein Mazutti - heber@99coders.com.br)
    Versão: 1.2
}
/////////////////////////////////////////////////////////////////////////////

unit untFormat;

interface

uses System.SysUtils, Vcl.StdCtrls, Classes, System.MaskUtils;

type
    TFormato = (CNPJ, CPF, CNPJorCPF, TelefoneFixo, Celular, Valor, CEP, Dt);

procedure Formatar(Obj: TObject; Formato : TFormato; Extra : string = '');

implementation

function SomenteNumero(str : string) : string;
var
    x : integer;
begin
    Result := '';
    for x := 0 to Length(str) - 1 do
        if (str.Chars[x] In ['0'..'9']) then
            Result := Result + str.Chars[x];
end;

function FormataValor(str : string) : string;
begin
    if Str = '' then
        Str := '0';

    try
        Result := FormatFloat('#,##0.00', strtofloat(str) / 100);
    except
        Result := FormatFloat('#,##0.00', 0);
    end;
end;

function Mask(Mascara, Str : string) : string;
var
    x, p : integer;
begin
    p := 0;
    Result := '';

    if Str.IsEmpty then
        exit;

    for x := 0 to Length(Mascara) - 1 do
    begin
        if Mascara.Chars[x] = '#' then
        begin
            Result := Result + Str.Chars[p];
            inc(p);
        end
        else
            Result := Result + Mascara.Chars[x];

        if p = Length(Str) then
            break;
    end;
end;

function FormataData(str : string): string;
begin
    str := Copy(str, 1, 8);

    if Length(str) < 8 then
        Result := Mask('##/##/####', str)
    else
    begin
        try
            str := Mask('##/##/####', str);
            strtodate(str);
            Result := str;
        except
            Result := '';
        end;
    end;
end;

procedure Formatar(Obj: TObject; Formato : TFormato; Extra : string = '');
var
    texto : string;
begin
    TThread.Queue(Nil, procedure
    begin
        if obj is TEdit then
            texto := TEdit(obj).Text;

        // Telefone Fixo...
        if formato = TelefoneFixo then
            texto := Mask('(##) ####-####', SomenteNumero(texto));

        // Celular...
        if formato = Celular then
            texto := Mask('(##) #####-####', SomenteNumero(texto));

        // CNPJ...
        if formato = CNPJ then
            texto := Mask('##.###.###/####-##', SomenteNumero(texto));

        // CPF...
        if formato = CPF then
            texto := Mask('###.###.###-##', SomenteNumero(texto));

        // CNPJ ou CPF...
        if formato = CNPJorCPF then
            if Length(SomenteNumero(texto)) <= 11 then
                texto := Mask('###.###.###-##', SomenteNumero(texto))
            else
                texto := Mask('##.###.###/####-##', SomenteNumero(texto));

        // Valor...
        if Formato = Valor then
            texto := FormataValor(SomenteNumero(texto));

        // CEP...
        if Formato = CEP then
            texto := Mask('##.###-###', SomenteNumero(texto));

        // Data...
        if formato = Dt then
            texto := FormataData(SomenteNumero(texto));

        if obj is TEdit then
        begin
            TEdit(obj).Text := texto;
            TEdit(obj).SelStart := Length(TEdit(obj).Text);
        end;

    end);

end;

end.
