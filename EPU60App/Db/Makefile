TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Install databases, templates & substitutions like this
DB += EPU60.db
DB += gap.template gap.substitutions


DB_INSTALLS += $(EPICS_BASE)/db/pmacStatus.db
DB_INSTALLS += $(EPICS_BASE)/db/pmacStatusAxis.db
DB_INSTALLS += $(EPICS_BASE)/db/pmac_asyn_motor.db
DB_INSTALLS += $(EPICS_BASE)/db/motorstatus.db
DB_INSTALLS += $(EPICS_BASE)/db/asynRecord.db
DB_INSTALLS += $(EPICS_BASE)/db/iocAdminSoft.db
DB_INSTALLS += $(EPICS_BASE)/db/asynRecord.db
#DB_INSTALLS += $(AUTOSAVE)/db/save_restoreStatus.db
#DB_INSTALLS += $(RECCASTER)/db/reccaster.db

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

