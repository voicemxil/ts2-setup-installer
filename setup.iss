; ============================================================================
;  The Sims 2 Setup Kit  (working title)
;  Post-install setup & fixes for The Sims 2 - Ultimate Collection, Legacy
;  Collection, and disc installs. Ships NO game files; every component is
;  downloaded at install time from its official source.
;
;  Requires Inno Setup 6.3+ (uses DownloadTemporaryFile + Extract7ZipArchive).
;  by osab
; ============================================================================

#define AppName "The Sims 2 Setup Kit"
#define AppVersion "0.1.0"

; ---------------------------------------------------------------------------
; Component download URLs.  TODO: finalize hosting (SimFileShare primary /
; GitHub backup). SHA256 constants alongside for verification.
; ---------------------------------------------------------------------------
; Original-source URLs wherever an official home exists (SimFileShare mirrors are also viable).
#define UrlSims2RPC       "https://github.com/LazyDuchess/Sims2RPC.com/releases/download/1.15.1/Sims2RPC.zip"
#define UrlTS2Extender    "https://github.com/LazyDuchess/TS2-Extender/releases/download/0.8.1/TS2.Extender.0.8.1.zip"
#define UrlGraphicsRules  "https://raw.githubusercontent.com/voicemxil/ts2-setup-installer/main/components/GraphicsRules.sgr"  ; osab's, hosted in this repo; Video Cards.sgr is stock and already present
#define UrlMemCapV1       "https://github.com/spockthewok/TS2MemCapRemover/releases/download/v1.0.0/TS2MemCapRemover-v1.asi"
#define UrlMemCapV2       "https://github.com/spockthewok/TS2MemCapRemover/releases/download/v1.0.0/TS2MemCapRemover-v2.asi"
#define UrlHoodFX         "https://github.com/spockthewok/TS2VisibleHoodFX/releases/download/v1.2.0/TS2VisibleHoodFX.zip"
#define UrlWaterAsi       "https://github.com/spockthewok/TS2ReflectiveWater/releases/download/v1.4.0/TS2ReflectiveWater.asi"
#define UrlWaterShaders   "https://github.com/spockthewok/TS2ReflectiveWater/releases/download/v1.4.0/Shaders.zip"
#define UrlSoftShadow100  "https://www.simfileshare.net/download/2751461/"   ; ld_SoftShadows_NoOverlap_100.package (raw)
#define UrlSoftShadow50   "https://www.simfileshare.net/download/2751459/"   ; ld_SoftShadows_NoOverlap_50.package (raw)
#define UrlSoftShadowOv   "https://www.simfileshare.net/download/2751460/"   ; ld_SoftShadows_Overlap.package (raw)
#define UrlCozyHome       "https://github.com/thedreadpirates/ts2-lightingmod-cozyhome/releases/download/2.0.0/vvqb_lightingmod_cozyhome.zip"
#define UrlShadowFix      "https://chii.modthesims.info/getfile.php?file=1591074&v=1735832737"  ; simNopke Sim Shadow Fix (medium), MTS 569585 - UC only
#define UrlPieMenuFix     "https://chii.modthesims.info/getfile.php?file=896931&v=1238158182"   ; Lord Darcy Pie Menu Text Strings Fix (FT/AL/M&G), MTS 304594
#define UrlUIFontsFix     "https://chii.modthesims.info/getfile.php?file=1565598&v=1448153211"  ; UI Text Fonts Fix for AL/MG, MTS 563540 - both editions (regression persists in Legacy)
#define UrlBrightCAS      "https://www.simfileshare.net/download/2571624/"                      ; LD Overly Bright CAS Fix (raw .package) - UC only for now
#define UrlCEP            "https://chii.modthesims.info/getfile.php?file=913167&v=1241129412"   ; CEP 9.2.0 manual-installation zip, MTS 92541
#define UrlDXVK           "https://github.com/doitsujin/dxvk/releases/download/v3.1/dxvk-3.1.tar.gz"
#define DxvkDirName       "dxvk-3.1"
#define UrlVCRedist       "https://aka.ms/vs/17/release/vc_redist.x86.exe"
#define UrlNDP48          "https://go.microsoft.com/fwlink/?LinkId=2085155"  ; .NET 4.8 web installer

[Setup]
AppId={{8F3C1D2A-4B67-4E85-9C10-A7D25E93B4F1}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher=osab
DefaultDirName={autopf}\{#AppName}
DisableDirPage=yes
DisableProgramGroupPage=yes
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64compatible
OutputBaseFilename=TS2SetupKit-{#AppVersion}
WizardStyle=modern
SetupLogging=yes
Uninstallable=no
ArchiveExtraction=full

[Types]
Name: "recommended"; Description: "Recommended (core + essential fixes)"
Name: "full";        Description: "Full (fixes + graphical extras + lighting)"
Name: "custom";      Description: "Custom"; Flags: iscustom

[Components]
; Core is mandatory. Edition-specific rows are greyed out at runtime (CurPageChanged) -
; [Components] entries can't use Check: functions.
Name: "core";            Description: "Core: launcher (Sims2RPC / TS2 Extender), Graphics Rules, dependencies"; Types: recommended full custom; Flags: fixed
Name: "fixes";           Description: "Essential fixes"; Types: recommended full
Name: "fixes\cep";       Description: "CEP - Color Enable Package (by Numenor && RGiles)"; Types: recommended full
Name: "fixes\piemenu";   Description: "Pie Menu Text Strings Fix (by Lord Darcy)"; Types: recommended full custom; Flags: fixed
Name: "fixes\uifonts";   Description: "UI Text Fonts Fix for AL/M&&G"; Types: recommended full custom; Flags: fixed
Name: "fixes\shadow";    Description: "Sim Shadow Fix (by simNopke) - Ultimate Collection/disc only"; Types: recommended full
Name: "fixes\brightcas"; Description: "Overly Bright CAS Fix (by Lazy Duchess) - Ultimate Collection/disc only"; Types: recommended full
Name: "fixes\memcap";    Description: "Pink flashing fix (TS2MemCapRemover by SpockTheWok) - Ultimate Collection/disc only"; Types: recommended full
Name: "fixes\memcap\v2"; Description: "Version 2 (safer, recommended)"; Types: recommended full; Flags: exclusive
Name: "fixes\memcap\v1"; Description: "Version 1 (original)"; Flags: exclusive
Name: "gfx";                     Description: "Graphical && shader tweaks"; Types: full
Name: "gfx\hoodfx";              Description: "TS2VisibleHoodFX - neighborhood effects in lot view (by SpockTheWok)"; Types: full
Name: "gfx\water";               Description: "TS2ReflectiveWater - improved water reflections (by SpockTheWok)"; Types: full
Name: "gfx\softshadows";         Description: "Soft Outdoor Shadows 2.0 (by Lazy Duchess)"; Types: full
Name: "gfx\softshadows\no100";   Description: "No Overlap 100 - detailed, best with high-res RPC shadows (recommended)"; Types: full; Flags: exclusive
Name: "gfx\softshadows\no50";    Description: "No Overlap 50 - softer, more overlap artifacts"; Flags: exclusive
Name: "gfx\softshadows\overlap"; Description: "Overlap - fully soft shadows"; Flags: exclusive
; TODO: if a d3d9.dll already exists in TSBin, warn before overwriting - the user may have
; their own DXVK build/config (e.g. an HDR-tuned dxvk.conf) in place.
Name: "gfx\dxvk";                Description: "DXVK - D3D9-to-Vulkan (recommended for AMD RX 400+; requires Vulkan 1.3)"; Types: full
Name: "lighting";                Description: "Lighting"; Types: full
Name: "lighting\cozyhome";       Description: "Cozy Home lighting mod (by dreadpirate)"; Types: full

[Tasks]
; Tasks = install tweaks only; actual components/mods live on the Components page.
Name: "shortcuts";  Description: "Create Start Menu && Desktop shortcuts for Sims2RPC"; Check: not IsLegacy

[Code]
// ===========================================================================
// Edition & path detection
// ===========================================================================
type
  TEdition = (edNone, edUC, edLegacy, edBoth);

var
  GEdition: TEdition;          // what was detected
  GUseLegacy: Boolean;         // effective choice after user selection
  GGameRoot: string;           // install root (parent of all pack folders)
  GRunPackDir: string;         // folder of the newest pack (contains TSBin/TSData)
  GEditionPage: TInputOptionWizardPage;
  GLangPage: TWizardPage;
  GLangCombo: TNewComboBox;
  GDownloadPage: TDownloadWizardPage;
  GExitCode: Integer;

// Newest-first pack exe order (mirrors the game's own "Suppression Exe" order)
const
  PackExeOrder = 'Sims2EP9.exe,Sims2EP8.exe,Sims2EP7.exe,Sims2SP7.exe,Sims2SP6.exe,'
               + 'Sims2EP6.exe,Sims2SP5.exe,Sims2SP4.exe,Sims2EP5.exe,Sims2EP4.exe,'
               + 'Sims2SP2.exe,Sims2SP1.exe,Sims2EP3.exe,Sims2EP2.exe,Sims2EP1.exe,Sims2.exe';
  RegAppPaths = 'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\';
  // Legacy Collection registers per-user as "Ultimate Collection 25" (verified on Steam install):
  // HKCU\SOFTWARE\Electronic Arts\The Sims 2 Ultimate Collection 25\<exe> -> 'path' (pack dir), 'installed' (dword)
  // Language lives in ...\1.0 -> 'language' (lowercase, dword EA id)
  RegLegacyKey = 'SOFTWARE\Electronic Arts\The Sims 2 Ultimate Collection 25';

function SplitCsv(const S: string): TStringList;
var
  L: TStringList;
begin
  L := TStringList.Create;
  L.CommaText := S;
  Result := L;
end;

// Walk App Paths newest-first; first exe that exists on disk wins.
// Sets GRunPackDir (grandparent of the exe: <pack>\TSBin\<exe>) and GGameRoot.
function DetectUCOrDisc(): Boolean;
var
  Exes: TStringList;
  I: Integer;
  ExePath: string;
begin
  Result := False;
  Exes := SplitCsv(PackExeOrder);
  try
    for I := 0 to Exes.Count - 1 do
    begin
      if RegQueryStringValue(HKLM32, RegAppPaths + Exes[I], '', ExePath)
         and FileExists(ExePath) then
      begin
        GRunPackDir := ExtractFileDir(ExtractFileDir(ExePath));   // strip \TSBin\exe
        GGameRoot := ExtractFileDir(GRunPackDir);
        // Collection layouts nest one level deeper (root\Fun with Pets\SP9);
        // walk up while the parent also isn't where the base game lives.
        // Disc layouts are flat (root\The Sims 2 Mansion and Garden Stuff).
        // For downstream logic only GRunPackDir matters; GGameRoot is cosmetic.
        Result := True;
        Exit;
      end;
    end;
  finally
    Exes.Free;
  end;
end;

function DetectLegacy(): Boolean;
var
  Dir: string;
  Installed: Cardinal;
begin
  // Primary: the game's own keys. Written by Steam's install script, which runs during
  // FIRST-TIME SETUP ON LAUNCH - so a downloaded-but-never-launched install lacks them.
  // The run-from pack is EP9 (Mansion & Garden); its 'path' value IS the pack dir.
  // NOTE: HKCU key - with an elevated installer this reads the elevating user's hive.
  Result := RegQueryStringValue(HKCU, RegLegacyKey + '\Sims2EP9.exe', 'path', Dir)
            and RegQueryDWordValue(HKCU, RegLegacyKey + '\Sims2EP9.exe', 'installed', Installed)
            and (Installed = 1)
            and DirExists(Dir);
  if Result then
  begin
    GRunPackDir := RemoveBackslashUnlessRoot(Dir);
    GGameRoot := ExtractFileDir(GRunPackDir);
    Exit;
  end;

  // Fallback: Steam's uninstall entry, written at download time.
  if RegQueryStringValue(HKLM32, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 3314070',
                         'InstallLocation', Dir)
     and DirExists(AddBackslash(Dir) + 'EP9\TSBin') then
  begin
    GGameRoot := RemoveBackslashUnlessRoot(Dir);
    GRunPackDir := AddBackslash(GGameRoot) + 'EP9';
    Result := True;
    // NOTE: on a never-launched install, Steam's first-time setup will later run the
    // install script, which may overwrite the language value we write. Acceptable.
  end;
end;

function IsLegacy(): Boolean;
begin
  Result := GUseLegacy;
end;

// Disc installs run from a full-name pack folder (e.g. "The Sims 2 Mansion and Garden
// Stuff") instead of the UC collection's "Fun with Pets\SP9".
function IsDiscLayout(): Boolean;
begin
  Result := (not GUseLegacy) and (CompareText(ExtractFileName(GRunPackDir), 'SP9') <> 0);
end;

// ===========================================================================
// Language table (EA language IDs, recovered from the original installers)
// ===========================================================================
const
  LangCount = 24;

// parallel arrays: display name / EA id
function LangName(I: Integer): string;
begin
  case I of
    0:  Result := 'English (US)';        1:  Result := 'English (UK)';
    2:  Result := 'French';              3:  Result := 'German';
    4:  Result := 'Italian';             5:  Result := 'Spanish';
    6:  Result := 'Swedish';             7:  Result := 'Finnish';
    8:  Result := 'Dutch';               9:  Result := 'Danish';
    10: Result := 'Portuguese (Brazil)'; 11: Result := 'Czech';
    12: Result := 'Hebrew';              13: Result := 'Greek';
    14: Result := 'Japanese';            15: Result := 'Korean';
    16: Result := 'Russian';             17: Result := 'Chinese (Simplified)';
    18: Result := 'Chinese (Traditional)'; 19: Result := 'Polish';
    20: Result := 'Thai';                21: Result := 'Norwegian';
    22: Result := 'Portuguese (Portugal)'; 23: Result := 'Hungarian';
  end;
end;

function LangEAId(I: Integer): Integer;
begin
  case I of
    0:  Result := $01;  1:  Result := $13;  2:  Result := $02;  3:  Result := $03;
    4:  Result := $04;  5:  Result := $05;  6:  Result := $06;  7:  Result := $07;
    8:  Result := $08;  9:  Result := $09;  10: Result := $0A;  11: Result := $0B;
    12: Result := $0C;  13: Result := $0D;  14: Result := $0E;  15: Result := $0F;
    16: Result := $10;  17: Result := $11;  18: Result := $12;  19: Result := $14;
    20: Result := $15;  21: Result := $16;  22: Result := $17;  23: Result := $18;
  end;
end;

function GetUserDefaultUILanguage(): Word;
  external 'GetUserDefaultUILanguage@kernel32.dll stdcall';

// Map the Windows primary language id to our combo index (default selection).
function DefaultLangIndex(): Integer;
var
  LangId, Primary, Sub: Integer;
begin
  LangId := GetUserDefaultUILanguage();
  Primary := LangId and $3FF;
  Sub := LangId shr 10;
  case Primary of
    $09: if Sub = 2 then Result := 1 else Result := 0;   // en-GB / en
    $0C: Result := 2;   // fr
    $07: Result := 3;   // de
    $10: Result := 4;   // it
    $0A: Result := 5;   // es
    $1D: Result := 6;   // sv
    $0B: Result := 7;   // fi
    $13: Result := 8;   // nl
    $06: Result := 9;   // da
    $16: if Sub = 2 then Result := 22 else Result := 10; // pt-PT / pt-BR  (sublang 2 = Portugal)
    $05: Result := 11;  // cs
    $0D: Result := 12;  // he
    $08: Result := 13;  // el
    $11: Result := 14;  // ja
    $12: Result := 15;  // ko
    $19: Result := 16;  // ru
    $04: if Sub = 2 then Result := 17 else Result := 18; // zh-CN / zh-TW
    $15: Result := 19;  // pl
    $1E: Result := 20;  // th
    $14: Result := 21;  // no
    $0E: Result := 23;  // hu
  else
    Result := 0;
  end;
end;

// NOTE (pt-BR vs pt-PT): Windows SUBLANG_PORTUGUESE_BRAZILIAN = 1,
// SUBLANG_PORTUGUESE = 2. Above assumes sublang 2 = Portugal. Verify.

// ===========================================================================
// Wizard pages
// ===========================================================================
procedure InitializeWizard();
var
  I: Integer;
  LblLang: TNewStaticText;
begin
  // --- Edition choice (only shown when both are installed) ---
  GEditionPage := CreateInputOptionPage(wpWelcome,
    'Choose Game Version',
    'Multiple versions of The Sims 2 were detected.',
    'Both the Ultimate Collection (or a disc install) and the Legacy Collection are present. Choose which one to set up:',
    True, False);
  GEditionPage.Add('Ultimate Collection / disc install');
  GEditionPage.Add('Legacy Collection');
  GEditionPage.SelectedValueIndex := 0;

  // --- Language selection ---
  GLangPage := CreateCustomPage(GEditionPage.ID,
    'Game Language',
    'Select the language the game should use.');
  LblLang := TNewStaticText.Create(GLangPage);
  LblLang.Parent := GLangPage.Surface;
  LblLang.Caption := 'Language (auto-detected from Windows; change if needed):';
  LblLang.Top := ScaleY(8);
  GLangCombo := TNewComboBox.Create(GLangPage);
  GLangCombo.Parent := GLangPage.Surface;
  GLangCombo.Style := csDropDownList;
  GLangCombo.Top := LblLang.Top + LblLang.Height + ScaleY(8);
  GLangCombo.Width := ScaleX(260);
  for I := 0 to LangCount - 1 do
    GLangCombo.Items.Add(LangName(I));
  GLangCombo.ItemIndex := DefaultLangIndex();

  // --- Download page ---
  GDownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing),
    SetupMessage(msgPreparingDesc), nil);
end;

function InitializeSetup(): Boolean;
var
  HasUC, HasLegacy: Boolean;
begin
  HasUC := DetectUCOrDisc();
  HasLegacy := DetectLegacy();   // NOTE: overwrites GGameRoot if found; edition
                                 // selection re-runs the right detector later.
  if HasUC and HasLegacy then GEdition := edBoth
  else if HasUC then GEdition := edUC
  else if HasLegacy then GEdition := edLegacy
  else GEdition := edNone;

  if GEdition = edNone then
  begin
    MsgBox('No installation of The Sims 2 was detected on this system.' + #13#10 +
           'Install the game first, then run this setup tool again.' + #13#10#13#10 +
           'If your game is installed but not detected, its registry entries may be ' +
           'missing - see the guide''s Troubleshooting page.', mbError, MB_OK);
    Result := False;
    Exit;
  end;

  GUseLegacy := (GEdition = edLegacy);
  Result := True;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := False;
  // Edition page only matters when both versions exist
  if (GEditionPage <> nil) and (PageID = GEditionPage.ID) then
    Result := (GEdition <> edBoth);
end;

// [Components] entries can't use Check:, so grey out rows that don't apply
// to the detected/chosen edition when the components page is shown.
procedure DisableComponentByCaption(const Sub: string);
var
  I: Integer;
begin
  for I := 0 to WizardForm.ComponentsList.Items.Count - 1 do
    if Pos(Sub, WizardForm.ComponentsList.ItemCaption[I]) > 0 then
    begin
      WizardForm.ComponentsList.Checked[I] := False;
      WizardForm.ComponentsList.ItemEnabled[I] := False;
    end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectComponents then
  begin
    if GUseLegacy then
    begin
      DisableComponentByCaption('Sim Shadow Fix');
      DisableComponentByCaption('Bright CAS');
      DisableComponentByCaption('Pink flashing');
      DisableComponentByCaption('Version 2 (safer');
      DisableComponentByCaption('Version 1 (original');
    end;
    if IsDiscLayout() then
      DisableComponentByCaption('Cozy Home');
  end;
end;

// ===========================================================================
// Dependency presence checks (skip downloads/installs already satisfied)
// ===========================================================================
function NeedDotNet48(): Boolean;
var
  Release: Cardinal;
begin
  // .NET Framework 4.8 = Release >= 528040
  Result := not (RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full',
                                    'Release', Release) and (Release >= 528040));
end;

function NeedVCRedistX86(): Boolean;
var
  Installed: Cardinal;
begin
  // VC++ 2015-2022 x86 runtime
  Result := not (RegQueryDWordValue(HKLM32, 'SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\X86',
                                    'Installed', Installed) and (Installed = 1));
end;

// ===========================================================================
// Download & install
// ===========================================================================
var
  GSkippedComponents: string;   // dev build: components whose URL isn't hosted yet
  GHave: TStringList;           // temp file names actually downloaded

// Queue a download unless its URL is still a TODO placeholder.
procedure AddDl(const Url, TmpName: string);
begin
  if Pos('https://TODO', Url) = 1 then
  begin
    if GSkippedComponents <> '' then GSkippedComponents := GSkippedComponents + ', ';
    GSkippedComponents := GSkippedComponents + TmpName;
    Log('Skipping (no URL configured): ' + TmpName);
  end
  else
  begin
    GDownloadPage.Add(Url, TmpName, '');
    GHave.Add(TmpName);
  end;
end;

function Downloaded(const TmpName: string): Boolean;
begin
  Result := GHave.IndexOf(TmpName) >= 0;
end;

procedure AddDownloads();
begin
  GDownloadPage.Clear;
  if GHave = nil then GHave := TStringList.Create;
  GHave.Clear;
  GSkippedComponents := '';
  AddDl('{#UrlGraphicsRules}', 'GraphicsRules.sgr');
  if WizardIsComponentSelected('fixes\cep') then
    AddDl('{#UrlCEP}', 'CEP.zip');
  AddDl('{#UrlPieMenuFix}', 'PieMenu.zip');   // mandatory
  AddDl('{#UrlUIFontsFix}', 'UIFonts.zip');   // mandatory; AL/MG regression persists in Legacy, no scaler conflict
  if not GUseLegacy then
  begin
    if WizardIsComponentSelected('fixes\shadow') then
      AddDl('{#UrlShadowFix}', 'ShadowFix.zip');       // Legacy: EA fixed shadows
    if WizardIsComponentSelected('fixes\brightcas') then
      AddDl('{#UrlBrightCAS}', 'ld_BrightCASFix.package');  // raw package, no extraction
  end;
  if GUseLegacy then
  begin
    AddDl('{#UrlTS2Extender}', 'TS2Extender.zip');
  end
  else
  begin
    AddDl('{#UrlSims2RPC}', 'Sims2RPC.zip');
    if WizardIsComponentSelected('fixes\memcap') then
    begin
      if WizardIsComponentSelected('fixes\memcap\v1') then
        AddDl('{#UrlMemCapV1}', 'TS2MemCapRemover.asi')
      else
        AddDl('{#UrlMemCapV2}', 'TS2MemCapRemover.asi');
    end;
    if NeedDotNet48() then
      AddDl('{#UrlNDP48}', 'ndp48-web.exe');
  end;
  if WizardIsComponentSelected('gfx\hoodfx') then
    AddDl('{#UrlHoodFX}', 'HoodFX.zip');
  if WizardIsComponentSelected('gfx\water') then
  begin
    AddDl('{#UrlWaterAsi}', 'TS2ReflectiveWater.asi');
    AddDl('{#UrlWaterShaders}', 'WaterShaders.zip');
  end;
  if WizardIsComponentSelected('gfx\softshadows') then
  begin
    if WizardIsComponentSelected('gfx\softshadows\no50') then
      AddDl('{#UrlSoftShadow50}', 'SoftShadows.package')
    else if WizardIsComponentSelected('gfx\softshadows\overlap') then
      AddDl('{#UrlSoftShadowOv}', 'SoftShadows.package')
    else
      AddDl('{#UrlSoftShadow100}', 'SoftShadows.package');
  end;
  if WizardIsComponentSelected('lighting\cozyhome') and not IsDiscLayout() then
    AddDl('{#UrlCozyHome}', 'CozyHome.zip');
  if WizardIsComponentSelected('gfx\dxvk') then
    AddDl('{#UrlDXVK}', 'dxvk.tar.gz');
  if NeedVCRedistX86() then
    AddDl('{#UrlVCRedist}', 'vc_redist.x86.exe');

  if GSkippedComponents <> '' then
    MsgBox('Development build: no download source is configured yet for:' + #13#10 +
           GSkippedComponents + #13#10#13#10 +
           'These components will be skipped this run.', mbInformation, MB_OK);
end;

// The game locks its files while running - block install until it's closed.
function GameIsRunning(): Boolean;
var
  Code: Integer;
begin
  Result := Exec(ExpandConstant('{cmd}'),
    '/c tasklist /FI "IMAGENAME eq Sims2EP9.exe" | find /I "Sims2EP9.exe" > nul',
    '', SW_HIDE, ewWaitUntilTerminated, Code) and (Code = 0);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if (CurPageID = wpReady) and GameIsRunning() then
  begin
    MsgBox('The Sims 2 is currently running. Close the game, then click Install again.',
           mbError, MB_OK);
    Result := False;
    Exit;
  end;
  if CurPageID = GEditionPage.ID then
  begin
    GUseLegacy := (GEditionPage.SelectedValueIndex = 1);
    // Re-run the matching detector so GRunPackDir reflects the choice
    if GUseLegacy then DetectLegacy() else DetectUCOrDisc();
  end
  else if CurPageID = wpReady then
  begin
    AddDownloads();
    GDownloadPage.Show;
    try
      try
        GDownloadPage.Download;
      except
        if GDownloadPage.AbortedByUser then
          Log('Download aborted by user.')
        else
          MsgBox('Download failed: ' + AddPeriod(GetExceptionMessage) + #13#10 +
                 'Check your Internet connection and try again.', mbError, MB_OK);
        Result := False;
      end;
    finally
      GDownloadPage.Hide;
    end;
  end;
end;

// --- helpers -----------------------------------------------------------------
function DocsGameDir(): string;
begin
  // Folder names verified on real installs.
  if GUseLegacy then
    Result := AddBackslash(ExpandConstant('{userdocs}')) + 'EA Games\The Sims 2 Legacy'
  else
    Result := AddBackslash(ExpandConstant('{userdocs}')) + 'EA Games\The Sims 2 Ultimate Collection';
  // NOTE: disc installs use "EA Games\The Sims 2" - TODO confirm on a disc system.
end;

function TSBinDir(): string;
begin
  Result := AddBackslash(GRunPackDir) + 'TSBin';
end;

// Base game pack folder. Resolved from the registry (never from folder names,
// which differ across UC/disc layouts and may contain trademark symbols).
function BaseDir(): string;
var
  ExePath: string;
begin
  if GUseLegacy then
    Result := AddBackslash(GGameRoot) + 'Base'
  else if RegQueryStringValue(HKLM32, RegAppPaths + 'Sims2.exe', '', ExePath) then
    Result := ExtractFileDir(ExtractFileDir(ExePath))   // strip \TSBin\Sims2.exe
  else
    Result := '';
end;

function ConfigDir(): string;
begin
  Result := AddBackslash(GRunPackDir) + 'TSData\Res\Config';
end;

procedure ExtractTo(const TmpName, DestDir: string);
begin
  ForceDirectories(DestDir);
  // ArchiveExtraction=full in [Setup] enables zip/7z/etc.
  // FullPaths=True: preserve the archive's folder structure (False flattens it).
  ExtractArchive(ExpandConstant('{tmp}\') + TmpName, DestDir, '', True, nil);
end;

// .tar.gz needs two passes with the 7z decoder: gz -> tar, then tar -> files.
procedure ExtractTarGz(const TmpName, DestDir: string);
var
  Stage: string;
  FindRec: TFindRec;
begin
  Stage := ExpandConstant('{tmp}\_targz');
  ForceDirectories(Stage);
  ExtractArchive(ExpandConstant('{tmp}\') + TmpName, Stage, '', True, nil);
  if FindFirst(AddBackslash(Stage) + '*.tar', FindRec) then
  try
    ForceDirectories(DestDir);
    ExtractArchive(AddBackslash(Stage) + FindRec.Name, DestDir, '', True, nil);
  finally
    FindClose(FindRec);
  end;
end;

// Append Cozy Home's userStartup.cheat additions once (marker-guarded).
procedure MergeUserStartup(const SrcFile: string);
var
  ConfigDirPath, Target, SrcText, Existing: AnsiString;
begin
  if not LoadStringFromFile(SrcFile, SrcText) then Exit;
  ConfigDirPath := AddBackslash(DocsGameDir()) + 'Config';
  ForceDirectories(ConfigDirPath);
  Target := AddBackslash(ConfigDirPath) + 'userStartup.cheat';
  Existing := '';
  if FileExists(Target) then LoadStringFromFile(Target, Existing);
  if Pos('>>> Cozy Home', Existing) = 0 then
    SaveStringToFile(Target,
      Existing + #13#10 + '# >>> Cozy Home lighting >>>' + #13#10 +
      SrcText + #13#10 + '# <<< Cozy Home lighting <<<' + #13#10, False);
end;

// Recursive folder merge (overwrites existing files).
procedure CopyDirTree(const SrcDir, DestDir: string);
var
  FindRec: TFindRec;
begin
  if not DirExists(SrcDir) then Exit;
  ForceDirectories(DestDir);
  if FindFirst(AddBackslash(SrcDir) + '*', FindRec) then
  try
    repeat
      if (FindRec.Name <> '.') and (FindRec.Name <> '..') then
      begin
        if (FindRec.Attributes and FILE_ATTRIBUTE_DIRECTORY) <> 0 then
          CopyDirTree(AddBackslash(SrcDir) + FindRec.Name, AddBackslash(DestDir) + FindRec.Name)
        else
          FileCopy(AddBackslash(SrcDir) + FindRec.Name, AddBackslash(DestDir) + FindRec.Name, False);
      end;
    until not FindNext(FindRec);
  finally
    FindClose(FindRec);
  end;
end;

procedure WriteLanguageRegistry();
var
  EAId: Integer;
begin
  EAId := LangEAId(GLangCombo.ItemIndex);
  if GUseLegacy then
  begin
    RegWriteDWordValue(HKCU, RegLegacyKey + '\1.0', 'language', EAId);
  end
  else
  begin
    RegWriteDWordValue(HKLM32, 'SOFTWARE\EA GAMES\The Sims 2 Fun with Pets Collection\1.0', 'Language', EAId);
    RegWriteDWordValue(HKLM32, 'SOFTWARE\EA GAMES\The Sims 2\1.0', 'Language', EAId);
    RegWriteStringValue(HKLM32, 'SOFTWARE\EA GAMES\The Sims 2\1.0', 'LanguageName', LangName(GLangCombo.ItemIndex));
    // TODO: disc installs write to the newest pack's own key instead of FWP Collection
  end;
end;

procedure CreateShortcuts();
var
  SMDir, RpcExe, SettingsExe, BodyShopExe: string;
begin
  if GUseLegacy or not WizardIsTaskSelected('shortcuts') then Exit;
  RpcExe := AddBackslash(TSBinDir()) + 'Sims2RPC.exe';
  SettingsExe := AddBackslash(TSBinDir()) + 'Sims2RPCSettings.exe';
  BodyShopExe := AddBackslash(GRunPackDir) + 'CSBin\TS2BodyShop.exe';

  SMDir := ExpandConstant('{autoprograms}\The Sims 2');
  ForceDirectories(SMDir);
  CreateShellLink(SMDir + '\The Sims 2 (Sims2RPC).lnk', 'Launch The Sims 2',
    RpcExe, '', TSBinDir(), '', 0, SW_SHOWNORMAL);
  CreateShellLink(SMDir + '\Sims2RPC Settings.lnk', 'Sims2RPC Settings',
    SettingsExe, '', TSBinDir(), '', 0, SW_SHOWNORMAL);
  if FileExists(BodyShopExe) then
    CreateShellLink(SMDir + '\The Sims 2 Body Shop.lnk', 'The Sims 2 Body Shop',
      BodyShopExe, '', ExtractFileDir(BodyShopExe), '', 0, SW_SHOWNORMAL);
  CreateShellLink(ExpandConstant('{autodesktop}\The Sims 2 (Sims2RPC).lnk'),
    'Launch The Sims 2', RpcExe, '', TSBinDir(), '', 0, SW_SHOWNORMAL);
end;

procedure InstallComponents();
var
  Downloads: string;
begin
  Downloads := AddBackslash(DocsGameDir()) + 'Downloads';
  ForceDirectories(Downloads);

  WriteLanguageRegistry();

  // Graphics rules -> run-from pack config (plain text file; back up stock once)
  if Downloaded('GraphicsRules.sgr') then
  begin
    if FileExists(AddBackslash(ConfigDir()) + 'Graphics Rules.sgr')
       and not FileExists(AddBackslash(ConfigDir()) + 'Graphics Rules.sgr.bak') then
      FileCopy(AddBackslash(ConfigDir()) + 'Graphics Rules.sgr',
               AddBackslash(ConfigDir()) + 'Graphics Rules.sgr.bak', False);
    FileCopy(ExpandConstant('{tmp}\GraphicsRules.sgr'),
             AddBackslash(ConfigDir()) + 'Graphics Rules.sgr', False);
  end;

  // Fix packages -> Documents Downloads
  if Downloaded('PieMenu.zip') then
  begin
    ExtractTo('PieMenu.zip', ExpandConstant('{tmp}\piemenu'));
    FileCopy(ExpandConstant('{tmp}\piemenu\LdDarcy_PieMenuTextStringsFix.package'),
             AddBackslash(Downloads) + 'LdDarcy_PieMenuTextStringsFix.package', False);
  end;
  if Downloaded('ShadowFix.zip') then
  begin
    ExtractTo('ShadowFix.zip', ExpandConstant('{tmp}\shadowfix'));
    FileCopy(ExpandConstant('{tmp}\shadowfix\simNopke-simShadowFix-medium.package'),
             AddBackslash(Downloads) + 'simNopke-simShadowFix-medium.package', False);
  end;
  if Downloaded('UIFonts.zip') then
  begin
    ExtractTo('UIFonts.zip', ExpandConstant('{tmp}\uifonts'));
    FileCopy(ExpandConstant('{tmp}\uifonts\al-uifontsfix.package'),
             AddBackslash(Downloads) + 'al-uifontsfix.package', False);
  end;
  if Downloaded('ld_BrightCASFix.package') then
    FileCopy(ExpandConstant('{tmp}\ld_BrightCASFix.package'),
             AddBackslash(Downloads) + 'ld_BrightCASFix.package', False);

  // CEP: GMND -> Downloads, MMAT -> base pack Sims3D, CEP-EXTRA -> Documents + base pack Catalog
  if Downloaded('CEP.zip') then
  begin
    ExtractTo('CEP.zip', ExpandConstant('{tmp}\cep'));
    FileCopy(ExpandConstant('{tmp}\cep\_EnableColorOptionsGMND.package'),
             AddBackslash(Downloads) + '_EnableColorOptionsGMND.package', False);
    CopyDirTree(ExpandConstant('{tmp}\cep\Extras\MyDocuments\zCEP-EXTRA'),
                AddBackslash(DocsGameDir()) + 'zCEP-EXTRA');
    if BaseDir() <> '' then
    begin
      ForceDirectories(AddBackslash(BaseDir()) + 'TSData\Res\Sims3D');
      FileCopy(ExpandConstant('{tmp}\cep\_EnableColorOptionsMMAT.package'),
               AddBackslash(BaseDir()) + 'TSData\Res\Sims3D\_EnableColorOptionsMMAT.package', False);
      CopyDirTree(ExpandConstant('{tmp}\cep\Extras\ProgramFiles\zCEP-EXTRA'),
                  AddBackslash(BaseDir()) + 'TSData\Res\Catalog\zCEP-EXTRA');
    end
    else
      Log('CEP: base game folder not resolved; skipped MMAT/Catalog placement.');
  end;

  if GUseLegacy then
  begin
    if Downloaded('TS2Extender.zip') then
    begin
      // Overlay: TSBin+TSData merge into the EP9 pack, Downloads+Lua into Documents
      ExtractTo('TS2Extender.zip', ExpandConstant('{tmp}\extender'));
      CopyDirTree(ExpandConstant('{tmp}\extender\TSBin'), AddBackslash(GRunPackDir) + 'TSBin');
      CopyDirTree(ExpandConstant('{tmp}\extender\TSData'), AddBackslash(GRunPackDir) + 'TSData');
      CopyDirTree(ExpandConstant('{tmp}\extender\Downloads'), Downloads);
      CopyDirTree(ExpandConstant('{tmp}\extender\Lua'), AddBackslash(DocsGameDir()) + 'Lua');
    end;
  end
  else
  begin
    if Downloaded('Sims2RPC.zip') then
    begin
      ExtractTo('Sims2RPC.zip', TSBinDir());
      // RUNASADMIN compat flags for the RPC executables
      RegWriteStringValue(HKLM, 'SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers',
        AddBackslash(TSBinDir()) + 'Sims2RPC.exe', 'RUNASADMIN');
    end;
    // MemCapRemover: bare .asi -> RPC mods folder
    if Downloaded('TS2MemCapRemover.asi') then
    begin
      ForceDirectories(AddBackslash(TSBinDir()) + 'mods');
      FileCopy(ExpandConstant('{tmp}\TS2MemCapRemover.asi'),
               AddBackslash(TSBinDir()) + 'mods\TS2MemCapRemover.asi', False);
    end;
    if Downloaded('ndp48-web.exe') then
      Exec(ExpandConstant('{tmp}\ndp48-web.exe'), '/q /norestart', '', SW_SHOW, ewWaitUntilTerminated, GExitCode);
  end;

  // VisibleHoodFX: .asi loads via RPC's mods folder (UC) or Ultimate ASI Loader
  // next to the exe (Legacy - Extender's wininet.dll is UAL 9.7.2).
  // Maxis-look shader package -> Downloads either way.
  if Downloaded('HoodFX.zip') then
  begin
    ExtractTo('HoodFX.zip', ExpandConstant('{tmp}\hoodfx'));
    if GUseLegacy then
      CopyDirTree(ExpandConstant('{tmp}\hoodfx\Plugin'), TSBinDir())
    else
      CopyDirTree(ExpandConstant('{tmp}\hoodfx\Plugin'), AddBackslash(TSBinDir()) + 'mods');
    FileCopy(ExpandConstant('{tmp}\hoodfx\Shaders\01 - Maxis\zzz_TS2VisibleHoodFX_Shaders.package'),
             AddBackslash(Downloads) + 'zzz_TS2VisibleHoodFX_Shaders.package', False);
  end;

  // ReflectiveWater: same loading pattern as HoodFX
  if Downloaded('TS2ReflectiveWater.asi') then
  begin
    if GUseLegacy then
      FileCopy(ExpandConstant('{tmp}\TS2ReflectiveWater.asi'),
               AddBackslash(TSBinDir()) + 'TS2ReflectiveWater.asi', False)
    else
    begin
      ForceDirectories(AddBackslash(TSBinDir()) + 'mods');
      FileCopy(ExpandConstant('{tmp}\TS2ReflectiveWater.asi'),
               AddBackslash(TSBinDir()) + 'mods\TS2ReflectiveWater.asi', False);
    end;
  end;
  if Downloaded('WaterShaders.zip') then
  begin
    ExtractTo('WaterShaders.zip', ExpandConstant('{tmp}\watershaders'));
    FileCopy(ExpandConstant('{tmp}\watershaders\01 - Maxis\zzz_Castaway_Shaders.package'),
             AddBackslash(Downloads) + 'zzz_Castaway_Shaders.package', False);
  end;

  // Soft Outdoor Shadows: raw .package -> Downloads, named per chosen variant
  if Downloaded('SoftShadows.package') then
  begin
    if WizardIsComponentSelected('gfx\softshadows\no50') then
      FileCopy(ExpandConstant('{tmp}\SoftShadows.package'),
               AddBackslash(Downloads) + 'ld_SoftShadows_NoOverlap_50.package', False)
    else if WizardIsComponentSelected('gfx\softshadows\overlap') then
      FileCopy(ExpandConstant('{tmp}\SoftShadows.package'),
               AddBackslash(Downloads) + 'ld_SoftShadows_Overlap.package', False)
    else
      FileCopy(ExpandConstant('{tmp}\SoftShadows.package'),
               AddBackslash(Downloads) + 'ld_SoftShadows_NoOverlap_100.package', False);
  end;

  // Cozy Home lighting: edition folder -> game root, 4.0 -> Downloads, cheat merge
  if Downloaded('CozyHome.zip') then
  begin
    ExtractTo('CozyHome.zip', ExpandConstant('{tmp}\cozy'));
    if GUseLegacy then
      CopyDirTree(ExpandConstant('{tmp}\cozy\3.0 - FOR LEGACY COLLECTION USERS'), GGameRoot)
    else
      CopyDirTree(ExpandConstant('{tmp}\cozy\1.0 - FOR ULTIMATE COLLECTION USERS'), GGameRoot);
    CopyDirTree(ExpandConstant('{tmp}\cozy\4.0 - FOR YOUR DOWNLOADS FOLDER'), Downloads);
    MergeUserStartup(ExpandConstant('{tmp}\cozy\userStartup.cheat'));
  end;

  // DXVK: original tar.gz release; 32-bit d3d9.dll -> TSBin, plus a default dxvk.conf
  if Downloaded('dxvk.tar.gz') then
  begin
    ExtractTarGz('dxvk.tar.gz', ExpandConstant('{tmp}\dxvk'));
    FileCopy(ExpandConstant('{tmp}\dxvk\{#DxvkDirName}\x32\d3d9.dll'),
             AddBackslash(TSBinDir()) + 'd3d9.dll', False);
    if not FileExists(AddBackslash(TSBinDir()) + 'dxvk.conf') then
      SaveStringToFile(AddBackslash(TSBinDir()) + 'dxvk.conf',
        'd3d9.maxAvailableMemory = 4096' + #13#10, False);
  end;

  if Downloaded('vc_redist.x86.exe') then
    Exec(ExpandConstant('{tmp}\vc_redist.x86.exe'), '/q /norestart', '', SW_SHOW, ewWaitUntilTerminated, GExitCode);

  CreateShortcuts();
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssPostInstall then
  try
    InstallComponents();
  except
    MsgBox('Setup hit an error while installing components:' + #13#10 +
           GetExceptionMessage + #13#10#13#10 +
           'Some components may not have been installed. See the setup log for details.',
           mbError, MB_OK);
  end;
end;
