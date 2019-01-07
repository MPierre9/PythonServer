
print("Script Started")

print("Writing")
with open('/etc/sysctl.conf', "w") as sys:
    for line in sys:
        if not line.startswith("vm.swappiness"):
            sys.write(line)
print("Complete")
