
print("Script Started")

print("Writing")
f = open('/etc/sysctl.conf')
lines = f.readlines()
for line in lines:
    if not line.startswith("vm.swappiness"):
        f.write(line)

f.close()
f_a = open('/etc/sysctl.conf')
f_a.append("vm.swappiness = 0")
f_a.close()
print("Complete")
