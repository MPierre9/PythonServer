import sys
print("Script Started")

try:
    f = open("/etc/sysctl.conf")
    f_a = open("/etc/sysctl.conf", "a")
    lines = f.readlines
except FileNotFoundError:
    print("File not found")
    sys.exit()

if 'vm.swappiness = 0' in f.read():
    print("Setting found and set correctly")
elif 'vm.swappiness' in f.read():
    print("Setting found and set incorrectly...")
    print("Setting parameter")
    for line in lines:
        if not line.startswith('vm.swappiness'):
            print("writing lines " + line)
            f.write(line)
            f_a.write("vm.swappiness = 0")
else:
    print("Setting not found")
    f_a.write("vm.swappiness = 0")

print("Complete")