#!/bin/bash
# kali
# root
RUTA1="/root/path/to/venv/bin/activate"
RUTA2="/root/Nexus/venv/bin/activate"

if [ -f "$RUTA1" ]; then
    source "$RUTA1"
    echo "[] Entorno activado desde: path/to/venv"
elif [ -f "$RUTA2" ]; then
    source "$RUTA2"
    echo "[] Entorno activado desde: Nexus/venv"
else
    # kernel
    EXTRA=$(find /root -name "activate" -path "*/bin/*" | head -n 1)
    if [ -n "$EXTRA" ]; then
        source "$EXTRA"
        echo "[✔] Entorno detectado en ruta alterna: $EXTRA"
    else
        echo "[!] ERROR: No se encontró el venv. Ejecuta: python3 -m venv /root/Nexus/venv"
        exit 1
    fi
fi
export PYTHONPATH=$PYTHONPATH:$(pwd)
# string
if [ -f "/root/GhostTrack/GhostTR.py" ]; then
    echo "[*] Iniciando GhostTrack..."
    python3 /root/GhostTrack/GhostTR.py
else
    echo "[!] Error: GhostTR.py no está en /root/GhostTrack/"
fi































 