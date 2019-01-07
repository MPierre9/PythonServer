
print("Script Started")

print("Writing")
f = open('/etc/sysctl.conf')
lines = f.readlines()
has_swappiness = False
for line in lines:
    if not line.startswith("vm.swappiness"):
        print("line: " + line)
        f.write(line)
        has_swappiness = True

f.close()
if has_swappiness:
    f_a = open('/etc/sysctl.conf', "a")
    f_a.write("vm.swappiness = 0")
    f_a.close()
print("Complete")
