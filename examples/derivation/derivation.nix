{
  name = "my-derivation";
  builder = "${bash}/bin/bash";
  args = [ ./builder.sh ];
  system = builtins.currentSystem;
}
