import sys
print("Script Started")

try:
    f = open("/etc/sysctl.conf")
    lines = f.readlines
except FileNotFoundError:
    print("File not found")
    sys.exit()

if 'vm.swappiness = 0' in f.readf():
    print("Setting found and set correctly")
elif 'vm.swappiness' in f.read():
    print("Setting found and set incorrectly")
    for line in lines:
        if not line.startswith('vm.swappiness'):
            f.write(line)
else:
    print("Setting not set")
