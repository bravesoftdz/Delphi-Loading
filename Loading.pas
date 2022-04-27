unit Loading;

interface

uses
  System.SysUtils,
  System.UITypes,
  FMX.Types,
  FMX.Controls,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Effects,
  FMX.Layouts,
  FMX.Forms,
  FMX.Graphics,
  FMX.Ani,
  FMX.VirtualKeyboard,
  FMX.Platform;

type
  TLoading = class
  private
    class var Layout: TLayout;
    class var Fundo: TRectangle;
    class var Arco: TArc;
    class var Mensagem: TLabel;
    class var Animacao: TFloatAnimation;
    class var ArcoAnimado: TAniIndicator;
  public
    class procedure Show(const Frm: Tform; const msg: string);
    class procedure Hide;
  end;

implementation

{ TLoading }

class procedure TLoading.Hide;
begin
  if Assigned(Layout) then
  begin
    try
      if Assigned(Mensagem) then
        Mensagem.DisposeOf;

      if Assigned(Animacao) then
        Animacao.DisposeOf;

      if Assigned(Arco) then
        Arco.DisposeOf;

      if Assigned(ArcoAnimado) then
        ArcoAnimado.DisposeOf;

      if Assigned(Fundo) then
        Fundo.DisposeOf;

      if Assigned(Layout) then
        Layout.DisposeOf;
    except
    end;
  end;

  Mensagem := nil;
  Animacao := nil;
  Arco := nil;
  ArcoAnimado := nil;
  Layout := nil;
  Fundo := nil;
end;

class procedure TLoading.Show(const Frm: Tform; const msg: string);
var
  FService: IFMXVirtualKeyboardService;
begin
  // Panel de fundo opaco...
  Fundo := TRectangle.Create(Frm);
  Fundo.Opacity := 100;
  Fundo.Parent := Frm;
  Fundo.Visible := true;
  Fundo.Align := TAlignLayout.Contents;
  Fundo.Fill.Color := TAlphaColorRec.White;
  Fundo.Fill.Kind := TBrushKind.Solid;
  Fundo.Stroke.Kind := TBrushKind.None;
  Fundo.Visible := true;

  // Layout contendo o texto e o arco...
  Layout := TLayout.Create(Frm);
  Layout.Opacity := 100;
  Layout.Parent := Frm;
  Layout.Visible := true;
  Layout.Align := TAlignLayout.Contents;
  Layout.Width := 250;
  Layout.Height := 78;
  Layout.Visible := true;

  ArcoAnimado := TAniIndicator.Create(Frm);
  ArcoAnimado.Parent := Layout;
  ArcoAnimado.Align := TAlignLayout.Center;
  ArcoAnimado.Enabled := true;

  // Label do texto...
  Mensagem := TLabel.Create(Frm);
  Mensagem.Parent := Layout;
  Mensagem.Align := TAlignLayout.Bottom;
  Mensagem.Margins.Top := 60;
  Mensagem.Font.Size := 13;
  Mensagem.Height := 70;
  Mensagem.Width := Frm.Width - 100;
  Mensagem.FontColor := TAlphaColorRec.Black;
  Mensagem.TextSettings.HorzAlign := TTextAlign.Center;
  Mensagem.TextSettings.VertAlign := TTextAlign.Leading;
  Mensagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  Mensagem.Text := msg;
  Mensagem.VertTextAlign := TTextAlign.Leading;
  Mensagem.Trimming := TTextTrimming.None;
  Mensagem.TabStop := false;
  Mensagem.SetFocus;

   // Label do texto...
  Mensagem := TLabel.Create(Frm);
  Mensagem.Parent := Layout;
  Mensagem.Align := TAlignLayout.Top;
  Mensagem.Margins.Top := 60;
  Mensagem.Font.Size := 13;
  Mensagem.Height := 70;
  Mensagem.Width := Frm.Width - 100;
  Mensagem.FontColor := TAlphaColorRec.Black;
  Mensagem.TextSettings.HorzAlign := TTextAlign.Center;
  Mensagem.TextSettings.VertAlign := TTextAlign.Leading;
  Mensagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
  Mensagem.Text := '';
  Mensagem.VertTextAlign := TTextAlign.Leading;
  Mensagem.Trimming := TTextTrimming.None;
  Mensagem.TabStop := false;
  Mensagem.SetFocus;

  Layout.BringToFront;

  // Esconde o teclado virtual...
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
    IInterface(FService));
  if (FService <> nil) then
  begin
    FService.HideVirtualKeyboard;
  end;
  FService := nil;
end;

end.
