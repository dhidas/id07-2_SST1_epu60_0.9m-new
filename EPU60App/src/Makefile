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

# EPU60_registerRecordDeviceDriver.cpp derives from EPU60.dbd
EPU60_SRCS += EPU60_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
EPU60_SRCS_DEFAULT += EPU60Main.cpp
EPU60_SRCS_vxWorks += -nil-

# Finally link IOC to the EPICS Base libraries
EPU60_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

