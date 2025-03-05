TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# Build an IOC support library
LIBRARY_IOC += EPU60Support


EPU60Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Build the IOC application
PROD_IOC = EPU60

# EPU60.dbd will be created and installed
DBD += EPU60.dbd

# EPU60.dbd will include these files:
EPU60_DBD += base.dbd
EPU60_DBD += asyn.dbd
EPU60_DBD += motorSupport.dbd
EPU60_DBD += pmacAsynMotorPort.dbd
EPU60_DBD += pmacAsynMotor.dbd
EPU60_DBD += pmacAsynIPPort.dbd
EPU60_DBD += pmacAsynCoord.dbd
EPU60_DBD += asSupport.dbd
EPU60_DBD += busySupport.dbd
EPU60_DBD += calcSupport.dbd
EPU60_DBD += system.dbd
EPU60_DBD += stream.dbd
EPU60_DBD += devIocStats.dbd
EPU60_DBD += caPutLog.dbd
EPU60_DBD += ether_ip.dbd
EPU60_DBD += reccaster.dbd

# EPU60_registerRecordDeviceDriver.cpp derives from EPU60.dbd
EPU60_SRCS += EPU60_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
EPU60_SRCS_DEFAULT += EPU60Main.cpp
EPU60_SRCS_vxWorks += -nil-

# Finally link IOC to the EPICS Base libraries
EPU60_LIBS += $(EPICS_BASE_IOC_LIBS)
EPU60_LIBS += asyn
EPU60_LIBS += pmacAsynIPPort
EPU60_LIBS += pmacAsynCoord
EPU60_LIBS += motor
EPU60_LIBS += asyn
EPU60_LIBS += autosave
EPU60_LIBS += busy
EPU60_LIBS += calc
EPU60_LIBS += stream
EPU60_LIBS += devIocStats
EPU60_LIBS += pmacAsynMotor
EPU60_LIBS += pmacAsynMotorPort
EPU60_LIBS += caPutLog
EPU60_LIBS += ether_ip
EPU60_LIBS += reccaster


EPU60_DBD += pmac_vector.dbd
EPU60_SRCS_DEFAULT += pmac_vector.c

EPU60_SRCS += pmacRegisterDriver.c

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

