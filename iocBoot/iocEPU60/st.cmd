#!../../bin/linux-x86_64/EPU60


< envPaths

epicsEnvSet("BASEDIR", "$(TOP)/..")
epicsEnvSet("LOCATION",$(HOSTNAME))


#epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/proto")
epicsEnvSet("STREAM_PROTOCOL_PATH", "/usr/lib/epics/protocol:$(TOP)/proto")


epicsEnvSet("EPICS_CA_AUTO_ADDR_LIST", "NO")
epicsEnvSet("EPICS_CA_ADDR_LIST", "10.0.153.255")

#epicsEnvSet("sys", "SR:C07-ID:G1A")
epicsEnvSet("sys", "TESTID")
epicsEnvSet("dev", "SST1:1")


## Register all support components
dbLoadDatabase "${TOP}/dbd/EPU60.dbd"
EPU60_registerRecordDeviceDriver pdbbase

## Autosave setup ##
####################################################
## save_restore setup
save_restoreSet_Debug(0)

# status-PV prefix, so save_restore can find its status PV's.
save_restoreSet_status_prefix("$(sys){$(dev)}")

# Ok to save/restore save sets with missing values (no CA connection to PV)?
save_restoreSet_IncompleteSetsOk(1)

# Save dated backup files?
save_restoreSet_DatedBackupFiles(1)

# Number of sequenced backup files to write
save_restoreSet_NumSeqFiles(1)
save_restoreSet_SeqPeriodInSeconds(60)

set_savefile_path("${BASEDIR}/as/save")

set_requestfile_path("$(BASEDIR)/as/req/")
## End of autosave set-up
####################################################
set_pass1_restoreFile("as_SST1.sav")

epicsThreadSleep 1

# Configure ports
pmacAsynIPConfigure("PMAC_ETH_PORT", "10.0.161.25:1025")
#pmacCreateController("PMAC1", "PMAC_ETH_PORT", 0, 12, 50, 500)

# asynOctetSetInputEos("PMAC_ETH_PORT", 0, "\006")
#asynSetTraceMask("PMAC_ETH_PORT", -1, 0x1f)

pmacRegisterDriverInit("PMAC_REG_PORT", "PMAC_ETH_PORT")
#asynSetTraceMask("PMAC_REG_PORT", -1, 0x1f)

pmacAsynMotorCreate("PMAC_ETH_PORT", 0, 0, 8)
drvAsynMotorConfigure("PMAC0", "pmacAsynMotor",0, 9)

# Create CS (ControllerPort, Addr, CSNumber, CSRef, Prog)
# Gap: Coordinate System 1 | PROG 10
pmacAsynCoordCreate("PMAC_ETH_PORT", 0, 1, 0, 10)
# Phase: Coordinate System 2 | PROG 12
pmacAsynCoordCreate("PMAC_ETH_PORT", 0, 2, 1, 12)
# Fly: Coordinate System 6 | PROG 14-15
pmacAsynCoordCreate("PMAC_ETH_PORT", 0, 6, 2, 14)
pmacAsynCoordCreate("PMAC_ETH_PORT", 0, 6, 3, 15)

# Configure CS (PortName, DriverName, CSRef, NAxes)
drvAsynMotorConfigure("PMAC-GAP", "pmacAsynCoord", 0, 9)
drvAsynMotorConfigure("PMAC-PHASE", "pmacAsynCoord", 1, 9)
drvAsynMotorConfigure("PMAC-FLY", "pmacAsynCoord", 2, 9)
drvAsynMotorConfigure("PMAC-FLYb", "pmacAsynCoord", 3, 9)

# Set scale factor (CSRef, axis, stepsPerUnit)
pmacSetCoordStepsPerUnit(0, 6, 5)
pmacSetCoordStepsPerUnit(1, 6, 5)
pmacSetCoordStepsPerUnit(2, 6, 1)
pmacSetCoordStepsPerUnit(3, 6, 1)

# Set Idle and Moving poll periods (CSRef, PeriodsMilliSeconds)
pmacSetCoordIdlePollPeriod(0, 500)
pmacSetCoordMovingPollPeriod(0, 100)
pmacSetCoordIdlePollPeriod(1, 500)
pmacSetCoordMovingPollPeriod(1, 100)
pmacSetCoordIdlePollPeriod(2, 500)
pmacSetCoordMovingPollPeriod(2, 100)
pmacSetCoordIdlePollPeriod(3, 500)
pmacSetCoordMovingPollPeriod(3, 100)

#asynReport(5)

## Load record instances
cd ${TOP}/db
dbLoadTemplate("interlock_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("motor_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("motorStatus_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("girderAxis_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("gap_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("phase_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("calibration_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadTemplate("globalStatus_sst1.substitutions", "SYS=$(sys),DEV=$(dev)")
dbLoadRecords("asynRecord.db","P=$(sys),R={$(dev)}Asyn,ADDR=1,PORT=PMAC_ETH_PORT,IMAX=128,OMAX=128")
dbLoadRecords("EPU60FlyScan.db","SYS=$(sys),DEV=$(dev),REGPORT=PMAC_REG_PORT,PORT=PMAC_ETH_PORT")
dbLoadRecords("iocAdminSoft.db", "IOC=$(sys){$(dev)}")
dbLoadRecords("iocAdminScanMon.db", "IOC=$(sys){$(dev)}")
dbLoadRecords("iocGeneralTime.db", "IOCNAME=$(sys){$(dev)}")
dbLoadRecords("save_restoreStatus.db", "P=$(sys){$(dev)}")

#dbLoadRecords("iocAdminSoft.db", "IOC=SR:CT{IOC:SST1:C07:1}")
#dbLoadRecords("iocGeneralTime.db", "IOCNAME=SR:CT{IOC:SST1:C07:1}")
#dbLoadRecords("save_restoreStatus.db", "P=SR:CT{IOC:SST1:C07:1}")

## iocInit
asSetFilename("/cf-update/acf/default.acf")

cd ${BASEDIR}
iocInit


## Autosave after iocInit ##
create_monitor_set("as_SST1.req", 30)

caPutLogInit("ioclog.cs.nsls2.local:7004", 1)

#Support channel-finder
dbl > records.dbl
system "cp records.dbl /cf-update/$(HOSTNAME).$(IOCNAME).dbl"
