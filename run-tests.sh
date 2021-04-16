#!/usr/bin/env sh
#
# Copyright (c) 2016, 2017 Michael Tuexen
# All rights reserved.
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
#

rootdir=`/usr/bin/dirname $0`
passed=0
failed=0
exfailed=0
run=0
skipped=0
timedout=0
extimedout=0
killed=0
first=1
verbose=0

if [ `uname` = 'Linux' ] ; then
  packetdrill=/usr/bin/packetdrill
else
  packetdrill=/usr/local/bin/packetdrill
fi
delay=1
timelimit=10
flags=''
prefix=''

while getopts :d:i:p:P:t:T:v opt; do
  case $opt in
    d)
      delay="$OPTARG"
      ;;
    i)
      if [ `uname` = 'FreeBSD' ] ; then
        flags="${flags} --persistent_tun_dev --tun_dev=$OPTARG"
      else
        echo "Option not supported on this platform: -$OPTARG" >&2
        exit 1
      fi
      ;;
    p)
      packetdrill="$OPTARG"
      ;;
    P)
      prefix="$OPTARG""-"
      ;;
    t)
      timelimit="$OPTARG"
      ;;
    T)
      flags="${flags} --tolerance_usecs=$OPTARG"
      ;;
    v)
      flags="${flags} --verbose"
      verbose=1
      ;;
    \?)
      echo "Unknown option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG provided without an argument." >&2
      exit 1
      ;;
  esac
done
shift $(( $OPTIND - 1 ))

printf "Name                                                                    Verdict\n"
printf "===============================================================================\n"
for file ; do
  for testcase in $(cat $file) ; do
    testdir=`/usr/bin/dirname $testcase`
    testname=`/usr/bin/basename $testcase`
    printf "%-68.68s " ${testname}
    if [ -f ${rootdir}/${testcase}.pkt ] ; then
      found=1
    else
      found=0
    fi
    if [ $first -eq 0 ] ; then
      if [ $delay -ne 0 ] ; then
        if [ -t 1 ] ; then
          printf "\033[33m%10s\033[0m" "WAITING"
        fi
        if [ $found -eq 1 ] ; then
          sleep $delay
        fi
        if [ -t 1 ] ; then
          printf "\b\b\b\b\b\b\b\b\b\b"
        fi
      fi
    else
      first=0
    fi
    if [ $found -eq 1 ] ; then
      if [ -t 1 ] ; then
        printf "\033[33m%10s\033[0m" "RUNNING"
      fi
      timeout $timelimit $packetdrill ${flags} ${rootdir}/${testdir}/${testname}.pkt >${rootdir}/${testdir}/${prefix}${testname}.out 2>&1
      result=$?
      if [ $result -eq 0 -a $verbose -eq 0 ] ; then
        rm ${rootdir}/${testdir}/${prefix}${testname}.out
      fi
      if [ $result -eq 1 -a -f ${rootdir}/${testcase}.exfail -a $verbose -eq 0 ] ; then
        rm ${rootdir}/${testdir}/${prefix}${testname}.out
      fi
      if [ $result -eq 124 -a -f ${rootdir}/${testcase}.extimeout -a $verbose -eq 0 ] ; then
        rm ${rootdir}/${testdir}/${prefix}${testname}.out
      fi
      if [ -t 1 ] ; then
        printf "\b\b\b\b\b\b\b\b\b\b"
      fi
      case $result in
        0)
          passed=`expr $passed + 1`
          if [ -t 1 ] ; then
            printf "\033[32m%10s\033[0m\n" "PASSED"
          else
            printf "%10s\n" "PASSED"
          fi
          ;;
        1)
          if [ -f ${rootdir}/${testcase}.exfail ] ; then
            exfailed=`expr $exfailed + 1`
            if [ -t 1 ] ; then
              printf "\033[32m%10s\033[0m\n" "FAILED"
            else
              printf "%10s\n" "FAILED"
            fi
          else
            failed=`expr $failed + 1`
            if [ -t 1 ] ; then
              printf "\033[31m%10s\033[0m\n" "FAILED"
            else
              printf "%10s\n" "FAILED"
            fi
          fi
          ;;
        124)
          if [ -f ${rootdir}/${testcase}.extimeout ] ; then
            extimedout=`expr $extimedout + 1`
            if [ -t 1 ] ; then
              printf "\033[32m%10s\033[0m\n" "TIMEDOUT"
            else
              printf "%10s\n" "TIMEDOUT"
            fi
          else
            timedout=`expr $timedout + 1`
            if [ -t 1 ] ; then
              printf "\033[35m%10s\033[0m\n" "TIMEDOUT"
            else
              printf "%10s\n" "TIMEDOUT"
            fi
          fi
          ;;
        129|1[345]?|16[01])
          killed=`expr $killed + 1`
          if [ -t 1 ] ; then
            printf "\033[30m%10s\033[0m\n" "KILLED(`expr $result - 128`)"
          else
            printf "%10s\n" "KILLED(`expr $result - 128`)"
          fi
          ;;
        *)
          if [ -t 1 ] ; then
            printf "\033[36m%10s\033[0m\n" "UNKNOWN"
          else
            printf "%10s\n" "UNKNOWN"
          fi
          ;;
      esac
      run=`expr $run + 1`
    else
      if [ -t 1 ] ; then
        printf "\033[34m%10s\033[0m\n" "SKIPPED"
      else
        printf "%10s\n" "SKIPPED"
      fi
      skipped=`expr $skipped + 1`
    fi
  done
done
printf "===============================================================================\n"
printf "Summary: Number of tests run:                    %3u\n" $run
printf "         Number of tests passed:                 %3u\n" $passed
printf "         Number of tests failed (expected):      %3u\n" $exfailed
printf "         Number of tests failed (unexpected):    %3u\n" $failed
printf "         Number of tests timed out (expected):   %3u\n" $extimedout
printf "         Number of tests timed out (unexpected): %3u\n" $timedout
printf "         Number of tests skipped:                %3u\n" $skipped
if [ $killed -gt 0 ] ; then
  printf "         Number of tests killed:                 %3u\n" $killed
fi
