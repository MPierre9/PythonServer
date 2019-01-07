
print("Script Started")

print("Writing")
with open('/etc/sysctl.conf') as sys:
    for line in sys:
        if not line.startswith("vm.swappiness"):
            sys.write(line)
print("Complete")
