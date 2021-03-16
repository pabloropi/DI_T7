; LanzaAyuda.nsi
;
; Pablo Rodríguez Pino 2 DAM

;-------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
; General

  ; Nombre del instalador
  Name "LanzaAyuda"

  ; Nombre del exe
  OutFile "InstallAyuda.exe"

  ; Requerimos Privilegios de administrados
  RequestExecutionLevel admin



  ; Unicode
  Unicode True

  ; Ruta predeterminada de instalación
  InstallDir $PROGRAMFILES\LanzaAyuda

;--------------------------------
; Configuracion del instalador

  !define MUI_ABORTWARNING

;--------------------------------
; Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;-----------------------------------
; Lenguaje

  !insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------

; Secciones

Section "LanzaAyuda" SecComponentes

    ; Directorio de instalacion
    SetOutPath "$INSTDIR"

    ; Ficheros LanzaAyuda
    File /r "LanzaAyuda.7z"
    Nsis7z::ExtractWithCallback "$INSTDIR\LanzaAyuda.7z"
    Delete "$INSTDIR\LanzaAyuda.7z"

    ; Clave de registro
    WriteRegStr HKCU "SOFTWARE\LanzaAyuda" "Install_Dir" "$INSTDIR"

    ; Crea el desisntalador
    WriteUninstaller "$INSTDIR\UninstallLanzaAyuda.exe"

SectionEnd

Section "Start Menu"
  CreateDirectory "$SMPROGRAMS\LanzaAyuda"
  CreateShortcut "$SMPROGRAMS\LanzaAyuda\LanzaAyuda.lnk" "$INSTDIR\LanzaAyuda.jar"
  CreateShortcut "$SMPROGRAMS\LanzaAyuda\UninstallLanzaAyuda.lnk" "$INSTDIR\UninstallLanzaAyuda.exe"


SectionEnd
;--------------------------------

; Uninstaller
Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKCU "SOFTWARE\LanzaAyuda"

  ; Remove files and uninstaller
  Delete "$INSTDIR\lib\javahelp-2.0.05.jar"
  RMDir "$INSTDIR\lib"
  Delete "$INSTDIR\UninstallLanzaAyuda.exe"
  Delete "$INSTDIR\README.TXT"
  Delete "$INSTDIR\LanzaAyuda.jar"

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\LanzaAyuda\UninstallLanzaAyuda.lnk"
  Delete "$SMPROGRAMS\LanzaAyuda\LanzaAyuda.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\LanzaAyuda"
  RMDir "$INSTDIR"

SectionEnd


