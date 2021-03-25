#!/usr/bin/env python
import json
import subprocess

result = subprocess.run(f'cd ../terraform && terraform output external_ip_address', shell=True, stdout=subprocess.PIPE)
ip = result.stdout.strip().decode()

inventory = {
    "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": ip,
            }
        }
    },
    "all": {
        "children": ["app"]
    },
    "app": {
        "hosts": ["appserver"],
        "vars": {
            "gitlab_external_ip": ip
        }
    },
}

print(json.dumps(inventory, indent=4, sort_keys=True))
