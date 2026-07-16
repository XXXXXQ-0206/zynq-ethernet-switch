# Hardware Validation Procedure

Use this procedure after integrating authorized board collateral:

1. Configure the board Ethernet interfaces and verify link state.
2. Enable two external ports and configure two hosts in the same isolated test subnet.
3. Set both hosts to a matching speed and duplex mode before testing.
4. Send bidirectional ICMP traffic and verify learned entries and packet counters with `switch-config`.
5. Repeat with an unknown destination and verify that the switching core requests flooding.

Use non-production equipment and addresses reserved for documentation or an isolated lab. Record tool versions, constraints, link settings, and observed counter values with each result.
