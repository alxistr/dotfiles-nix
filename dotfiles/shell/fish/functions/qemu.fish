function run-iso-with-qemu 
  qemu-system-x86_64 \
    -enable-kvm \
    -cdrom $argv[1] \
    -soundhw ac97 \
    -display sdl \
    -smp 2 \
    -net nic -net user \
    -m 2048 $argv[2..-1]
end
