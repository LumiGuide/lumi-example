# The logical configuration of my-net.

let facility = n : { /* ... */ };
in {
  network.description = "My network";
  network.enableRollback = true;

  defaults = <lumi/os/base.nix>;

  facility-1 = facility 1
  facility-2 = facility 2
  # ...
}
