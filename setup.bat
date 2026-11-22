@echo off
rem Prepara el proyecto: crea la carpeta android\ y genera el codigo de Drift.
cd /d "%~dp0"

if not exist android (
  call flutter create --platforms=android --project-name tu_solution --org com.tusolution _tmp_scaffold || exit /b 1
  xcopy /E /I /Y _tmp_scaffold\android android
  copy /Y _tmp_scaffold\.metadata .metadata
  rmdir /S /Q _tmp_scaffold
)

call flutter pub get
call dart run build_runner build --delete-conflicting-outputs
echo Listo. Ejecuta: flutter run
