
print("Script Started")

print("Writing")
f = open('/etc/sysctl.conf')
lines =f.readlines()
for line in lines:
    if not line.startswith("vm.swappiness"):
        sys.write(line)
print("Complete")
