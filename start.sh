#!/usr/bin/env bash
# Levanta el entorno del curso y abre JupyterLab en el navegador.
# Uso:  ./start.sh
set -euo pipefail

# Trabajar siempre desde la carpeta del proyecto, sin importar desde dónde se invoque.
cd "$(dirname "${BASH_SOURCE[0]}")"

VENV=".venv"
PY="$VENV/bin/python"

# 1. Entorno virtual
if [ ! -x "$PY" ]; then
  echo "==> Creando entorno virtual en $VENV"
  python3 -m venv "$VENV"
fi

# 2. Dependencias: se instalan solo si falta alguna (arranque rápido en sesiones siguientes)
if ! "$PY" -c "import anthropic, dotenv, jupyterlab" >/dev/null 2>&1; then
  echo "==> Instalando dependencias desde requirements.txt"
  "$PY" -m pip install --upgrade pip
  "$PY" -m pip install -r requirements.txt
fi

# 3. Clave de API
if [ ! -f .env ]; then
  echo "!! No existe .env. Copiando .env.example; pon tu ANTHROPIC_API_KEY ahí antes de ejecutar el notebook."
  cp .env.example .env
fi

# 4. JupyterLab: explorador de archivos a la izquierda + notebooks a la derecha.
echo "==> Iniciando JupyterLab (Ctrl+C para detenerlo)"
exec "$VENV/bin/jupyter" lab
