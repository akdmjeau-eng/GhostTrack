#!/bin/bash
# kali
# root
RUTA1="/root/path/to/venv/bin/activate"
RUTA2="/root/Nexus/venv/bin/activate"
if [ -f "$ROUTE1" ]; then
    source "$ROUTE1"
    echo "[] environment activated from: path/to/venv"
elif [ -f "$ROUTE2" ]; then
    source "$ROUTE2"
    echo "[] environment activated from: Nexus/venv"
else
    # kernel
    EXTRA=$(find /root -name "activate" -path "*/bin/*" | head -n 1)
    if [ -n "$EXTRA" ]; then
        source "$EXTRA"
        echo "[✔] environment finding on another route: $EXTRA"
    else
        echo "[!] MISTAKE: not found venv. execute: python3 -m venv /root/Nexus/venv"
        exit 1
    fi
fi
export PYTHONPATH=$PYTHONPATH:$(pwd)
# string
if [ -f "/root/GhostTrack/GhostTR.py" ]; then
    echo "[*] start GhostTrack"
    python3 /root/GhostTrack/GhostTR.py
else
    echo "[!] Mistake: GhostTR.py is not in /root/GhostTrack/"
fi
