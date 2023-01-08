{ pkgs, ... }:
{
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/laptop.cluster/192.168.1.10
    address=/revenge.jk/192.168.1.15
    address=/revenge.jk/192.168.1.15
    address=/apps.jk/192.168.1.15
    address=/sys.jk/192.168.1.15
    address=/taco.jk/192.168.1.20
  '';
  virtualisation.docker.extraOptions = ''
    --insecure-registry "http://ku001.local:32000"
  '';

  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
    k9s
  ];

  security.pki.certificates = [ ''
    NixOS.org
    =========
    -----BEGIN CERTIFICATE-----
    MIIDnjCCAoagAwIBAgIUBNW0URl+ndzO+q6BVlSzMSJ4Tx4wDQYJKoZIhvcNAQEL
    BQAwZzELMAkGA1UEBhMCQ0ExEDAOBgNVBAgTB09udGFyaW8xEDAOBgNVBAcTB1Rv
    cm9udG8xEjAQBgNVBAoTCWtpbmRyb2JvdDELMAkGA1UECxMCamsxEzARBgNVBAMT
    CnJldmVuZ2UuamswHhcNMjIxMTAyMjAxOTAwWhcNMjcxMTAxMjAxOTAwWjBnMQsw
    CQYDVQQGEwJDQTEQMA4GA1UECBMHT250YXJpbzEQMA4GA1UEBxMHVG9yb250bzES
    MBAGA1UEChMJa2luZHJvYm90MQswCQYDVQQLEwJqazETMBEGA1UEAxMKcmV2ZW5n
    ZS5qazCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANF++3VGV1rp4kk4
    QbXugOQimTnSNqwu2ZMVqxESQnIsAEcmjOIlLZAhInWq6omgJhqtXIiVQ7jDqtIb
    cK/T0ExaYXaYxDpitvSRlz+cEpkOfLroe3b8BI+nzC9I3uWwbiu9900QHAhwQbfG
    GFbdROpPno6vd5O4A4h8WNGt/AYRD+i/RFqhHwXFksGRWlKwvGilbLIWuc/Kt2DL
    I5wxrJwvgmoWa6gLd57Uemd6Kbrlh4xQo3fyFiSJmSgqmWun9zHVfJ3dfLfJ2ife
    rMAJmFJ1AZGyyzcMSoABj4P8ekYcxyNS8dtKdtqGh72UjFZ7SDp8cgQJpR2EOZFo
    jMFHFaMCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
    HQYDVR0OBBYEFIUYpK1Pht6MtVEvPCT35ZJWtv/kMA0GCSqGSIb3DQEBCwUAA4IB
    AQBcOzgaKnPasVVd+6QuLfAnx3841rQNUVQw1dbw2w0lESMmxExEmpusRLHNXOJb
    7UDVuS8y+L2D0erkT7xZ2Ozi9ZmtzCq/03GLhzUbUABgqPPGBBG3NPzi3WsC3X92
    dMLSosuEB92CexezuYhOGBSew3S+vR1ooe5xRMWWiqHWQCkYlTrkHdlZX3KCwjYP
    rVahic/GzIkDpLPs0Af4BGt6NjWEPm52NiSzgT9DD94V25JJdbqFDzRVdikV2SKA
    s0OaMZ5TLdTWOjg7159/wh80a1sHza6vgfY1yMJQQdKau3XdHrDUWrzR0HQIV2hs
    zs0rWESxiluZUUyupuAWQj8L
    -----END CERTIFICATE-----

  '' ];
}
