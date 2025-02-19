# VS Code Arm Cortex Development

## Overview

This repository provides a setup for developing on Arm Cortex-M processors using VS Code. The development environment is containerized with Docker, and debugging is facilitated through the Segger J-Link remote server and client. To ensure consistency across multiple projects, this setup is included as a Git submodule within your project repository.

### Features
- Build C and C++ projects using ARM GCC (arm-none-eabi)
- Code linting with Clangd
- Code formatting with Clang-Format
- Code style checking with Clang-Tidy
- Debugging via Segger J-Link remote server
- Code analysis and visualization with Clang-UML
- Spell Checking
- Standard git tools

## Required Installations

### Operating System (Windows 10)
- Docker Desktop
- Windows Subsystem for Linux (WSL)
- Visual Studio Code (VS Code)
- Segger J-Link Tools

### VS Code Extensions
- Dev Containers
- WSL

## Setting Up a New Project

1. Create a Git repository in your WSL environment.
2. Add this repository as a Git submodule and name it `arm_setup` (don't put it into a sub directory to avoid changing paths).
    ```git
    git submodule add https://github.com/ch-r-k/arm_m_setup arm_setup
    git submodule update --init --recursive
    ```
3. Create symbolic links for `.vscode` and `.devcontainer` manually or by running `setup.sh`.
    ```sh
    sudo bash arm_setup/setup.sh 
    ```
4. Open VS Code in your project directory and reopen it inside the container (all tools and vscode extensions should be installed automatically for the container).
5. Add your source code in the project repository.

## Building a Project

1. Configure your build system (CMake is recommended) and select the ARM GCC compiler. The CMake toolchain file is located at `cmake/arm-gcc-toolchain.cmake`.
2. Build your project using one of the following methods:
   - Press `F7`
   - Use `Ctrl+Shift+B`
   - Open the VS Code Command Palette and select the build command

## Debugging a Project

1. If you use CMake, add the following lines to your `CMakeLists.txt`:
   ```cmake
   set (JLINK_IP_FILE "${CMAKE_CURRENT_LIST_DIR}/jlink_ip.cmake")
   if (EXISTS "${JLINK_IP_FILE}")
       include("${JLINK_IP_FILE}")
   endif ()

   set(LAUNCH_FILE_INTERMEDIATE "${CMAKE_CURRENT_BINARY_DIR}/launch.json.in")
   configure_file("${CMAKE_CURRENT_LIST_DIR}/arm_setup/cmake/launch.json.in" ${LAUNCH_FILE_INTERMEDIATE} @ONLY)

   file(GENERATE
       OUTPUT "${CMAKE_CURRENT_LIST_DIR}/.vscode/launch.json"
       INPUT ${LAUNCH_FILE_INTERMEDIATE}
   )
   ```
   This ensures the J-Link IP address is set and that the `launch.json` file for VS Code is generated.

2. Connect your J-Link debugger to your local machine via USB and to your target device.
3. Start the J-Link remote server on your local machine. The containerized client will connect to this server, so setting the J-Link IP address is necessary.
4. Begin debugging by pressing `F5` or using the debugging window in VS Code.

## Building and Publishing a Docker Image

To create a Docker image from the `Dockerfile` and publish it on Docker Hub, run the following commands:

```sh
# Build the Docker image
docker build -t ch0r0k/arm-gcc-development .

# Tag the Docker image with a version
docker tag ch0r0k/arm-gcc-development ch0r0k/arm-gcc-development:v1.0

# Push the image to Docker Hub
docker push ch0r0k/arm-gcc-development:v1.0
```

This setup ensures a robust and reproducible development environment for Arm Cortex-M projects in VS Code.

