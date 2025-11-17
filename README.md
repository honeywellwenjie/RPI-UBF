# RPI‑UBF (UniversalBuild Framework of Raspberry Pi)

RPI‑UBF is a **complete, modular, automated build framework** for creating customized Raspberry Pi OS images, cross‑compiling ARM binaries, packaging them as Debian packages, and finally assembling everything into a bootable `.img` file.

Its goal is simple:

➡ **You focus on your product logic.**

1 No more manual image hacking
2 No more fighting with cross‑compiler setups
3 No more “copy this folder into rootfs and pray” workflows

Instead:

1 Build ARM binaries on ANY x86 Linux PC
2 Package them into clean `.deb` files
3 Auto‑inject them into a Raspberry Pi OS image
4 Produce repeatable, version‑controlled firmware images

---

## 🔹 Project Directory Layout

```
RPI-UBF
│
├── cross-compiler      → Docker-based ARM cross build environment
│   └── Makefile        → Builds the toolchain container
│
├── src-code            → All source code that goes into final image
│   └── test/hello.c    → Example program
│
├── debian-packages     → Build system for .deb packages
│   └── hello/DEBIAN    → Example control files
│
├── os-image            → Image processing pipeline
│   └── image-script/   → rootfs unpack / pack / chroot scripts
│
└── Makefile            → One‑command full build entry
```

---

## 🔹 Core Components

### **Cross Compiler (Docker‑based)**
- Runs on **x86 Ubuntu / Debian / WSL2 / GitHub CI**
- Produces **ARMv7 binaries** even if you don’t own a Pi
- No toolchain installation required

Build with:
```
make -C cross-compiler
```

Then compile code:
```
docker run --platform=linux/arm/v7 -v $(pwd):/work rpibuild gcc hello.c -o hello
```

---

### **Debian Package Builder**

Everything you install into the image is packaged as a proper `.deb`.

Advantages:
- Clean versioning and upgrades
- No need to manually copy files
- Fully removed with `dpkg -P`

Example output:
```
debian-packages/output_deb/hello.deb
```

---

### **OS Image Pipeline**

Scripts under `os-image/image-script/` let you:

| Script | Purpose |
|--------|---------|
| `download_images.sh` | Download and verify base Raspberry Pi OS image |
| `prepare_image.sh` | Extract `.img.xz` into a usable `.img` |
| `unpack_rootfs.sh` | Mount partition → extract rootfs into ./rootfs |
| `chroot_exec.sh` | Execute commands inside the ARM rootfs (with qemu) |
| `pack_rootfs.sh` | Write modified rootfs back into `.img` |

**End workflow example:**
```
make
→ Build cross compiler
→ Build hello.deb
→ Download RPi OS
→ Inject .deb
→ Produce bootable fw image
```

---

## 🔹 Example: Modify Image & Verify Change

```
cd os-image/image-script
./unpack_rootfs.sh ../cache/raspios.img
sudo ./chroot_exec.sh "touch /root/WORKED"
./pack_rootfs.sh ../cache/raspios.img
```

Then flash the image → boot → check:
```
ls /root/WORKED
```
✔ = build pipeline success

---

## 🔹 Why This Project Is Useful

### **✔ Fully Reproducible Firmware Builds**
No “mystery SD card” situation — all firmware is built **from source + scripts only**.

### **✔ No Host Contamination**
All compilation happens inside Docker, all OS modifications inside a mounted loop image.

### **✔ Clean Life‑Cycle**
- Source → `.deb`
- `.deb` → filesystem
- filesystem → `.img`

Everything is **traceable and diff‑able**.

### **✔ Works On CI / Cloud**
Can be integrated into GitHub Actions → auto‑produce nightly OS images.

---

## 🔹 Ideal Use Cases

Building IoT appliances

Commercial Raspberry Pi products with OTA updates

Mass‑deployment images for fleet systems

Anyone tired of manual `chroot` image hacking

---

## 🔹 Build Everything (One Command)

```
make
```

Produces:
```
output/rpi-build.img
```

Flash it:
```
sudo dd if=rpi-build.img of=/dev/sdX bs=512 status=progress
sync
```

---

## License

This project is licensed under the Apache License 2.0 with an additional attribution requirement.

You must retain the following author credit in all copies or substantial portions of the software:

    Original Author: Wenjie Zhang

See the [LICENSE](./LICENSE) file for full details.

