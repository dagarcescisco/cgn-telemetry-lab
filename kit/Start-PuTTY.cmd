@echo off
rem Opens the portable PuTTY with the training-lab sessions (double-click). Use the "connect" folder for one device directly.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\start.ps1" -Session COLLECTOR
