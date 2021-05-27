#/usr/bin/env bash

sed -i 's|glslang/glslang|glslang|' src/gpu.cpp

if ! grep -q "set(CMAKE_EXPORT_COMPILE_COMMANDS ON)" "CMakeLists.txt"; then
  sed -i "1i set(CMAKE_EXPORT_COMPILE_COMMANDS ON)" ./CMakeLists.txt
fi

cmake -B build -S . -DCMAKE_BUILD_TYPE='None' -DCMAKE_INSTALL_PREFIX=/usr -DNCNN_BUILD_EXAMPLES=ON -DNCNN_BUILD_TOOLS=ON -DNCNN_VULKAN=ON -DNCNN_SYSTEM_GLSLANG=ON -DGLSLANG_TARGET_DIR=/usr/lib/cmake/ -Wno-dev -DNCNN_BUILD_TESTS=ON

make -C build
ln -sfn build/compile_commands.json compile_commands.json
