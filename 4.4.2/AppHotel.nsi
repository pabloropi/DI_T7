; LanzaAyuda.nsi
;
; Pablo Rodríguez Pino 2 DAM

;-------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
; General

  ; Nombre del instalador
  Name "AppHotel"

  ; Nombre del exe
  OutFile "InstallAppHotel.exe"

  ; Requerimos Privilegios de administrados
  RequestExecutionLevel admin



  ; Unicode
  Unicode True

  ; Ruta predeterminada de instalación
  InstallDir $PROGRAMFILES\AppHotel

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

Section "AppHotel" SecComponentes

    ; Directorio de instalacion
    SetOutPath "$INSTDIR"

    ; Ficheros LanzaAyuda
    File /r "AppHotel.7z"
    Nsis7z::ExtractWithCallback "$INSTDIR\AppHotel.7z"
    Delete "$INSTDIR\AppHotel.7z"

    ; Clave de registro
    WriteRegStr HKCU "SOFTWARE\AppHotel" "Install_Dir" "$INSTDIR"

    ; Crea el desisntalador
    WriteUninstaller "$INSTDIR\UninstallAppHotel.exe"

SectionEnd

Section "Start Menu"
  CreateDirectory "$SMPROGRAMS\AppHotel"
  CreateShortcut "$SMPROGRAMS\AppHotel\AppHotel.lnk" "$INSTDIR\sAppHotel.jar"
  CreateShortcut "$SMPROGRAMS\AppHotel\UninstallAppHotel.lnk" "$INSTDIR\UninstallAppHotel.exe"


SectionEnd
;--------------------------------

; Uninstaller
Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKCU "SOFTWARE\AppHotel"

  ; Remove files and uninstaller
  RMDir /r "$INSTDIR"

  ; Remove shortcuts, if any
  Delete "$SMPROGRAMS\AppHotel\AppHotel.lnk"
  Delete "$SMPROGRAMS\AppHotel\UninstallAppHotel.lnk"

  ; Remove directories
  RMDir "$SMPROGRAMS\AppHotel"
  RMDir "$INSTDIR"

SectionEnd


