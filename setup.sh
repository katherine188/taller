#!/usr/bin/env bash
# Prepara el proyecto: crea la carpeta android/ y genera el código de Drift.
set -e
cd "$(dirname "$0")"

if [ ! -d android ]; then
  flutter create --platforms=android --project-name tu_solution --org com.tusolution _tmp_scaffold
  cp -r _tmp_scaffold/android ./android
  cp _tmp_scaffold/.metadata ./.metadata
  rm -rf _tmp_scaffold
fi

flutter pub get
dart run build_runner build --delete-conflicting-outputs
echo "Listo. Ejecuta: flutter run"
