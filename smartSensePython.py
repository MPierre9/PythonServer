import sys
print("Script Started")

try:
    f_a = open("/etc/sysctl.conf", "a")
except FileNotFoundError:
    print("File not found")
    sys.exit()
print("Writing")
with open('/etc/sysctl.conf') as old_sys, open('/etc/sysctl.conf') as new_sys:
    for line in old_sys:
        if not line.startswith("vm.swappiness"):
            new_sys.write(line)
            f_a.write("vm.swappiness = 0")
print("Complete")
