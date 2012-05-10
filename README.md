fenland
=======

Nanokernel for ARM, in assembly.

Really, really nano. Fenland is a sort of experiment in moving as much as remotely possible outside the kernel (while not just writing a hypervisor). A short list of traditional kernel functions that Fenland hands off to userland:
* Scheduling.
* Almost all memory management.
* Almost all IPC.
