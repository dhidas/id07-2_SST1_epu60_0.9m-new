TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Use typed rset structure (see 3.16.1 release notes)
USR_CPPFLAGS += -DUSE_TYPED_RSET

# xxxRecord.h will be created from xxxRecord.dbd
DBDINC += xxxRecord

# Install xxxSupport.dbd into <top>/dbd
DBD += xxxSupport.dbd

# Build an IOC support library
LIBRARY_IOC += EPU60Support

# Compile and add code to the support library
EPU60Support_SRCS += xxxRecord.c
EPU60Support_SRCS += devXxxSoft.c

# Link locally-provided code into the support library,
# rather than directly into the IOC application, that
# causes problems on Windows DLL builds
EPU60Support_SRCS += dbSubExample.c
EPU60Support_SRCS += devEPU60Version.c
EPU60Support_SRCS += EPU60Hello.c
EPU60Support_SRCS += initTrace.c

EPU60Support_LIBS += $(EPICS_BASE_IOC_LIBS)

# Auto-generate a header file containing a version string.
# Version comes from the VCS if available, else date+time.
GENVERSION = EPU60Version.h
# Macro name
GENVERSIONMACRO = EPU60VERSION

# Build the IOC application
PROD_IOC = EPU60

# EPU60.dbd will be created and installed
DBD += EPU60.dbd

# EPU60.dbd will include these files:
EPU60_DBD += base.dbd
EPU60_DBD += xxxSupport.dbd
EPU60_DBD += dbSubExample.dbd
EPU60_DBD += devEPU60Version.dbd
EPU60_DBD += EPU60Hello.dbd
EPU60_DBD += initTrace.dbd

# EPU60_registerRecordDeviceDriver.cpp derives from EPU60.dbd
EPU60_SRCS += EPU60_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
EPU60_SRCS_DEFAULT += EPU60Main.cpp
EPU60_SRCS_vxWorks += -nil-

# Link in the code from our support library
EPU60_LIBS += EPU60Support

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into EPU60Support
    sncExample_SNCFLAGS += +r
    EPU60_DBD += sncExample.dbd
    # A .stt sequence program is *not* pre-processed:
    EPU60Support_SRCS += sncExample.stt
    EPU60Support_LIBS += seq pv
    EPU60_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    # A .st sequence program *is* pre-processed:
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link QSRV (pvAccess Server) if available
ifdef EPICS_QSRV_MAJOR_VERSION
    EPU60_LIBS += qsrv
    EPU60_LIBS += $(EPICS_BASE_PVA_CORE_LIBS)
    EPU60_DBD += PVAServerRegister.dbd
    EPU60_DBD += qsrv.dbd
endif

# Finally link IOC to the EPICS Base libraries
EPU60_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

# Explicit dependency needed for generated header file
devEPU60Version$(DEP): $(COMMON_DIR)/$(GENVERSION)
