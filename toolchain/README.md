# Cross-Compiling mit Clang und Buildroot-Sysroot auf Windows

Diese Anleitung beschreibt, wie du auf **Windows** mit **Clang/LLVM** und einem Buildroot-Sysroot für ARM (armhf) cross-kompilierst. Sie bezieht sich auf die Toolchain- und Konfigurationsdateien in diesem Repository.

---

## 1. Voraussetzungen

- **LLVM/Clang**: Offiziell von [LLVM Releases](https://releases.llvm.org/download.html) oder [LLVM Windows Releases (GitHub)](https://github.com/llvm/llvm-project/releases) herunterladen und installieren. Die Windows-Installer enthalten auch die Tools wie `clang.exe`, `clang++.exe`, `llvm-ar.exe`, `llvm-ranlib.exe`, `llvm-strip.exe` usw.
- **GNU Binutils für ARM** (optional, falls du nicht die LLVM-Tools nutzen willst):
  - Download z.B. von [ARM GNU Toolchain](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads) oder [Linaro Toolchain](https://releases.linaro.org/components/toolchain/binaries/).
- **CMake**: [CMake Download](https://cmake.org/download/)
- **Buildroot**: Wird von diesem Projekt automatisch heruntergeladen und gebaut.

---

## 2. Buildroot-Konfiguration

Die Datei [`configs/clang_sysroot_armhf_defconfig`](../configs/clang_sysroot_armhf_defconfig) enthält eine Beispielkonfiguration für Buildroot, um ein Sysroot für ARM (armhf, Hard Float) zu erzeugen. 

**Wichtige Optionen:**
- Clang als Compiler (`BR2_TOOLCHAIN_BUILDROOT_USE_CLANG=y`)
- glibc als C-Library
- Entwicklungspakete und Header (`BR2_DEVELOPMENT_FILES=y`, `BR2_PACKAGE_LIBC_DEVFILES=y`)
- BusyBox, OpenSSH, etc. für ein minimales RootFS

**RootFS-Erzeugung:**
- Das RootFS wird als Tarball erzeugt und liegt nach dem Build im Buildroot-Output-Verzeichnis.

---

## 3. Sysroot erzeugen

1. **Buildroot herunterladen und konfigurieren:**
   ```sh
   # Beispiel (Linux, analog unter Windows mit Git Bash oder WSL)
   git clone https://github.com/buildroot/buildroot.git
   cd buildroot
   cp ../configs/clang_sysroot_armhf_defconfig .config
   make olddefconfig
   make
   ```
2. **Das erzeugte Sysroot** findest du im Buildroot-Output, z.B. `output/host/arm-buildroot-linux-gnueabihf/sysroot/`.
   - Kopiere dieses Verzeichnis nach Windows, z.B. in `buildrootGenerator/sysroot/`.

---

## 4. LLVM/Clang und Tools installieren

- **LLVM/Clang**: Installiere das LLVM-Release für Windows. Füge das Installationsverzeichnis (z.B. `C:\Program Files\LLVM\bin`) zu deiner `PATH`-Umgebungsvariable hinzu.
- **LLVM-Tools**: Die Tools wie `llvm-ar.exe`, `llvm-ranlib.exe`, `llvm-strip.exe` sind im LLVM-Bin-Verzeichnis enthalten.
- **Optional: GNU Binutils für ARM**: Installiere und füge das Binutils-Verzeichnis zu deinem `PATH` hinzu, falls du die GNU-Tools nutzen willst.

---

## 5. Toolchain-File für CMake


Im Ordner [`toolchain/`](.) findest du die Datei [`toolchain-armhf-windows-clang.cmake`](toolchain-armhf-windows-clang.cmake), die alle nötigen Einstellungen für das Cross-Compiling enthält. Bitte passe Änderungen direkt in dieser Datei an, damit sie konsistent bleibt. Die Datei ist ausreichend kommentiert und enthält Beispiele für die Nutzung von GNU-Binutils oder LLVM-Tools.

---

## 6. Cross-Compiling eines Projekts

1. **Umgebungsvariable setzen:**
   ```powershell
   $env:SYSROOT = "C:\Pfad\zu\deinem\sysroot"
   ```
2. **CMake-Projekt konfigurieren:**
   ```powershell
   cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=toolchain/toolchain-armhf-windows-clang.cmake -B build-armhf
   ```
3. **Bauen:**
   ```powershell
   cmake --build build-armhf
   ```

---

## 7. Hinweise & Troubleshooting

- Prüfe, dass alle Tools (`clang.exe`, `llvm-ar.exe`, etc.) im `PATH` sind.
- Die Umgebungsvariable `SYSROOT` muss auf das Sysroot-Verzeichnis zeigen (keine Backslashes am Ende).
- Fehlende Libraries oder Header im Sysroot? Passe die Buildroot-Konfiguration an und baue neu.
- Für C++17/20 kannst du im Toolchain-File ergänzen:
  ```cmake
  set(CMAKE_CXX_STANDARD 17)
  ```
- Für dynamische oder statische Libraries: Passe die Buildroot-Konfiguration an (`BR2_STATIC_LIBS`).

---

## 8. Weiterführende Links
- [LLVM Releases](https://releases.llvm.org/download.html)
- [LLVM Windows Releases (GitHub)](https://github.com/llvm/llvm-project/releases)
- [Buildroot Doku](https://buildroot.org/docs.html)
- [CMake Cross Compiling](https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html)

---

**Siehe auch die anderen Dateien in diesem Repository für Beispielkonfigurationen und Toolchain-Files!**
