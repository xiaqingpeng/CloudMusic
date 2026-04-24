@echo off
REM Windows 资源验证脚本

echo ==========================================
echo   验证 CloudMusic 资源文件
echo ==========================================
echo.

echo 1. 检查图标文件...
if exist "src\resources\icons\left.svg" (
    echo [OK] left.svg
) else (
    echo [FAIL] left.svg 不存在
)

if exist "src\resources\icons\down.svg" (
    echo [OK] down.svg
) else (
    echo [FAIL] down.svg 不存在
)

if exist "src\resources\icons\down_s.svg" (
    echo [OK] down_s.svg
) else (
    echo [FAIL] down_s.svg 不存在
)

if exist "src\resources\icons\people.svg" (
    echo [OK] people.svg
) else (
    echo [FAIL] people.svg 不存在
)

if exist "src\resources\icons\mic.svg" (
    echo [OK] mic.svg
) else (
    echo [FAIL] mic.svg 不存在
)

if exist "src\resources\icons\setting.svg" (
    echo [OK] setting.svg
) else (
    echo [FAIL] setting.svg 不存在
)

if exist "src\resources\icons\music.svg" (
    echo [OK] music.svg
) else (
    echo [FAIL] music.svg 不存在
)

echo.
echo 2. 检查资源配置文件...
if exist "src\img.qrc" (
    echo [OK] src\img.qrc 存在
    findstr /C:"music.svg" src\img.qrc >nul
    if %errorlevel% == 0 (
        echo [OK] img.qrc 包含图标配置
    ) else (
        echo [WARN] img.qrc 可能缺少图标配置
    )
) else (
    echo [FAIL] src\img.qrc 不存在
)

echo.
echo 3. 检查 CMakeLists.txt...
if exist "CMakeLists.txt" (
    echo [OK] CMakeLists.txt 存在
    findstr /C:"ICON_RESOURCES" CMakeLists.txt >nul
    if %errorlevel% == 0 (
        echo [OK] CMakeLists.txt 包含图标资源配置
    ) else (
        echo [WARN] CMakeLists.txt 可能缺少图标资源配置
    )
) else (
    echo [FAIL] CMakeLists.txt 不存在
)

echo.
echo ==========================================
echo   验证完成
echo ==========================================
echo.
echo 如果所有检查都通过，请重新构建项目：
echo   1. rmdir /s /q build
echo   2. mkdir build ^&^& cd build
echo   3. cmake .. -G "MinGW Makefiles"
echo   4. cmake --build .
echo.
pause
