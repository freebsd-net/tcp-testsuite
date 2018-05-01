#!/usr/sbin/dtrace -s

#pragma D option quiet
#pragma D option switchrate=25hz
#pragma D option temporal

/*
 * Watch TCP connection state transitions in real time.
 * This script is based on
 * https://people.freebsd.org/~markj/dtrace/network-providers/tcp/tcpstate.d
 */

int last[int];

dtrace:::BEGIN
{
	printf(" %3s %12s %-18s %-20s    %-20s %s\n",
	       "CPU", "DELTA(us)", "CID", "OLD", "NEW", "TIMESTAMP");
}

tcp:::state-change
/last[args[1]->cs_cid]/
{
	this->elapsed = (timestamp - last[args[1]->cs_cid]) / 1000;
	printf(" %3d %12d %-18x %-20s -> %-20s %d\n",
	       cpu,
	       this->elapsed,
	       args[1]->cs_cid,
	       tcp_state_string[args[5]->tcps_state],
	       tcp_state_string[args[3]->tcps_state],
	       timestamp);
	last[args[1]->cs_cid] = timestamp;
}

tcp:::state-change
/last[args[1]->cs_cid] == 0 && execname == "packetdrill"/
{
	printf(" %3d %12s %-18x %-20s -> %-20s %d\n",
	       cpu,
	       "-",
	       args[1]->cs_cid,
	       tcp_state_string[args[5]->tcps_state],
	       tcp_state_string[args[3]->tcps_state],
	       timestamp);
	last[args[1]->cs_cid] = timestamp;
}
