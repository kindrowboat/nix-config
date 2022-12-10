{ pkgs, ... }:
{
  # packages for administration tasks
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
  ];

  services.kubernetes = {
    roles = ["master" "node"];
    masterAddress = "localhost";
  };
}
