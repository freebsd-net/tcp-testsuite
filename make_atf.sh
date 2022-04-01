#!/usr/bin/env sh
#
# SPDX-License-Identifier: BSD-2-Clause
#
# Copyright (c) 2019 Dell Inc.
#
# Written by:  Eric van Gyzen <vangyzen@FreeBSD.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

tcptestsuite_path=${PREFIX:=/usr/local}/share/tcptestsuite
packetdrill_path=${LOCALBASE:=/usr/local}/bin/packetdrill
packetdrill_options="--tun_dev=tun0 --persistent_tun_dev"

find . -type f -and -name '*.pkt' | sort | \
    sed -e 's,^\./\(.*\)\.pkt$,\1,' > all_tests

printf '#! /usr/libexec/atf-sh\n'
printf '# This file is %sgenerated by make_atf.sh\n' @
printf '# in the tcptestsuite distribution.\n'

cat <<EOF

save_sysctls() {
    sed -n 's/.*sysctl -w \\([^=]*\\)=.*/\\1/p' < \$1 \\
    | sort -u \\
    | xargs sysctl -e > saved_sysctls
    atf_check test \$? -eq 0
}
restore_sysctls() {
    sysctl -f saved_sysctls > /dev/null
    atf_check test \$? -eq 0
    rm saved_sysctls
}

EOF

while read Torig; do
	dir=$(dirname $Torig)
	if [ -r ${dir}/timeout ]; then
	    timeout=$(cat ${dir}/timeout)
	elif [ -r ${Torig}.pkt.timeout ]; then
		timeout=$(cat ${Torig}.pkt.timeout)
	else
	    timeout=10
	fi
	exfail_file=${Torig}.exfail
	if [ -r ${exfail_file} ]; then
	    if [ -s ${exfail_file} ]; then
		read reason < ${exfail_file}
	    else
		reason="${exfail_file} exists"
	    fi
	    exfail="atf_expect_fail \"$reason\""
	else
	    exfail=""
	fi
	extimeout_file=${Torig}.extimeout
	if [ -r ${extimeout_file} ]; then
	    if [ -s ${extimeout_file} ]; then
		read reason < ${extimeout_file}
	    else
		reason="${extimeout_file} exists"
	    fi
	    extimeout="atf_expect_timeout \"$reason\""
	else
	    extimeout=""
	fi
	Tunder=$(basename $Torig | tr - _)
	cat <<-EOF
	atf_test_case $Tunder cleanup
	${Tunder}_head() {
	    atf_set timeout $timeout
	    atf_set require.config allow_sysctl_side_effects
	}
	${Tunder}_body() {
	    ${exfail}
	    ${extimeout}
	    save_sysctls ${tcptestsuite_path}/${Torig}.pkt
	    atf_check -o ignore -e ignore ${tcptestsuite_path}/double-check.sh\
	        ${packetdrill_path} ${packetdrill_options}\
	        ${tcptestsuite_path}/${Torig}.pkt
	}
	${Tunder}_cleanup() {
	    restore_sysctls
	}

EOF
done < all_tests

echo 'atf_init_test_cases() {'
while read Torig; do
	Tunder=$(basename $Torig | tr - _)
	echo "	atf_add_test_case ${Tunder}"
done < all_tests
echo '}'

rm all_tests
