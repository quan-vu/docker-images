#!/bin/sh

# Inpotant: export python packages from image: python:3.6
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.6/site-packages

if [ "$1" = "1" ]; then
    python3 /cronpy/test/app.py
fi