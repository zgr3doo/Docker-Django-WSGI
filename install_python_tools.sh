#!/bin/sh

wget "https://bootstrap.pypa.io/get-pip.py"
python get-pip.py

pip install django
pip install django-debug-toolbar
pip install selenium