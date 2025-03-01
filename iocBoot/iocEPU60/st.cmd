#!../../bin/linux-x86_64/EPU60

#- You may have to change EPU60 to something else
#- everywhere it appears in this file

< envPaths

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/EPU60.dbd"
EPU60_registerRecordDeviceDriver pdbbase

## Load record instances
dbLoadTemplate "db/user.substitutions"
dbLoadRecords "db/EPU60Version.db", "user=dhidas"
dbLoadRecords "db/dbSubExample.db", "user=dhidas"

#- Set this to see messages from mySub
#var mySubDebug 1

#- Run this to trace the stages of iocInit
#traceIocInit

cd "${TOP}/iocBoot/${IOC}"
iocInit

## Start any sequence programs
#seq sncExample, "user=dhidas"
