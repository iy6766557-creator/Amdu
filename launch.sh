# Run "wget https://raw.githubusercontent.com/ItzLevvie/100-000000674/refs/heads/main/launch.sh && chmod +x launch.sh && ./launch.sh"

DEBIAN_FRONTEND=noninteractive apt-get update

{
    echo "[DEFAULT]"
    echo "Prompt=normal"
} > /etc/update-manager/release-upgrades

case "$(lsb_release --codename | awk '{print $2}')" in
    "noble")
        echo "You are currently on Ubuntu 24.04 (noble)."
        echo "You will be upgraded to Ubuntu 24.10 (oracular)."
        do-release-upgrade
        ;;
    "oracular")
        echo "You are currently on Ubuntu 24.10 (oracular)."
        echo "You will be upgraded to Ubuntu 25.04 (plucky)."
        do-release-upgrade
        ;;
    "plucky")
        echo "You are currently on Ubuntu 25.04 (plucky)."
        echo "You will be upgraded to Ubuntu 25.10 (questing)."
        do-release-upgrade --devel-release
        ;;
    "questing")
        echo "You are currently on Ubuntu 25.10 (questing)."
        echo "You will be upgraded to Ubuntu 26.04 (resolute)."
        do-release-upgrade --devel-release
        ;;
    *)
        echo "You are currently on Ubuntu 26.04 (resolute) which is the latest release of Ubuntu."
        ;;
esac

DEBIAN_FRONTEND=noninteractive apt-get install sudo --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install wget --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install ca-certificates --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install iptables --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install qemu-utils --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install p7zip-full --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install openssh-server --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install htop --no-install-recommends --yes
DEBIAN_FRONTEND=noninteractive apt-get install ethtool --no-install-recommends --yes

# https://www.speedtest.net/apps/cli
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/speedtest --output-document /usr/local/bin/speedtest
chmod +x /usr/local/bin/speedtest

# https://github.com/fastfetch-cli/fastfetch/actions/workflows/ci.yml?query=event%3Apush+is%3Asuccess+branch%3Adev
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/fastfetch --output-document /usr/local/bin/fastfetch
chmod +x /usr/local/bin/fastfetch

# https://pkgs.tailscale.com/unstable
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/tailscale --output-document /usr/local/bin/tailscale
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/tailscaled --output-document /usr/local/bin/tailscaled
chmod +x /usr/local/bin/tailscale
chmod +x /usr/local/bin/tailscaled

# https://github.com/moby/moby/actions/workflows/buildkit.yml?query=event%3Apush+is%3Asuccess+branch%3Amaster
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/docker-proxy --output-document /usr/local/bin/docker-proxy
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/dockerd --output-document /usr/local/bin/dockerd
chmod +x /usr/local/bin/docker-proxy
chmod +x /usr/local/bin/dockerd

# https://github.com/docker/cli/actions/workflows/build.yml?query=event%3Apush+is%3Asuccess+branch%3Amaster
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/docker-linux-amd64 --output-document /usr/local/bin/docker
chmod +x /usr/local/bin/docker

# https://github.com/containerd/containerd/actions/workflows/release.yml?query=event%3Apush+is%3Asuccess+branch%3Amain
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/containerd-shim-runc-v2 --output-document /usr/local/bin/containerd-shim-runc-v2
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/containerd --output-document /usr/local/bin/containerd
chmod +x /usr/local/bin/containerd-shim-runc-v2
chmod +x /usr/local/bin/containerd

# https://github.com/opencontainers/runc/actions/workflows/validate.yml?query=event%3Apush+is%3Asuccess+branch%3Amain
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/runc.amd64 --output-document /usr/local/bin/runc
chmod +x /usr/local/bin/runc

# https://github.com/docker/compose/actions/workflows/ci.yml?query=event%3Apush+is%3Asuccess+branch%3Amain
mkdir --parents /usr/local/lib/docker/cli-plugins
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/docker-compose-linux-x86_64 --output-document /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

# https://github.com/docker/buildx/actions/workflows/build.yml?query=event%3Apush+is%3Asuccess+branch%3Amaster
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/buildx.linux-amd64 --output-document /usr/local/lib/docker/cli-plugins/docker-buildx
chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

# https://github.com/cli/cli/releases/latest
wget https://github.com/ItzLevvie/artifacts/releases/latest/download/gh --output-document /usr/local/bin/gh
chmod +x /usr/local/bin/gh

dockerd --seccomp-profile unconfined --experimental &> /dev/null &

mkdir --parents /root/windows
wget https://github.com/ItzLevvie/artifacts/releases/download/27924-1/data.7z.001 --output-document /root/windows/data.7z.001
wget https://github.com/ItzLevvie/artifacts/releases/download/27924-1/data.7z.002 --output-document /root/windows/data.7z.002
wget https://github.com/ItzLevvie/artifacts/releases/download/27924-1/data.7z.003 --output-document /root/windows/data.7z.003
wget https://github.com/ItzLevvie/artifacts/releases/download/27924-1/data.7z.004 --output-document /root/windows/data.7z.004

7z x /root/windows/data.7z.001 -o/root/windows
rm --force /root/windows/data.7z.00*
qemu-img convert -p -O raw -o preallocation=off /root/windows/data.vhdx /root/windows/data.img
rm --force /root/windows/data.vhdx
cp /root/windows/data.img /root/windows/data.img.bak

{
    echo "data.img"
} > /root/windows/windows.boot

{
    echo "services:"
    echo "  windows:"
    echo "    container_name: windows"
    echo "    image: dockurr/windows:latest"
    echo "    environment:"
    echo "      CPU_CORES: 4"
    echo "      RAM_SIZE: 13G"
    echo "      DISK_SIZE: 128G"
    echo "      TPM: Y"
    echo "      KVM: Y"
    echo "      MTU: 1486"
    echo "      DISPLAY: web"
    echo "      USER: admin"
    echo "      PASS: admin"
    echo "      DEBUG: Y"
    echo "      TZ: Europe/London"
    echo "      BOOT_MODE: windows"
    echo "    ports:"
    echo "      - 3389:3389/tcp"
    echo "      - 3389:3389/udp"
    echo "      - 8006:8006/tcp"
    echo "      - 8006:8006/udp"
    echo "    devices:"
    echo "      - /dev/kvm"
    echo "      - /dev/net/tun"
    echo "      - /dev/vhost-net"
    echo "    cap_add:"
    echo "      - ALL"
    echo "    security_opt:"
    echo "      - seccomp=unconfined"
    echo "    volumes:"
    echo "      - /root/windows:/storage"
    echo "      - /root:/data"
    echo "    privileged: true"
    echo "    restart: always"
} > /root/windows/windows.yaml
