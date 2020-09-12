function run-iso-with-qemu-and-ssh () {
  qemu-system-x86_64 \
    -enable-kvm \
    -cdrom $1 \
    -soundhw ac97 \
    -display sdl \
    -smp 2 \
    -net nic -net user,hostfwd=tcp::2222-:22 \
    -m 2048 ${@:2}
}

function run-iso-with-qemu () {
  qemu-system-x86_64 \
    -enable-kvm \
    -cdrom $1 \
    -soundhw ac97 \
    -display sdl \
    -smp 2 \
    -net nic -net user \
    -m 2048 ${@:2}
}

function run-disk-with-qemu () {
  sudo qemu-system-x86_64 \
    -enable-kvm \
    -hdb $1 \
    -soundhw ac97 \
    -display sdl \
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

