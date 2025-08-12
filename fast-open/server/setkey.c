/*
 * A simple program to set the CTLTYPE_OPAQUE
 * TCP Fastopen key, which can not be set
 * using the command line sysctl utility.
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/sysctl.h>

int main(int argc, char **argv) {
        uint8_t key[16] = {0};
        int error = sysctlbyname("net.inet.tcp.fastopen.setkey", NULL, NULL, &key , sizeof(key));
        printf("error: %d\n", error);
}

