# $FreeBSD$

TESTSDIR=	${LOCALBASE}/tests/tcptestsuite
ATF_TESTS_SH=	tcptestsuite_atf_test
TEST_METADATA=	required_programs="${LOCALBASE}/bin/packetdrill"
CLEANFILES+=	tcptestsuite_atf_test.sh
NO_OBJ=

tcptestsuite_atf_test.sh: ${.CURDIR}/make_atf.sh
	/bin/sh ${.CURDIR}/make_atf.sh >$@

.include <bsd.test.mk>
