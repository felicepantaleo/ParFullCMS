#!/bin/sh

#-----------------------------------------------------------------------
# Bourne shell environment setup script for Geant4 10.1.1
#
# This script will configure your environment to provide a setup which 
# can be used to build user applications using the old Geant4 GNUmakefile 
# build system, but with a CMake build or install of Geant4.
#
# This script is autogenerated by CMake DO NOT EDIT
#

#-----------------------------------------------------------------------
# Locate directory of self
#
# Self locate script when sourced
if [ -z "$BASH_VERSION" ]; then
  # Not bash, so rely on sourcing from correct location
  if [ ! -f geant4make.sh ]; then
    echo 'ERROR: geant4make.sh could NOT self-locate Geant4 installation'
    echo 'This is most likely because you are using ksh, zsh or similar'
    echo 'To fix this issue, cd to the directory containing this script'
    echo 'and source it in that directory.'
    return 1
  fi
  geant4make_root=$(pwd)
else
  g4sls_sourced_dir=$(dirname ${BASH_ARGV[0]})
  geant4make_root=$(cd $g4sls_sourced_dir > /dev/null ; pwd)
fi
      

#-----------------------------------------------------------------------
# Cleanup any existing known environment variables
# NB: It won't help with resetting paths!!
#
# - Core Variables
unset  G4INSTALL
unset  G4SYSTEM
unset  G4INCLUDE
unset  G4LIB
unset  G4DEBUG

# - Library build options
unset  G4LIB_BUILD_SHARED
unset  G4LIB_BUILD_STATIC
unset  G4LIB_USE_DLL
unset  G4LIB_USE_GRANULAR
unset  G4MULTITHREADED

# - Optional component build
#
# - CLHEP options
unset  CLHEP_BASE_DIR
unset  CLHEP_INCLUDE_DIR
unset  CLHEP_LIB
unset  CLHEP_LIB_DIR

# - EXPAT options
unset  G4LIB_BUILD_EXPAT
unset  G4LIB_USE_EXPAT

# - ZLIB options
unset  G4LIB_BUILD_ZLIB
unset  G4LIB_USE_ZLIB

# - GDML Options
unset  G4LIB_BUILD_GDML
unset  G4LIB_USE_GDML
unset  XERCESCROOT

# - G3ToG4
unset  G4LIB_BUILD_G3TOG4
unset  G4LIB_USE_G3TOG4

# - UI Build and Use options
# USE options only for applications.
unset  G4UI_NONE
unset  G4UI_BUILD_WT_SESSION
unset  G4UI_BUILD_QT_SESSION
unset  G4UI_BUILD_WIN32_SESSION
unset  G4UI_BUILD_XAW_SESSION
unset  G4UI_BUILD_XM_SESSION

unset  G4UI_USE_TCSH
unset  G4UI_USE_WIN32
unset  G4UI_USE_XAW
unset  G4UI_USE_XM
unset  G4UI_USE_QT
unset  G4UI_USE_WT

#- VIS Build and Use options
# Only USE options matter for applications.
unset  G4VIS_NONE

# - Network DAWN driver
unset  G4VIS_BUILD_DAWN_DRIVER
unset  G4VIS_USE_DAWN

# - Network VRML driver
unset  G4VIS_BUILD_VRML_DRIVER
unset  G4VIS_USE_VRML

# - OpenInventor driver
unset  G4VIS_BUILD_OIWIN32_DRIVER
unset  G4VIS_USE_OIWIN32
unset  G4VIS_BUILD_OIX_DRIVER
unset  G4VIS_USE_OIX

# - OpenGL drivers
unset  G4VIS_BUILD_OPENGLWT_DRIVER
unset  G4VIS_USE_OPENGLWT

unset  QTHOME
unset  QTLIBPATH
unset  QTLIBS
unset  GLQTLIBS
unset  G4VIS_BUILD_OPENGLQT_DRIVER
unset  G4VIS_USE_OPENGLQT

unset  G4VIS_BUILD_OPENGLWIN32_DRIVER
unset  G4VIS_USE_OPENGLWIN32

unset  G4VIS_BUILD_OPENGLXM_DRIVER
unset  G4VIS_USE_OPENGLXM

unset  G4VIS_BUILD_OPENGLX_DRIVER
unset  G4VIS_USE_OPENGLX

# - Raytracer X11
unset  G4VIS_BUILD_RAYTRACERX_DRIVER
unset  G4VIS_USE_RAYTRACERX


#-----------------------------------------------------------------------
# System description and standard install paths
#
export G4SYSTEM=Linux-g++
export G4INSTALL="$geant4make_root"
export G4INCLUDE="`cd $geant4make_root/../../../include/Geant4 > /dev/null ; pwd`"

if test "x$PATH" = "x" ; then
  export PATH="`cd $geant4make_root/../../../bin > /dev/null ; pwd`"
else
  export PATH="`cd $geant4make_root/../../../bin > /dev/null ; pwd`":${PATH}
fi

export G4LIB="`cd $geant4make_root/../../../lib64/Geant4-10.1.1 > /dev/null ; pwd`"

if test "x$LD_LIBRARY_PATH" = "x" ; then
  export LD_LIBRARY_PATH="`cd $geant4make_root/../../../lib64 > /dev/null ; pwd`"
else
  export LD_LIBRARY_PATH="`cd $geant4make_root/../../../lib64 > /dev/null ; pwd`":${LD_LIBRARY_PATH}
fi


#-----------------------------------------------------------------------
# User's G4WORKDIR
#

if test "x$G4WORKDIR" = "x" ; then
  export G4WORKDIR=$HOME/geant4_workdir
fi


if test "x$PATH" = "x" ; then
  export PATH=${G4WORKDIR}/bin/${G4SYSTEM}
else
  export PATH=${G4WORKDIR}/bin/${G4SYSTEM}:${PATH}
fi


#-----------------------------------------------------------------------
# Library build setup
#
export G4LIB_BUILD_SHARED=1


export G4MULTITHREADED=1

#-----------------------------------------------------------------------
# Resource file paths
#
export G4NEUTRONHPDATA="`cd $geant4make_root/../data/G4NDL4.5 > /dev/null ; pwd`"
export G4LEDATA="`cd $geant4make_root/../data/G4EMLOW6.41 > /dev/null ; pwd`"
export G4LEVELGAMMADATA="`cd $geant4make_root/../data/PhotonEvaporation3.1 > /dev/null ; pwd`"
export G4RADIOACTIVEDATA="`cd $geant4make_root/../data/RadioactiveDecay4.2 > /dev/null ; pwd`"
export G4NEUTRONXSDATA="`cd $geant4make_root/../data/G4NEUTRONXS1.4 > /dev/null ; pwd`"
export G4PIIDATA="`cd $geant4make_root/../data/G4PII1.3 > /dev/null ; pwd`"
export G4REALSURFACEDATA="`cd $geant4make_root/../data/RealSurface1.0 > /dev/null ; pwd`"
export G4SAIDXSDATA="`cd $geant4make_root/../data/G4SAIDDATA1.1 > /dev/null ; pwd`"
export G4ABLADATA="`cd $geant4make_root/../data/G4ABLA3.0 > /dev/null ; pwd`"


#-----------------------------------------------------------------------
# Optional components.
#
#-----------------------------------------------------------------------
# CLHEP setup
#
# USING INTERNAL CLHEP





#-----------------------------------------------------------------------
# EXPAT setup
# USING SYSTEM EXPAT

#-----------------------------------------------------------------------
# ZLIB Setup
#
export G4LIB_USE_ZLIB=1


#-----------------------------------------------------------------------
# GDML Setup
#
export G4LIB_USE_GDML=1
export XERCESCROOT=/usr/local

#-----------------------------------------------------------------------
# G3ToG4 Setup
#
# NOT BUILT WITH G3TOG4 SUPPORT

#-----------------------------------------------------------------------
# USER INTERFACE AND VISUALIZATION MODULES
#
#-----------------------------------------------------------------------
# Terminal UI
export G4UI_USE_TCSH=1
# WIN32 TERMINAL UI NOT AVAILABLE ON Linux

#-----------------------------------------------------------------------
# Qt UI/Vis
#




# NOT BUILT WITH QT INTERFACE


#-----------------------------------------------------------------------
# Wt UI/Vis
#



#-----------------------------------------------------------------------
# Xm UI/Vis
#
# NOT BUILT WITH XM INTERFACE


#-----------------------------------------------------------------------
# Network DAWN driver
#
# NOT BUILT WITH NETWORK DAWN SUPPORT

#-----------------------------------------------------------------------
# Network VRML driver
#
# NOT BUILT WITH NETWORK VRML SUPPORT

#-----------------------------------------------------------------------
# OpenInventor
#
# NOT BUILT WITH INVENTOR SUPPORT

#-----------------------------------------------------------------------
# X11 OpenGL
#
# NOT BUILT WITH OPENGL(X11) SUPPORT

#-----------------------------------------------------------------------
# Win32 OpenGL
#
# NOT BUILT WITH OPENGL(WIN32) SUPPORT

#-----------------------------------------------------------------------
# X11 Raytracer 
#
# NOT BUILT WITH RAYTRACER(X11) SUPPORT

#-----------------------------------------------------------------------

