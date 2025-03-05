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
pmacCreateAxis("PMAC1", 1)
pmacCreateAxis("PMAC1", 3)
pmacCreateAxis("PMAC1", 5)
pmacCreateAxis("PMAC1", 6)
pmacCreateAxis("PMAC1", 7)
pmacCreateAxis("PMAC1", 8)
pmacCreateAxis("PMAC1", 9)
pmacCreateAxis("PMAC1", 10)

# Create CS (ControllerPort, Addr, CSNumber, CSRef, Prog)
pmacAsynCoordCreate("P0", 0, 1, 0, 10)   # Gap
pmacAsynCoordCreate("P0", 0, 2, 1, 12)   # Phase
pmacAsynCoordCreate("P0", 0, 6, 2, 14)   # Fly
pmacAsynCoordCreate("P0", 0, 6, 3, 15)   # Fly

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

## Load record instances
cd "${TOP}/db"
dbLoadTemplate("interlock.substitutions", "SYS=$(sys),DEV=$(dev),PORT=P0")
dbLoadTemplate("motor.substitutions", "SYS=$(sys),DEV=$(dev),PORT=P0,MOTORPORT=PMAC1")
dbLoadTemplate("gap.substitutions", "SYS=$(sys),DEV=$(dev),PORT=P0,COORDPORT=PMAC-GAP")


cd "${TOP}/iocBoot/${IOC}"
iocInit

