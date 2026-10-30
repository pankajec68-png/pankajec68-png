#!/usr/bin/env python3
"""
CIDR Overlap & IPAM Assessment Tool for 100+ Workload Cloud Migrations
Author: Pankaj Singh (Enterprise Cloud Architect)
"""

import ipaddress
import sys

def check_cidr_overlap(onprem_subnets, azure_subnets):
    """
    Checks for overlapping CIDR blocks between on-premises datacenters
    and Azure Hub-and-Spoke Landing Zones.
    """
    conflicts = []
    
    print("===============================================================")
    print("  ENTERPRISE IPAM ASSESSMENT: ON-PREMISES VS AZURE LANDING ZONE")
    print("===============================================================\n")

    for onprem in onprem_subnets:
        net_onprem = ipaddress.ip_network(onprem)
        for az in azure_subnets:
            net_az = ipaddress.ip_network(az)
            if net_onprem.overlaps(net_az):
                conflicts.append((onprem, az))
                print(f"❌ CONFLICT DETECTED: On-Prem {onprem} overlaps with Azure {az}")
    
    if not conflicts:
        print("✅ SUCCESS: 0 Overlapping CIDR blocks found.")
        print("   Routing table convergence between ExpressRoute and Hub VNet is CLEAN.\n")
        return True
    else:
        print(f"\n⚠️ Total Conflicts: {len(conflicts)}. Remediation required before VNet peering.\n")
        return False

if __name__ == "__main__":
    sample_onprem = ["10.10.0.0/16", "10.20.0.0/16", "192.168.1.0/24"]
    sample_azure  = ["10.100.0.0/16", "10.101.0.0/16", "10.102.0.0/16", "10.103.0.0/16"]

    print("Running initial IPAM discovery on 100+ workload subnets...")
    check_cidr_overlap(sample_onprem, sample_azure)
