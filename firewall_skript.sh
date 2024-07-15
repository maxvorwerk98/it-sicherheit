#!/bin/bash

set_firewall_rules() {
    option="$1"
    case "$option" in
        open)
            iptables -P INPUT ACCEPT
            iptables -P FORWARD ACCEPT
            iptables -P OUTPUT ACCEPT
            ;;
        close)
            iptables -P INPUT DROP
            iptables -P FORWARD DROP
            iptables -P OUTPUT DROP
            ;;
        standard)
            iptables -P INPUT DROP
            iptables -P FORWARD DROP
            iptables -P OUTPUT ACCEPT
            iptables -A INPUT -i lo -j ACCEPT  # Loopback 
            iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT  # Verbindungstabellen
            iptables -A INPUT -p tcp --dport 22 -j ACCEPT  # SSH 
            iptables -A INPUT -p tcp --dport 80 -j ACCEPT  # HTTP 
            iptables -A INPUT -p tcp --dport 443 -j ACCEPT  # HTTPS
            ;;
        *)
            echo "Invalid option: $option"
            exit 1
            ;;
    esac
}

if [ "$#" -ne 1 ]; then
    echo "Please select a valid option: open, close, standard"
    exit 1
fi

option="$1"
set_firewall_rules "$option"

echo "Aktuelle Firewall-Regeln:"
iptables -L
