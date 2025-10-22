{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.services.portainer;
in {
  options.services.portainer = {
    enable = mkEnableOption "Portainer Docker Management Platform";

    version = mkOption {
      type = types.str;
      default = "latest";
      description = "Portainer version tag from Docker Hub";
    };

    port = mkOption {
      type = types.port;
      default = 9443;
      description = "Port for Portainer web interface";
    };

    openFirewall = mkOption {
      type = types.bool;
      default = false;
      description = "Open firewall port for Portainer";
    };

    dataDir = mkOption {
      type = types.path;
      default = "/var/lib/portainer";
      description = "Directory for Portainer data persistence";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;

    virtualisation.oci-containers = {
      backend = "docker";
      containers.portainer = {
        image = "portainer/portainer-ce:${cfg.version}";
        ports = [
          "127.0.0.1:${toString cfg.port}:9443"
        ];
        volumes = [
          "${cfg.dataDir}:/data"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];
      };
    };

    systemd.tmpfiles.rules = [
      "d ${cfg.dataDir} 0755 root root -"
    ];

    networking.firewall.allowedTCPPorts = mkIf cfg.openFirewall [ cfg.port ];

    systemd.services.docker-portainer.after = [ "docker.service" ];
  };
}
