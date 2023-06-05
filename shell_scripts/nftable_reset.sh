#!/usr/sbin/nft -f

flush ruleset
define NIC_NAME = "eth0"

table inet filter {
	chain input {
		type filter hook input priority filter; 
		tcp dport {8801,http,67,53} accept; 
		udp dport {53} accept; 
		iifname $NIC_NAME udp dport domain accept
		iifname $NIC_NAME tcp dport domain accept
		tcp dport {139,445} drop; 
	 	policy drop;
	}

	chain forward {
		type filter hook forward priority filter; policy accept;
	}

	chain output {
		type filter hook output priority filter; policy accept;
	}
}
table ip nm-shared-wlan0 {
	chain nat_postrouting {
		type nat hook postrouting priority srcnat; policy accept;
		ip saddr 10.42.0.0/24 ip daddr != 10.42.0.0/24 masquerade
	}

	chain filter_forward {
		type filter hook forward priority filter; policy accept;
		ip daddr 10.42.0.0/24 oifname "wlan0" ct state { established, related } accept
		ip saddr 10.42.0.0/24 iifname "wlan0" accept
		iifname "wlan0" oifname "wlan0" accept
		iifname "wlan0" reject
		oifname "wlan0" reject
	}
}

