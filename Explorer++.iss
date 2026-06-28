[Setup]
AppName=Explorer++
AppVersion=1.0
DefaultDirName={autopf}\Explorer++
DefaultGroupName=Explorer++
; Changed to "explorerpp_setup" to avoid the "setup.exe" shim vulnerability
OutputBaseFilename=explorerpp_setup
; Changed "x64" to "x64compatible" for modern compatibility
ArchitecturesInstallIn64BitMode=x64compatible arm64
ArchitecturesAllowed=x86 x64compatible arm64
OutputDir=Bin\Installer
Compression=lzma2
SolidCompression=yes

[Tasks]
Name: "addtopath"; Description: "Add Explorer++ to your system PATH"; GroupDescription: "Other tasks:"; Flags: unchecked

[Registry]
; Modifies the System-wide environment variable
Root: HKLM; Subkey: "System\CurrentControlSet\Control\Session Manager\Environment"; \
    ValueType: expandsz; ValueName: "Path"; ValueData: "{olddata};{app}"; \
    Check: NeedsAddPath(ExpandConstant('{app}')); Tasks: addtopath
    
[Code]
function NeedsAddPath(Param: String): Boolean;
var
  OrigPath: String;
begin
  if not RegQueryStringValue(HKEY_LOCAL_MACHINE, 'System\CurrentControlSet\Control\Session Manager\Environment', 'Path', OrigPath) then
    OrigPath := '';
  Result := Pos(';' + Uppercase(Param) + ';', ';' + Uppercase(OrigPath) + ';') = 0;
end;

[Types]
Name: "full"; Description: "Full installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "main"; Description: "Main Application"; Types: full custom; Flags: fixed
Name: "lang"; Description: "Translations"; Types: full custom
Name: "lang\ar"; Description: "Arabic (AR_AE)"; Types: full custom
Name: "lang\ca"; Description: "Catalan (CA)"; Types: full custom
Name: "lang\cs"; Description: "Czech (CS)"; Types: full custom
Name: "lang\da"; Description: "Danish (DA)"; Types: full custom
Name: "lang\de"; Description: "German (DE)"; Types: full custom
Name: "lang\el"; Description: "Greek (EL)"; Types: full custom
Name: "lang\es"; Description: "Spanish (ES)"; Types: full custom
Name: "lang\fa"; Description: "Persian (FA)"; Types: full custom
Name: "lang\fi"; Description: "Finnish (FI)"; Types: full custom
Name: "lang\fr"; Description: "French (FR)"; Types: full custom
Name: "lang\he"; Description: "Hebrew (HE)"; Types: full custom
Name: "lang\hu"; Description: "Hungarian (HU)"; Types: full custom
Name: "lang\it"; Description: "Italian (IT)"; Types: full custom
Name: "lang\ja"; Description: "Japanese (JA)"; Types: full custom
Name: "lang\ko"; Description: "Korean (KO)"; Types: full custom
Name: "lang\nl"; Description: "Dutch (NL)"; Types: full custom
Name: "lang\no"; Description: "Norwegian (NO)"; Types: full custom
Name: "lang\pl"; Description: "Polish (PL)"; Types: full custom
Name: "lang\pt"; Description: "Portuguese (PT)"; Types: full custom
Name: "lang\ptbr"; Description: "Portuguese (PT_BR)"; Types: full custom
Name: "lang\ro"; Description: "Romanian (RO)"; Types: full custom
Name: "lang\ru"; Description: "Russian (RU)"; Types: full custom
Name: "lang\si"; Description: "Sinhala (SI)"; Types: full custom
Name: "lang\sv"; Description: "Swedish (SV)"; Types: full custom
Name: "lang\tr"; Description: "Turkish (TR)"; Types: full custom
Name: "lang\uk"; Description: "Ukrainian (UK)"; Types: full custom
Name: "lang\vi"; Description: "Vietnamese (VI)"; Types: full custom
Name: "lang\zhcn"; Description: "Chinese (ZH_CN)"; Types: full custom
Name: "lang\zhtw"; Description: "Chinese (ZH_TW)"; Types: full custom

[Files]
; --- Main Binaries (Architecture-specific) ---
Source: "Bin\Win32\Release\Explorer++.exe"; DestDir: "{app}"; Check: IsX86; Components: main
Source: "Bin\x64\Release\Explorer++.exe"; DestDir: "{app}"; Check: IsX64Compatible; Components: main
Source: "Bin\ARM64\Release\Explorer++.exe"; DestDir: "{app}"; Check: IsARM64; Components: main

; --- Translation DLLs (Architecture-specific & Conditional) ---
; AR_AE
Source: "Bin\Win32\Release\Explorer++AR_AE.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ar
Source: "Bin\x64\Release\Explorer++AR_AE.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ar
Source: "Bin\ARM64\Release\Explorer++AR_AE.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ar
; CA
Source: "Bin\Win32\Release\Explorer++CA.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ca
Source: "Bin\x64\Release\Explorer++CA.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ca
Source: "Bin\ARM64\Release\Explorer++CA.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ca
; CS
Source: "Bin\Win32\Release\Explorer++CS.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\cs
Source: "Bin\x64\Release\Explorer++CS.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\cs
Source: "Bin\ARM64\Release\Explorer++CS.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\cs
; DA
Source: "Bin\Win32\Release\Explorer++DA.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\da
Source: "Bin\x64\Release\Explorer++DA.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\da
Source: "Bin\ARM64\Release\Explorer++DA.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\da
; DE
Source: "Bin\Win32\Release\Explorer++DE.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\de
Source: "Bin\x64\Release\Explorer++DE.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\de
Source: "Bin\ARM64\Release\Explorer++DE.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\de
; EL
Source: "Bin\Win32\Release\Explorer++EL.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\el
Source: "Bin\x64\Release\Explorer++EL.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\el
Source: "Bin\ARM64\Release\Explorer++EL.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\el
; ES
Source: "Bin\Win32\Release\Explorer++ES.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\es
Source: "Bin\x64\Release\Explorer++ES.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\es
Source: "Bin\ARM64\Release\Explorer++ES.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\es
; FA
Source: "Bin\Win32\Release\Explorer++FA.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\fa
Source: "Bin\x64\Release\Explorer++FA.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\fa
Source: "Bin\ARM64\Release\Explorer++FA.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\fa
; FI
Source: "Bin\Win32\Release\Explorer++FI.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\fi
Source: "Bin\x64\Release\Explorer++FI.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\fi
Source: "Bin\ARM64\Release\Explorer++FI.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\fi
; FR
Source: "Bin\Win32\Release\Explorer++FR.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\fr
Source: "Bin\x64\Release\Explorer++FR.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\fr
Source: "Bin\ARM64\Release\Explorer++FR.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\fr
; HE
Source: "Bin\Win32\Release\Explorer++HE.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\he
Source: "Bin\x64\Release\Explorer++HE.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\he
Source: "Bin\ARM64\Release\Explorer++HE.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\he
; HU
Source: "Bin\Win32\Release\Explorer++HU.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\hu
Source: "Bin\x64\Release\Explorer++HU.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\hu
Source: "Bin\ARM64\Release\Explorer++HU.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\hu
; IT
Source: "Bin\Win32\Release\Explorer++IT.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\it
Source: "Bin\x64\Release\Explorer++IT.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\it
Source: "Bin\ARM64\Release\Explorer++IT.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\it
; JA
Source: "Bin\Win32\Release\Explorer++JA.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ja
Source: "Bin\x64\Release\Explorer++JA.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ja
Source: "Bin\ARM64\Release\Explorer++JA.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ja
; KO
Source: "Bin\Win32\Release\Explorer++KO.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ko
Source: "Bin\x64\Release\Explorer++KO.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ko
Source: "Bin\ARM64\Release\Explorer++KO.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ko
; NL
Source: "Bin\Win32\Release\Explorer++NL.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\nl
Source: "Bin\x64\Release\Explorer++NL.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\nl
Source: "Bin\ARM64\Release\Explorer++NL.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\nl
; NO
Source: "Bin\Win32\Release\Explorer++NO.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\no
Source: "Bin\x64\Release\Explorer++NO.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\no
Source: "Bin\ARM64\Release\Explorer++NO.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\no
; PL
Source: "Bin\Win32\Release\Explorer++PL.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\pl
Source: "Bin\x64\Release\Explorer++PL.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\pl
Source: "Bin\ARM64\Release\Explorer++PL.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\pl
; PT
Source: "Bin\Win32\Release\Explorer++PT.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\pt
Source: "Bin\x64\Release\Explorer++PT.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\pt
Source: "Bin\ARM64\Release\Explorer++PT.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\pt
; PT_BR
Source: "Bin\Win32\Release\Explorer++PT_BR.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ptbr
Source: "Bin\x64\Release\Explorer++PT_BR.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ptbr
Source: "Bin\ARM64\Release\Explorer++PT_BR.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ptbr
; RO
Source: "Bin\Win32\Release\Explorer++RO.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ro
Source: "Bin\x64\Release\Explorer++RO.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ro
Source: "Bin\ARM64\Release\Explorer++RO.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ro
; RU
Source: "Bin\Win32\Release\Explorer++RU.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\ru
Source: "Bin\x64\Release\Explorer++RU.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\ru
Source: "Bin\ARM64\Release\Explorer++RU.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\ru
; SI
Source: "Bin\Win32\Release\Explorer++SI.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\si
Source: "Bin\x64\Release\Explorer++SI.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\si
Source: "Bin\ARM64\Release\Explorer++SI.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\si
; SV
Source: "Bin\Win32\Release\Explorer++SV.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\sv
Source: "Bin\x64\Release\Explorer++SV.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\sv
Source: "Bin\ARM64\Release\Explorer++SV.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\sv
; TR
Source: "Bin\Win32\Release\Explorer++TR.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\tr
Source: "Bin\x64\Release\Explorer++TR.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\tr
Source: "Bin\ARM64\Release\Explorer++TR.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\tr
; UK
Source: "Bin\Win32\Release\Explorer++UK.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\uk
Source: "Bin\x64\Release\Explorer++UK.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\uk
Source: "Bin\ARM64\Release\Explorer++UK.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\uk
; VI
Source: "Bin\Win32\Release\Explorer++VI.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\vi
Source: "Bin\x64\Release\Explorer++VI.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\vi
Source: "Bin\ARM64\Release\Explorer++VI.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\vi
; ZH_CN
Source: "Bin\Win32\Release\Explorer++ZH_CN.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\zhcn
Source: "Bin\x64\Release\Explorer++ZH_CN.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\zhcn
Source: "Bin\ARM64\Release\Explorer++ZH_CN.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\zhcn
; ZH_TW
Source: "Bin\Win32\Release\Explorer++ZH_TW.dll"; DestDir: "{app}"; Check: IsX86; Components: lang\zhtw
Source: "Bin\x64\Release\Explorer++ZH_TW.dll"; DestDir: "{app}"; Check: IsX64Compatible; Components: lang\zhtw
Source: "Bin\ARM64\Release\Explorer++ZH_TW.dll"; DestDir: "{app}"; Check: IsARM64; Components: lang\zhtw

; --- Documentation (Shared) ---
Source: "Docs\User\History.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Docs\User\License.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Docs\User\Readme.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Docs\Explorer++ Help.chm"; DestDir: "{app}"; Flags: ignoreversion

; Include Scripts directory and all contents
Source: "Scripts\*"; DestDir: "{app}\Scripts"; Flags: ignoreversion recursesubdirs createallsubdirs

; Include Plugins directory and all contents
Source: "Plugins\*"; DestDir: "{app}\Plugins"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\Explorer++"; Filename: "{app}\Explorer++.exe"