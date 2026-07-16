# Register Map

| Offset | Name | Access | Meaning |
| --- | --- | --- | --- |
| `0x00` | Control | RW | Implementation-defined control bits |
| `0x04` | RX counter | RO | Received frame count |
| `0x08` | TX counter | RO | Forwarded frame count |
| `0x0C` | Lookup MAC high | RW | Upper MAC bits |
| `0x10` | Lookup MAC low | RW | Lower MAC bits |
| `0x14` | Lookup result | RO | Lookup status and port |
| `0x18` | Table clear | WO | Write one to request table clear |

The AXI-Lite template implements control and counters. Board-specific wiring of remaining entries is an integration responsibility.
