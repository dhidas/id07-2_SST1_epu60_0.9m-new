#!../../bin/linux-x86_64/EPU60

#- You may have to change EPU60 to something else
#- everywhere it appears in this file

< envPaths

epicsEnvSet("ENGINEER", "Dean Andrew Hidas is not an engineer. <dhidas@bnl.gov>")
epicsEnvSet("PMACUTIL", "/usr/share/epics-pmacutil-dev")
epicsEnvSet("PMAC1_IP", "10.0.161.25:1025")
#epicsEnvSet("sys", "SR:C07-ID:G1A")
epicsEnvSet("sys", "TESTID")
epicsEnvSet("dev", "SST1:1")
epicsEnvSet("LOCATION",$(HOSTNAME))

epicsEnvSet("BASEDIR", "$(TOP)/..")
epicsEnvSet("STREAM_PROTOCOL_PATH", "/usr/lib/epics/protocol:$(TOP)/proto")

epicsEnvSet('EPICS_CA_AUTO_ADDR_LIST', 'NO')
epicsEnvSet('EPICS_CA_ADDR_LIST', '10.0.153.255')

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/EPU60.dbd"
EPU60_registerRecordDeviceDriver pdbbase


pmacAsynIPConfigure("P0", $(PMAC1_IP))
pmacCreateController("PMAC1", "P0", 0, 12, 50, 500)

## Load record instances
cd "${TOP}/db"
dbLoadTemplate("gap.substitutions", "SYS=$(sys),DEV=$(dev),PORT=P0")
#dbLoadRecords "EPU60Version.db", "user=dhidas"


cd "${TOP}/iocBoot/${IOC}"
iocInit

