# 🧱 OSI Layer 1 – Physical Layer

> _“The foundation of all cloud communication is invisible — fiber optics, virtual interfaces, and the pulse of electrons.”_

## 🔍 What It Is
Layer 1 of the OSI model defines the **physical medium** through which data travels. It’s the raw transmission layer — no logic, no addressing, just bits moving across wires or waves.

## 🧰 Key Components
| Component | Description |
|----------|-------------|
| **Fiber Optics** | High-speed cables used in cloud interconnects (e.g., AWS Direct Connect, Azure ExpressRoute). |
| **NIC (Network Interface Card)** | Hardware or virtual adapter that connects a system to a network. |
| **Virtual Interfaces** | Software-defined equivalents of NICs in cloud environments (e.g., AWS ENI, Azure vNIC). |

## 🧠 Cloud Architect’s View
Even in virtualized cloud environments, understanding Layer 1 helps you:
- Design **secure interconnects** between cloud and on-prem.
- Choose the right **interface types** for VMs and containers.
- Monitor **low-level traffic** for anomalies or unauthorized access.

## 🧪 Mini-Lab (CLI)
```bash
# View physical interfaces
ip link show

# Check interface stats
ethtool eth0

# Simulate interface down/up
sudo ip link set eth0 down
sudo ip link set eth0 up
✅ Review Checklist
[ ] Explain the role of Layer 1 in cloud networking.

[ ] Identify physical vs virtual interfaces in AWS/Azure/GCP.

[ ] Run CLI commands to inspect and manipulate interfaces.
