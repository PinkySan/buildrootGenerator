---
mode: agent
---
# Anforderungen

Es soll ein sysroot und ein rootfs erstellt werden, die die notwendigen Bibliotheken und Header-Dateien für die Cross-Kompilation enthalten.
Um dies zu erreichen, müssen die folgenden Schritte durchgeführt werden:
1. Es muss eine defconfig-Datei erstellt werden, die die notwendigen Informationen für die Cross-Kompilation enthält.
2. Als Compiler muss `clang` verwendet werden.
3. Clang darf nicht selber gebaut werden, sondern muss als externer Compiler verwendet werden.
4. Es muss kein Kernel kompiliert werden.
5. Das rootfs muss und die defconfig-Datei sollen minimal sein
6. Das sysroot muss während des erstellen des rootfs erstellt werden.
7. Die defconfig-Datei soll in einem Verzeichnis `configs` liegen.
8. ssh muss mit gebaut werden