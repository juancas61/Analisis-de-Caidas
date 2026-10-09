#!/usr/bin/env bash
# ============================================================
# build-package.sh
# Genera el paquete de despliegue para GitHub Pages
# Proyecto: ENEL Prevención de Caídas 2026
# Autor: Juan A. Castillo-M, PhD · ErgoMotion-lab · UR
# ============================================================

set -e

PKG_NAME="enel-prevencion-caidas-2026"
STAGING_DIR="./_build/${PKG_NAME}"
ZIP_NAME="${PKG_NAME}.zip"

echo "🧹 Limpiando builds previos..."
rm -rf "./_build"
mkdir -p "${STAGING_DIR}/.github/workflows"

echo "📄 Copiando archivos..."
# Copia todos los archivos del proyecto excepto los de control
for f in index.html README.md LICENSE .gitignore .nojekyll; do
  if [ -f "$f" ]; then
    cp "$f" "${STAGING_DIR}/"
    echo "  ✓ $f"
  else
    echo "  ⚠ $f no encontrado (se omite)"
  fi
done

# Copia el workflow si existe
if [ -f ".github/workflows/deploy.yml" ]; then
  cp ".github/workflows/deploy.yml" "${STAGING_DIR}/.github/workflows/"
  echo "  ✓ .github/workflows/deploy.yml"
fi

echo "📦 Creando paquete comprimido..."
cd "./_build"
zip -r "../${ZIP_NAME}" "${PKG_NAME}" -x "*.DS_Store" > /dev/null
cd ..

echo ""
echo "✅ Paquete generado: ${ZIP_NAME}"
echo "📁 Ubicación: $(pwd)/${ZIP_NAME}"
echo ""
echo "🚀 Siguiente paso:"
echo "   1. Descomprime ${ZIP_NAME}"
echo "   2. Sube el contenido a tu repositorio de GitHub"
echo "   3. Activa GitHub Pages en Settings → Pages"
echo ""