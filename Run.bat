@echo off
cd /d "%~dp0"

set json_file=%~dp0Release.json
set webpage_url=https://raw.githubusercontent.com/Sham-bless/ReCrash/main/Release.json

for /f "tokens=*" %%a in ('type "%json_file%" ^| findstr /v "^[[:space:]]*$"') do set json_text=%%a

certutil -urlcache -split -f %webpage_url% webpage.tmp
for /f "tokens=*" %%a in ('type webpage.tmp ^| findstr /v "^[[:space:]]*$"') do set webpage_text=%%a
del webpage.tmp

if "%json_text%" == "%webpage_text%" ( 
	python "bin\Client.py"
) else (
	cd /d bin
	del Client.py
	
	curl -o Client.py https://raw.githubusercontent.com/Sham-bless/ReCrash/main/bin/Client.py
	python "Client.py"
)
