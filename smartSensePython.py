
print("Script Started")

print("Writing")
with open('/etc/sysctl.conf') as old_sys, open('/etc/sysctl.conf') as new_sys:
    for line in old_sys:
        if not line.startswith("vm.swappiness"):
            new_sys.write(line)
print("Complete")
