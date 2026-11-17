# CGN & Telemetry Training Lab

Materials for the hands-on CGN & Telemetry training: lab guides, the lab topologies and a ready-to-use terminal kit. All data in the lab is synthetic.

## Get the kit

On the Windows machine you work from (your laptop with the VPN, or the dCloud Workstation), open PowerShell and run:

```powershell
cd $HOME\Downloads
Invoke-WebRequest https://github.com/dagarcescisco/cgn-telemetry-lab/releases/latest/download/cgn-telemetry-student-kit.zip -OutFile kit.zip
Expand-Archive kit.zip -DestinationPath ([Environment]::GetFolderPath('Desktop')) -Force
```

Or download **`cgn-telemetry-student-kit.zip`** from the [Releases](https://github.com/dagarcescisco/cgn-telemetry-lab/releases/latest) page with your browser and extract it on your Desktop. Then open the folder `cgn-telemetry-student-kit` and double-click `Start-PuTTY.cmd`: it opens PuTTY with the list of sessions and creates the Desktop shortcuts **CGN Lab - PuTTY**, **CGN Lab - Guides** and a folder **CGN Lab - Devices** with one shortcut per device.

## What is in this repository

| Path | Content |
|---|---|
| `guides/` | The guides (PDF). Start with the **Access Guide**, then Lab 1, Lab 2 and Lab 3. The Study Guides explain each stage of the lab. The **Build Guide** (optional) rebuilds the whole lab from a blank network |
| `labs/` | CML topology files (YAML) of the three training labs and the optional Build Lab, for the dCloud CML 2.9. The instructors deploy them; import them yourself only if told to |
| `kit/` | Source files of the terminal kit (PuTTY sessions, OpenSSH configuration, shortcuts). It does **not** include `putty.exe`: use the ZIP from the Releases page, which does |

## Training days

| Day | Lab in CML | Guide |
|---|---|---|
| 1 | `LAB1-START` | Access Guide, then Lab 1: Connectivity |
| 2 | `LAB2-START` | Lab 2: Routing, CGN and Failover |
| 3 | `S5-OBSERVABILITY` | Lab 3: Telemetry |

| Optional | `LAB4-BUILD` | Build Guide: from a blank network to the complete lab (8 to 10 hours, self-paced) |

**Lab 4 (Build Lab):** the topology is complete and the six network devices (CORE, PE-ACC, PE-A, PE-B, CGN-A1, CGN-B1) are blank; the traffic generator, the Internet server and the collector with its dashboards are already running. You configure the network layer by layer (base, connectivity, routing and VPN, CGN, observability) and check each part with `labcheck`. It is not part of the three training days: use it after the course.

Only one lab runs at a time. Every morning you stop the previous lab and start the one of the day (see the Access Guide).

© 2026 Cisco and/or its affiliates. This material is Cisco Confidential Information, shared with the training participants.
