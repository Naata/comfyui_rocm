#!/bin/bash

set

cm-cli restore-dependencies

echo "main.py --listen 0.0.0.0 --port $PORT $COMFYUI_ARGS" | xargs python 