TOP=../..
include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

# Install databases, templates & substitutions like this
#DB += EPU60.db
DB += gap_sst1.substitutions gap.template
DB += interlock.template interlock_sst1.substitutions
DB += globalStatus.template globalStatus_sst1.substitutions
DB += girderAxis.template girderAxis_sst1.substitutions
DB += calibration.template calibration_sst1.substitutions
DB += phase.template phase_sst1.substitutions
DB += motor.template motorHome.template motor_sst1.substitutions
DB += motorStatus.template motorStatus_sst1.substitutions
DB += motorDisable.template velocity.template

DB_INSTALLS += $(EPICS_BASE)/db/pmacStatus.db
DB_INSTALLS += $(EPICS_BASE)/db/pmacStatusAxis.db
DB_INSTALLS += $(EPICS_BASE)/db/pmac_asyn_motor.db
DB_INSTALLS += $(EPICS_BASE)/db/motorstatus.db
DB_INSTALLS += $(EPICS_BASE)/db/asynRecord.db
DB_INSTALLS += $(EPICS_BASE)/db/iocAdminSoft.db
DB_INSTALLS += $(EPICS_BASE)/db/asynRecord.db
#DB_INSTALLS += $(AUTOSAVE)/db/save_restoreStatus.db
#DB_INSTALLS += $(RECCASTER)/db/reccaster.db

#BNL standards
DB_INSTALLS += $(EPICS_BASE)/db/iocAdminSoft.db
DB_INSTALLS += $(EPICS_BASE)/db/save_restoreStatus.db

# Dean Add
DB_INSTALLS += $(EPICS_BASE)/db/asynRecord.db

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

