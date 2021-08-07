function run-iso-with-qemu-and-ssh () {
  qemu-system-x86_64 \
    -enable-kvm \
    -cdrom $1 \
    -device ac97 \
    -display gtk \
    -smp 2 \
    -net nic -net user,hostfwd=tcp::2222-:22 \
    -m 2048 ${@:2}
}

function run-iso-with-qemu () {
  qemu-system-x86_64 \
    -enable-kvm \
    -cdrom $1 \
    -device ac97 \
    -display gtk \
    -smp 2 \
    -net nic -net user \
    -m 2048 ${@:2}
}

function run-iso-nn-with-qemu () {
  local macvlan=$1
  local tapindex=$(< /sys/class/net/${macvlan}/ifindex)
  local tapdev=/dev/tap"$tapindex"
  local mac=$(< /sys/class/net/${macvlan}/address)
  qemu-system-x86_64 \
    -enable-kvm \
    -cdrom "$2" \
    -device ac97 \
    -display gtk \
    -net nic,model=virtio,addr=${mac} \
    -net tap,fd=3 3<>/dev/tap11
    -netdev tap,fd=3,id=hostnet0,vhost=on,vhostfd=4 \
            3<>$"$tapdev" \
            4<>/dev/vhost-net \
    -device virtio-net-pci,netdev=hostnet0,id=net0,mac=$mac \
    -smp 8 \
    -m 8G
}

# function run-macvlan-iso-with-qemu () {
#   qemu-system-x86_64 \
#     -enable-kvm \
#     -cdrom $1 \
#     -device ac97 \
#     -display gtk \
#     -net nic,model=virtio,addr=1a:46:0b:ca:bc:7b -net tap,fd=3 3<>/dev/tap11 \
#     -smp 8 \
#     -m 8G ${@:2}
# }

function run-disk-with-qemu () {
  sudo qemu-system-x86_64 \
    -enable-kvm \
    -hdb $1 \
    -device ac97 \
    -display gtk \
    -smp 2 \
    -net nic -net user \
    -m 2048 ${@:2}
}

function run-initrd-with-qemu () {
  if [ -z "$1" ] ; then
    echo "Usage: run-initrd-with-qemu <image> [<kernel>]"
    return
  fi
  qemu-system-x86_64 \
    -enable-kvm \
    -net nic -net user \
    -kernel ${2:-/vmlinuz} \
    -initrd $1 \
    -nographic \
    -serial mon:stdio \
    -append 'root=/dev/ram0 console=ttyS0'
}

