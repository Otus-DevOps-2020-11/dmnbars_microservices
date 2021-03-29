#!/usr/bin/env python
import json
import re
import subprocess

result = subprocess.run(f'cd ../terraform && terraform output external_ip_address', shell=True, stdout=subprocess.PIPE)
raw_ips = result.stdout.strip().decode()

ips = re.findall(r"\d+\.\d+\.\d+\.\d+", raw_ips)

inventory = {
    "_meta": {
        "hostvars": {}
    },
    "all": {
        "children": ["app"]
    },
    "app": {
        "hosts": []
    },
}

for index, ip in enumerate(ips, start=1):
    serverName = f'appserver{index}'
    inventory["_meta"]["hostvars"][serverName] = {
        "ansible_host": ip
    }
    inventory["app"]["hosts"].append(serverName)


print(json.dumps(inventory, indent=4, sort_keys=True))
