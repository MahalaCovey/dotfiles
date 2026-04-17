#!/usr/bin/env bash

# =============================================================================
# install_ansible.sh — Install Ansible on Ubuntu Linux
# =============================================================================

# -euo  flags mean exit if a command has a non-zero exit status, exit if there is an undefined variable, and the pipeline exits 
# with the code of the last executed command
set -euo pipefail

# ── Formatting ────────────────────────────────────────────────────────────────
BOLD="\033[1m"
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

info()    { echo -e "${CYAN}${BOLD}[INFO]${RESET}  $*"; }
success() { echo -e "${GREEN}${BOLD}[OK]${RESET}    $*"; }
warn()    { echo -e "${YELLOW}${BOLD}[WARN]${RESET}  $*"; }
error()   { echo -e "${RED}${BOLD}[ERROR]${RESET} $*" >&2; }

# ── Config ────────────────────────────────────────────────────────────────────
SOFTWARE_NAME="ansible"
PACKAGE_NAME="ansible"
TRY_COMMAND="ansible --version"

# ── 1. Root / sudo check ──────────────────────────────────────────────────────
if [[ "${EUID}" -ne 0 ]]; then
    error "This script must be run as root or with sudo."
    echo  "       Please re-run: ${BOLD}sudo $0${RESET}"
    exit 1
fi
success "Running as root — permission check passed."

# -v flag means version, &> means redirect standard output and error output to /dev/null
# ── 2. apt availability check ─────────────────────────────────────────────────
if ! command -v apt &>/dev/null; then
    error "This script requires the 'apt' package manager, which was not found."
    echo  "       Please run this script on a Debian/Ubuntu-based system."
    exit 1
fi
success "'apt' package manager found."

# ── 3. Installation summary & user confirmation ───────────────────────────────
echo
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${BOLD}  About to install: Ansible${RESET}"
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo
echo -e "  ${BOLD}What is Ansible?${RESET}"
echo    "  Ansible is an open-source IT automation tool for"
echo    "  configuration management, application deployment,"
echo    "  and task automation — agentless over SSH."
echo
echo -e "  ${BOLD}What will be installed:${RESET}"
echo    "  • ansible          — core automation engine & CLI"
echo    "  • ansible-core     — required base libraries"
echo    "  • python3 / pip    — runtime dependencies (if absent)"
echo
echo -e "  ${BOLD}Installation method:${RESET} apt (system package manager)"
echo
echo -e "${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo

read -rp "$(echo -e "${BOLD}Proceed with installation? [y/n]:${RESET} ")" choice
case "${choice}" in
    [Yy]) echo ;;
    [Nn])
        warn "Installation cancelled by user."
        exit 0
        ;;
    *)
        error "Invalid input '${choice}'. Please enter y or n."
        exit 1
        ;;
esac

# ── 4. Name-conflict check ────────────────────────────────────────────────────
if command -v "${SOFTWARE_NAME}" &>/dev/null; then
    existing_path="$(command -v "${SOFTWARE_NAME}")"
    error "Name conflict detected: '${SOFTWARE_NAME}' already exists on this system."
    echo  "       Found at: ${existing_path}"
    echo  "       To avoid overwriting unrelated software, this script will not proceed."
    echo  "       If you wish to reinstall, remove or rename the existing binary first."
    exit 1
fi
success "No name conflict — '${SOFTWARE_NAME}' is not currently installed."

# -y flag means yes -qq flag means very quiet output
# ── 5. Silent installation ────────────────────────────────────────────────────
info "Updating package index…"
apt update -qq

info "Installing ${SOFTWARE_NAME} (non-interactive)…"
DEBIAN_FRONTEND=noninteractive apt install -y -qq "${PACKAGE_NAME}"

# -v means version and  &> means redirect output to /dev/null
# ── 6. Post-install verification ─────────────────────────────────────────────
if ! command -v "${SOFTWARE_NAME}" &>/dev/null; then
    error "Installation appeared to complete, but '${SOFTWARE_NAME}' was not found in PATH."
    echo  "       You may need to open a new shell or check /usr/bin for the binary."
    exit 1
fi

# ── 7. Success message ────────────────────────────────────────────────────────
echo
echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}${BOLD}  Installation complete!${RESET}"
echo -e "${GREEN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo
echo -e "  Ansible has been installed successfully."
echo
echo -e "  ${BOLD}Try it now:${RESET}"
echo -e "    ${CYAN}${TRY_COMMAND}${RESET}"
echo
echo -e "  ${BOLD}Quick-start example:${RESET}"
echo -e "    ${CYAN}ansible localhost -m ping${RESET}"
echo
