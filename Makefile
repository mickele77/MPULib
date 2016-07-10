#
# Makefile for eMPL Linux userland implementation
#

CC = gcc
CFLAGS = -Wall -fsingle-precision-constant

# add -DI2C_DEBUG for debugging
# DEFS = -DEMPL_TARGET_LINUX -DMPU9150 -DAK8975_SECONDARY
DEFS = -DEMPL_TARGET_LINUX -DMPU9250

EMPLDIR = eMPL
GLUEDIR = glue
MPUDIR = mpulib
OBJDIR = obj

OBJS = inv_mpu.o \
       inv_mpu_dmp_motion_driver.o \
       linux_glue.o \
       mpulib.o \
       quaternion.o \
       vector3d.o

all : imu imucal

imu : $(OBJS) imu.o
	$(CC) $(CFLAGS) $(OBJS) imu.o -lm -o imu

imucal : $(OBJS) imucal.o
	$(CC) $(CFLAGS) $(OBJS) imucal.o -lm -o imucal


imu.o : imu.c
	$(CC) $(CFLAGS) -I $(EMPLDIR) -I $(GLUEDIR) -I $(MPUDIR) $(DEFS) -c imu.c

imucal.o : imucal.c
	$(CC) $(CFLAGS) -I $(EMPLDIR) -I $(GLUEDIR) -I $(MPUDIR) $(DEFS) -c imucal.c

mpulib.o : $(MPUDIR)/mpulib.c
	$(CC) $(CFLAGS) $(DEFS) -I $(EMPLDIR) -I $(GLUEDIR) -c $(MPUDIR)/mpulib.c

quaternion.o : $(MPUDIR)/quaternion.c
	$(CC) $(CFLAGS) $(DEFS) -c $(MPUDIR)/quaternion.c

vector3d.o : $(MPUDIR)/vector3d.c
	$(CC) $(CFLAGS) $(DEFS) -c $(MPUDIR)/vector3d.c

linux_glue.o : $(GLUEDIR)/linux_glue.c
	$(CC) $(CFLAGS) $(DEFS) -I $(EMPLDIR) -I $(GLUEDIR) -c $(GLUEDIR)/linux_glue.c

inv_mpu_dmp_motion_driver.o : $(EMPLDIR)/inv_mpu_dmp_motion_driver.c
	$(CC) $(CFLAGS) $(DEFS) -I $(EMPLDIR) -I $(GLUEDIR) -c $(EMPLDIR)/inv_mpu_dmp_motion_driver.c

inv_mpu.o : $(EMPLDIR)/inv_mpu.c
	$(CC) $(CFLAGS) $(DEFS) -I $(EMPLDIR) -I $(GLUEDIR) -c $(EMPLDIR)/inv_mpu.c


clean:
	rm -rf *.o

distclean:
	rm -rf *.o imu imucal
