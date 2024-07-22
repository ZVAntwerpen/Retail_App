unit MainMenu_U;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  dmDatabase_U, ProductManage_U,
  Sales_U, SalesHistory_U, InventoryReport_U, Vcl.Imaging.jpeg,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TfrmMainMenu = class(TForm)
    pnlLogin: TPanel;
    lblUsernameLI: TLabel;
    lblPasswordLI: TLabel;
    edtLoginUsernameLI: TEdit;
    edtLoginPasswordLI: TEdit;
    btnLogin: TButton;
    btnShowPassword: TButton;
    pnlSignUp: TPanel;
    edtSignUpUsername: TEdit;
    edtSignUpPassword: TEdit;
    edtSignUpFirstname: TEdit;
    edtSignUpSurname: TEdit;
    btnConfirmSignUp: TButton;
    lblSignUpUsername: TLabel;
    lblSignUpPassword: TLabel;
    lblSignUpFirstname: TLabel;
    lblSignUpSurname: TLabel;
    lblSignUpUserType: TLabel;
    cbxSignUpUserType: TComboBox;
    btnSignUp: TButton;
    lblNoAccountLI: TLabel;
    lblLogInLI: TLabel;
    shpBG_LI: TShape;
    shpBG_SU: TShape;
    lblSignUpSU: TLabel;
    btnCancelSU: TButton;
    pnlWelcome: TPanel;
    lblUserFullName: TLabel;
    pnlGrayBG: TPanel;
    pnlYellowBG: TPanel;
    sbtnSalesHistory: TSpeedButton;
    sbtnInventoryReport: TSpeedButton;
    sbtnProductManagement: TSpeedButton;
    sbtnSales: TSpeedButton;
    shpBG_MM: TShape;
    spnLogoutMM: TSpeedButton;
    imgClipboard: TImage;
    lblDate: TLabel;
    btnCloseMM: TButton;
    btnCloseLM: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure btnShowPasswordMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnShowPasswordMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnInventoryReportClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
    procedure btnConfirmSignUpClick(Sender: TObject);
    procedure btnLoggoutClick(Sender: TObject);
    procedure sbtnSalesHistoryClick(Sender: TObject);
    procedure btnCancelSUClick(Sender: TObject);
    procedure bbtnCloseLogInClick(Sender: TObject);
    procedure sbtnInventoryReportClick(Sender: TObject);
    procedure sbtnProductManagementClick(Sender: TObject);
    procedure sbtnSalesClick(Sender: TObject);
    procedure spnLogoutMMClick(Sender: TObject);
    procedure btnCloseMMClick(Sender: TObject);

  private
    { Private declarations }
    sUserType, sUserFirstname, sUserSurname: string;
  public
    { Public declarations }
  end;

var
  frmMainMenu: TfrmMainMenu;

implementation

{$R *.dfm}

// ================================SIGNUP=(Create)==============================
procedure TfrmMainMenu.bbtnCloseLogInClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMainMenu.btnConfirmSignUpClick(Sender: TObject);
begin
  edtSignUpUsername.SetFocus;

  with dmDatabase do
  begin
    tblUsers.First;
    while NOT tblUsers.Eof do
    begin        //Kyk as username reeds bevat is
      if tblUsers['Username'] = edtSignUpUsername.Text then
      begin
        ShowMessage('Username already taken.');
        Exit;
      end
      else
      begin
        tblUsers.Next;
      end;

    end;

    //Kyk as iets uitgelos het
    if (edtSignUpUsername.Text <> '') AND (edtSignUpPassword.Text <> '') AND
      (edtSignUpFirstname.Text <> '') AND (edtSignUpSurname.Text <> '') AND
      (cbxSignUpUserType.Text <> '') then
    begin
      tblUsers.Insert;
      tblUsers['Username'] := edtSignUpUsername.Text;
      tblUsers['Password'] := edtSignUpPassword.Text;
      tblUsers['Firstname'] := edtSignUpFirstname.Text;
      tblUsers['Surname'] := edtSignUpSurname.Text;

      case cbxSignUpUserType.ItemIndex of
        0: tblUsers['UserType'] := 'Bestuurder';
        1: tblUsers['UserType'] := 'Verkoopspersoon';
      end;

      tblUsers.Post;
      pnlSignUp.Visible := false;
    end
    else
    begin
      ShowMessage('Invalid User');
    end;

  end;
end;

// --------------------------------NAVIGATE-------------------------------------
procedure TfrmMainMenu.btnInventoryReportClick(Sender: TObject);
begin
      //ShowModal - Geen veranderinge in ander forms maak nie.
  frmInventoryReport.ShowModal;
end;

// ================================LOGOUT=======================================
procedure TfrmMainMenu.btnLoggoutClick(Sender: TObject);
begin
  pnlLogin.Visible := true;
  edtLoginUsernameLI.Text := '';
  edtLoginPasswordLI.Text := '';

  //Enable alle buttons weer
  sbtnProductManagement.Enabled := true;
  sbtnSalesHistory.Enabled := true;
  sbtnInventoryReport.Enabled := true;
  sbtnSales.Enabled := true;

end;

// ==================================LOGIN======================================
procedure TfrmMainMenu.btnLoginClick(Sender: TObject);
var
  sUsername, sPassword: string;
  bFound: boolean;
begin
  sUsername := edtLoginUsernameLI.Text;
  sPassword := edtLoginPasswordLI.Text;

  bFound := false;
  with dmDatabase do
  begin
    tblUsers.First;

    while (NOT tblUsers.Eof) AND (bFound = false) do
    begin
        //Kyk as Username en Password reg is
      if (tblUsers['Username'] = sUsername) AND
        (tblUsers['Password'] = sPassword) then
      begin
        bFound := true;

        //Inligting vanaf User Ontvang
        sUserFirstname := tblUsers['Firstname'];
        sUserSurname := tblUsers['Surname'];
        sUserType := tblUsers['UserType'];


        lblUserFullName.Caption := 'Welcome ' + sUserFirstname + ' ' +
          sUserSurname;

        //Hide panel om MainMenu te sien
        pnlLogin.Visible := false;
      end
      else
      begin
        tblUsers.Next;
      end;
    end;
  end;
  // -------------------------BEPERKING_VIR_GEBRUIKERS--------------------------
  if bFound = true then
  begin

    //Enable slegs sekere Buttons afhangend van gebruiker
    if sUserType = 'Verkoopspersoon' then
    begin
      sbtnProductManagement.Enabled := false;
      sbtnSalesHistory.Enabled := false;
      sbtnInventoryReport.Enabled := false;
    end
    else if sUserType = 'Bestuurder' then
    begin
      sbtnSales.Enabled := false;
    end;
  end;

  if bFound = false then
  begin
    ShowMessage('Invalid Username and/or Password');
  end;
end;

// =========================SHOW_PASSWORD=======================================
procedure TfrmMainMenu.btnShowPasswordMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
      //Maak Password normale char
   edtLoginPasswordLI.PasswordChar := #0;
end;

procedure TfrmMainMenu.btnShowPasswordMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
      //Maak Password Sterretjies
  edtLoginPasswordLI.PasswordChar := '*';
end;

// =========================SIGNUP=(Show_Panel)=================================
procedure TfrmMainMenu.btnSignUpClick(Sender: TObject);
begin
  pnlSignUp.Left := 0;
  pnlSignUp.Top := 0;
  pnlSignUp.BringToFront;
  pnlSignUp.Visible := true;
end;

procedure TfrmMainMenu.btnCancelSUClick(Sender: TObject);
begin
  pnlSignUp.Visible := false;
end;

// ==========================FORM_CREATE========================================
procedure TfrmMainMenu.FormCreate(Sender: TObject);
begin
  lblDate.Caption := DateToStr(Now);
  pnlLogin.Left := 0;
  pnlLogin.Top := 0;
  pnlLogin.BringToFront;
  frmMainMenu.ClientHeight := 380;
  frmMainMenu.ClientWidth := 562;
end;

 //--------------------------NAVIGATE_WINDOWS-----------------------------------
procedure TfrmMainMenu.sbtnSalesHistoryClick(Sender: TObject);
begin
  frmSalesHistory.ShowModal;
end;

// ==========================LOGOUT(MM)=========================================
procedure TfrmMainMenu.spnLogoutMMClick(Sender: TObject);
begin
  pnlLogin.Visible := true;
  edtLoginUsernameLI.Text := '';
  edtLoginPasswordLI.Text := '';

  //Enable alle buttons weer
  sbtnProductManagement.Enabled := true;
  sbtnSalesHistory.Enabled := true;
  sbtnInventoryReport.Enabled := true;
  sbtnSales.Enabled := true;
end;

// --------------------------NAVIGATE_WINDOWS-----------------------------------
procedure TfrmMainMenu.sbtnSalesClick(Sender: TObject);
begin
  frmSales.ShowModal;
end;

procedure TfrmMainMenu.sbtnProductManagementClick(Sender: TObject);
begin
  frmProductManager.ShowModal;
end;

procedure TfrmMainMenu.sbtnInventoryReportClick(Sender: TObject);
begin
  frmInventoryReport.ShowModal;
end;

procedure TfrmMainMenu.btnCloseMMClick(Sender: TObject);
begin
  Application.Terminate;
end;
//==============================================================================
end.
