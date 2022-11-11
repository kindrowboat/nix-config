{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    minikube
    kubectl
    kubernetes-helm
    k9s
  ];
}
