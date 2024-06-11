LOADLIB iptables

FUNCTION set_firewall_rules(option) {
    SWITCH option {
        CASE "open":
            iptables.SET_POLICY(INPUT, ACCEPT)
            iptables.SET_POLICY(FORWARD, ACCEPT)
            iptables.SET_POLICY(OUTPUT, ACCEPT)
        CASE "close":
            iptables.SET_POLICY(INPUT, DROP)
            iptables.SET_POLICY(FORWARD, DROP)
            iptables.SET_POLICY(OUTPUT, DROP)
        CASE "standard":
            iptables.SET_POLICY(INPUT, DROP)
            iptables.APPEND_RULE(INPUT, "-i lo -j ACCEPT")  # Loopback 
            iptables.APPEND_RULE(INPUT, "-m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT")  # Verbindungstabellen
            iptables.APPEND_RULE(INPUT, "-p tcp --dport 22 -j ACCEPT")  # SSH 
            iptables.APPEND_RULE(INPUT, "-p tcp --dport 80 -j ACCEPT")  # HTTP 
            iptables.APPEND_RULE(INPUT, "-p tcp --dport 443 -j ACCEPT")  # HTTPS
        DEFAULT:
            PRINT("Ungültige Option: " + option)
            EXIT(1)
    }
}

IF ARGS.LENGTH() != 1 THEN {
    PRINT("Bitte geben Sie eine Option an: open, close, standard")
    EXIT(1)
}

option = ARGS[0]
set_firewall_rules(option)

PRINT("Aktuelle Firewall-Regeln:")
iptables.LIST()
