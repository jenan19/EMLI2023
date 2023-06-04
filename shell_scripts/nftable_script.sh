#!/usr/sbin/nft -f

flush ruleset

define WAN0 = eth0 # replace by your network device name

table inet filter {
	chain input {
		type filter hook input priority 0;

		tcp dport {ssh,http,53,67,8000} accept;

		policy drop;
	}
	chain forward {
		type filter hook forward priority 0;
		# route your own packets
		policy accept;
	}
	chain output {
		type filter hook output priority 0;
		policy accept;
	}
}

table ip nat {
	chain prerouting {
		type nat hook prerouting priority 0; policy accept;
	}
		# for all packets to WAN, after routing, replace source address with primary IP of WAN interface
	chain postrouting {
		type nat hook postrouting priority 100; policy accept;
		oifname $WAN0 masquerade
	}
}



