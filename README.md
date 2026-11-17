# CGN & Telemetry Training Lab

Materials for the hands-on CGN & Telemetry training: lab guides, the lab topologies and a ready-to-use terminal kit. All data in the lab is synthetic.

## Get the kit

On the Windows machine you work from (your laptop with the VPN, or the dCloud Workstation), open PowerShell and run:

```powershell
cd $HOME\Downloads
Invoke-WebRequest https://github.com/dagarcescisco/cgn-telemetry-lab/releases/latest/download/cgn-telemetry-student-kit.zip -OutFile kit.zip
Expand-Archive kit.zip -DestinationPath C:\Labs -Force
```

Or download **`cgn-telemetry-student-kit.zip`** from the [Releases](https://github.com/dagarcescisco/cgn-telemetry-lab/releases/latest) page with your browser and unzip it. Then read `README.md` inside the kit.

## What is in this repository

| Path | Content |
|---|---|
| `guides/` | The guides (PDF). Start with the **Access Guide**, then Lab 1, Lab 2 and Lab 3. The Study Guides explain each stage of the lab |
| `labs/` | CML topology files (YAML) of the three training labs, for the dCloud CML 2.9. The instructors deploy them; import them yourself only if told to |
| `kit/` | Source files of the terminal kit (PuTTY sessions, OpenSSH configuration, shortcuts). It does **not** include `putty.exe`: use the ZIP from the Releases page, which does |

## Training days

| Day | Lab in CML | Guide |
|---|---|---|
| 1 | `LAB1-START` | Access Guide, then Lab 1: Connectivity |
| 2 | `LAB2-START` | Lab 2: Routing, CGN and Failover |
| 3 | `S5-OBSERVABILITY` | Lab 3: Telemetry |

Only one lab runs at a time. Every morning you stop the previous lab and start the one of the day (see the Access Guide).

© 2026 Cisco and/or its affiliates. This material is Cisco Confidential Information, shared with the training participants.
