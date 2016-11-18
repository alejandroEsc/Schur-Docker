AUTOMAKE_OPTIONS=color-tests
check_PROGRAMS = extract_example trim 
extract_example_SOURCES = extract_example.l 
extract_example_LDADD = ${LEXLIB}
extract_example_CFLAGS = @CFLAGS@ -DVERSION=\"$(PACKAGE_VERSION)\"

trim_SOURCES = trim.c

EXTRA_DIST = common_test specialTest specialTest.cmds specialTest.expected testrule.schur testrule2.schur testrule3.schur

dist-hook:
	${RM} -rf $(distdir)/help_src_validated/.svn
MYTESTS = \
ABSoluteValue\
ADD\
ALLskewSfn\
APROPOS\
ASSOCiate\
ATtachPartitionToSfn\
AUtoOrIsoMorphism\
BRanch\
BRMode\
CANcelDatFile\
CASIMIRGnthTrace\
CASimirNthordertrace\
CH_CoeffsToOneForSfns\
CH_LabelForOn\
CH_PhaseOfSfns\
CH_SpinIndex\
CH_UoneReps\
CLASS\
COMPare\
COMPLement\
CONJADD\
CONJugateSfnList\
CONSPLIT\
CONTENT\
CONTractGroups\
CONTRAGredientRep\
CONV_R_TO_Sfn\
CONV_S_TO_Rep\
COUNTCoeffsInList\
COUNTTermsInList\
COVariant\
DEAD\
DIMension\
DYNKINIndex\
D_TO_Plabel\
E_TO_FSymmFn\
E_TO_HSymmFn\
E_TO_MSymmFn\
E_TO_SSymmFn\
EXPandSfnList\
FFPROD\
FIRSTPart\
FPROD\
FRACAHnotation\
FROBenius\
F_TO_ESymmFn\
F_TO_HSymmFn\
F_TO_MSymmFn\
F_TO_SSymmFn\
FUSion\
GENERIC\
GENprod\
GRoup\
GWT\
HALLpolynomialProduct\
HCLASS\
HEAPstatus\
HECKE\
HIVESLRCOEFficient\
HSTD\
HSTDList\
H_TO_ESymmFn\
H_TO_FSymmFn\
H_TO_MSymmFn\
H_TO_SSymmFn\
INDEXsequence\
INSertPartitionIntoSfn\
INTegerDivideCoeffs\
INVerseseries\
I_PLethysmRd\
I_sfnProduct\
I_SFNQfnProduct\
I_QfnProduct\
KINSert\
KMatrix\
Kostka\
LABel\
LASTresult\
LATticetest\
LENgthOfPartitionsSelect\
LOadFile\
LOGfile\
LSEQuence\
MACseries\
MACMixedSeries\
MAKEwtOfSfnToN\
MAXCoeffInList\
MIXedTensorReps\
M_TImesSfnProduct\
M_TO_ESymmFn\
M_TO_FSymmFn\
M_TO_HSymmFn\
M_TO_SSymmFn\
MUlt_CoeffsByAnInt\
MULT_List\
MULT_Ntimes\
MULT_PartsByAnInt\
MULT_SelectInList\
MULT_SPlitIntoTwoLists\
NLambda\
NSKew\
NSTDise\
ONSCalar\
O_PfnProduct\
O_QfnProduct\
O_Restrict\
O_sfnProduct\
PARITYsequence\
P_TO_Dlabel\
PLethysm\
PLG\
ProductKronecker\
PROPertyOfRepList\
P_TO_SSymmFn\
Q_TO_SDual\
QEXPandSpecialSeries\
QQEXPandSpecialSeries\
QQSEries\
QSAME\
QSERies\
RACAHnotation\
RD_RAISEInverseOp\
RD_RaiseOp\
RAISEInverseOp\
RAISEop\
RD_I_QfnProduct\
RD_I_sfnProduct\
RIB_TO_S\
RIEMANNList\
RIEMANNPlethList\
RIEMANNScalarsOrderN\
RM_EVENPARTS\
RM_EVENRkSfnsOnly\
RM_EVENWtInList\
RM_FirstPartOfSfn\
RM_Group\
RM_NMParts\
RM_ODDPARTS\
RM_ODDRkSfnsOnly\
RM_ODDWtInList\
RM_PartitionFromSfn\
RM_RepeatedPartsSfns\
RM_PARTSequalN\
RP_FirstPartBySpin\
RP_RepOrSfnByWt\
RP_SfnCoeffByInt\
RSAMEwtSfnList\
SAMEwtSfns\
SB_CUT\
SB_Digits\
SB_POWerNotation\
SB_REVerseOrder\
SCALARInner\
SCHAR\
SERIESTErmsThatSkew\
SERiesToIntWt\
SETFn\
SIGNSEQuence\
SK_Pfn\
SK_Qfn\
SK_sfn\
SMON\
SNchar\
SPLitIntoSpinAndTensor\
SPONModify\
SPRCH\
SPREXtend\
SPSTAR\
SQuares\
STARequivalent\
STD\
STD_OneDprep\
STD_Qfn\
S_TO_ESymmFn\
S_TO_FSymmFn\
S_TO_HSymmFn\
S_TO_MSymmFn\
S_TO_PsymmFn\
S_TO_QsymmFn\
SUBtract\
SUMSQuares\
SWAPgroups\
UONEAddInteger\
UONEDivInteger\
UONETrace\
VMult\
WSEQuence\
WTofRepOrSfnSelect\
YHooklengths\
YOungDiagrams\
YShapeSelect


$(MYTESTS) : Makefile.am trim extract_example
	@echo "$(srcdir)/common_test $(top_srcdir) $(top_builddir)/src/schur${EXEEXT} $(top_srcdir)/help/$@ >$@.log" > $@
	@chmod +x $@

specialTests : 
	@echo "#!/bin/bash" > $@
	@echo "$(srcdir)/specialTest $(top_srcdir) $(top_builddir)/src/schur${EXEEXT}" >> $@
	@chmod +x $@ || echo distcheck called

TESTS = $(MYTESTS) specialTests

DISTCLEANFILES = $(MYTESTS) specialTests

clean :
	@$(RM) $(MYTESTS:=.log) $(MYTESTS:=.trs) specialTests
