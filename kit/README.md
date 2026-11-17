# CGN & Telemetry Training Lab: Student Kit

Everything you need on the machine you use during the training (your laptop connected through the VPN, or the dCloud Workstation).

> Use the ZIP **`cgn-telemetry-student-kit.zip`** from the Releases page of the repository. It includes the portable `putty.exe`; the `kit/` folder of the repository alone does not.

| Folder / file | What it is |
|---|---|
| `guides/` | The lab guides (PDF): Access Guide, Lab 1, Lab 2, Lab 3, Study Guides 1 to 5 and the optional Build Guide |
| `Start-PuTTY.cmd` | Opens the portable PuTTY with the sessions already configured (no installation) |
| `connect/` | One shortcut per device: double-click `PE-A.cmd` to land on PE-A directly |
| `putty/` | Portable PuTTY (`putty.exe`) and its session definitions |
| `ssh_config` | The same access for OpenSSH (`ssh pe-a`), if you prefer it to PuTTY |

## Quick start (Windows)

1. Connect the VPN of your dCloud session (see the Access Guide) and start the lab of the day in CML.
2. Unzip this kit on your **Desktop** (right-click the ZIP, *Extract All*, choose the Desktop; or use the PowerShell command in the repository README). Do not run it from inside the ZIP.
3. Double-click **`Start-PuTTY.cmd`**. It opens PuTTY with the list of saved sessions and creates, on your Desktop, **CGN Lab - PuTTY** (the session list), **CGN Lab - Guides** and a folder **CGN Lab - Devices** with one shortcut per device (COLLECTOR, CORE, PE-A ...): use them from now on. PuTTY asks you to accept the SSH host key of each machine the first time you reach it (the COLLECTOR, and then the device if you go through it): click **Accept**.
4. Double-click a session in the list (COLLECTOR, CORE, PE-A ...), or open its shortcut from the Desktop folder **CGN Lab - Devices** (or the `connect` folder of the kit).

Every lab device accepts user `cisco`, password `cisco`. PuTTY sends it for you.

## How the devices are reached

The devices live on the lab management network (10.250.0.0/24), which is only reachable from the COLLECTOR. The sessions in this kit use the COLLECTOR as a **jump host** (PuTTY option *SSH to proxy and use port forwarding*), so a device session opens in one step.

| Session | Address | Platform |
|---|---|---|
| COLLECTOR | 198.18.128.3 (direct) | Ubuntu: `labcheck`, `traffic`, `getyang`, Docker stack |
| CORE | 10.250.0.11 | IOS XE (IOL) |
| PE-A, PE-B | 10.250.0.12, 10.250.0.13 | IOS XR |
| CGN-A1, CGN-B1 | 10.250.0.14, 10.250.0.15 | IOS XE (C8000V) |
| SUB, INET-SRV | 10.250.0.16, 10.250.0.17 | Linux hosts |
| PE-ACC | 10.250.0.18 | IOS XE (IOL) |

The device sessions prefer the AES-GCM cipher on purpose: the IOS XR routers (PE-A, PE-B) drop the connection with PuTTY's default cipher. If you create a session by hand for a router, set *Connection > SSH > Cipher* to put **AES-GCM** first.

If a device session does not open, use the **COLLECTOR** session and run `ssh cisco@<address>` from there: it always works.

## Notes

- The lab nodes are rebuilt between days and get new SSH host keys. `Start-PuTTY.cmd` and the shortcuts forget the old keys for you; if you open `putty.exe` by hand and see a "host key changed" warning, accept the new key.
- The kit touches only your user profile: the PuTTY sessions are stored under `HKEY_CURRENT_USER`. Nothing is installed and no administrator rights are needed.
- OpenSSH: copy `ssh_config` to `%USERPROFILE%\.ssh\config` and use `ssh collector`, `ssh pe-a`, `ssh cgn-a1`, and so on.
- macOS / Linux: use `ssh_config` with OpenSSH (see the comments in the file). PuTTY is for Windows.

PuTTY is free software by Simon Tatham and contributors, distributed under the MIT licence: https://www.chiark.greenend.org.uk/~sgtatham/putty/
