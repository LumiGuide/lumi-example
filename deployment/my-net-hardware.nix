# The physical configuration of my-net.

let facility = nic: ipAddress: defaultGateway: cores: memorySize: { lib, ... }: { /* ... */ };
in {
  facility-1 = facility "eno1" "10.0.1.2" "10.0.1.1"  4  8138;
  facility-2 = facility "eno1" "10.0.2.2" "10.0.2.1"  2 16326;
  # ...
}
