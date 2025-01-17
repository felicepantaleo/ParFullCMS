# - Geant4 CMake Configuration File for External Projects
# This file is configured by Geant4 for use by an external project
# This file is configured by Geant4's CMake system and SHOULD NOT BE EDITED
#
# It defines the following variables
#  Geant4_INCLUDE_DIRS - include directories for Geant4
#  Geant4_DEFINITIONS  - compile definitions needed to use Geant4
#  Geant4_LIBRARIES    - libraries to link against
#  Geant4_CXX_FLAGS    - Recommended CXX flags for the compiler used to
#                        build the Geant4 libraries.
#  Geant4_CXX_FLAGS_<CONFIG> - Recommended CXX flags for build mode CONFIG.
#  Geant4_USE_FILE     - path to a CMake module which may be included to
#                        help setup CMake variables
#  Geant4_CXXSTD       - C++ Standard used to compile Geant4, e.g. c++98
#  Geant4_TLS_MODEL    - Thread Local Storage model used. Only set if
#                        the install provides multithreading support.
#
# You may supply a version number through find_package which will be checked
# against the version of this build. Standard CMake logic is used so that
# the EXACT flag may be passed, and otherwise this build will report itself
# as compatible with the requested version if:
#
#  VERSION_OF_THIS_BUILD >= VERSION_REQUESTED
#
# By default only the core (or kernel) of Geant4 is activated by this
# module. You can specify additional components of Geant4 through the
# COMPONENTS argument to find_package. By default, all core libraries of
# Geant4 are appended to the Geant4_LIBRARIES variable. Specifiying
# additional components will enable a check on the existence of these
# components, with the following per component variables being set:
#
#  Geant4_${COMPONENT}_FOUND    TRUE is the Geant4 library "component" was
#                               found
#
#  Geant4_${COMPONENT}_LIBRARY  Contains the library for the specified
#                               "component" IF the component is a library.
#
# In Geant4, components can be optional subcomponents of an always
# available library. In that case there will be no
# Geant4_{COMPONENT}_LIBRARY variable. These non-library components are
# generally activated by compile definitions, and in these cases the
# appropriate definition will be added to the Geant4_DEFINITIONS component.
#
# If you specify components and use the REQUIRED option to find_package,
# then the module will issue a FATAL_ERROR if this build of Geant4 does
# not have the requested component(s).
#
# The components available generally correspond to configurations of
# the Geant4 libraries or optional extras that Geant4 can be built with.
#
# Library Configuration
# ---------------------
#  static            (Static libraries available. Using this component
#                     when static libraries are available will result in
#                     Geant4_LIBRARIES being populated with the static
#                     versions of the Geant4 libraries. It does not
#                     guarantee the use of static third party libraries.)
#  multithreaded     (Libraries have multithreading support. Using this
#                     component will add the compiler definitions needed
#                     to activate multithread mode to Geant4_DEFINITIONS,
#                     if the libraries support it.)
#
#  usolids           (Geant4 solids are replaced with USolids equivalents)
#
# Optional Components
# -------------------
#  gdml              (GDML support)
#  g3tog4            (Geant3 geometry call list reader library)
#
#  ui_tcsh           (TCsh Style Application Command Line Interface)
#  ui_win32          (WIN32 Style Application Command Line Interface)
#
#  motif             (Motif-X11/OpenGL Graphical User Interface)
#  qt                (Qt4/OpenGL Graphical User Interface)
#  wt                (Wt/OpenGL Web based Graphical User Interface)
#
#  vis_network_dawn  (Client/Server network interface to DAWN visualization)
#  vis_network_vrml  (Client/Server network interface to VRML visualization)
#  vis_opengl_x11    (OpenGL visualization with X11 interface)
#  vis_opengl_win32  (OpenGL visualization with X11 interface)
#  vis_raytracer_x11 (RayTracer visualization with X11 interface)
#  vis_openinventor  (OpenInventor visualization)
#
# In addition, two 'shorthand' components are defined to help activate all
# available User Interface and Visualization drivers:
#
#  ui_all            (All available UI drivers)
#  vis_all           (All available Vis drivers)
#
# These never result in a FATAL_ERROR, even if the REQUIRED find_package
# argument is set. This is because these options do not depend on specific
# components being available.
#
# You can also query whether the Geant4 found uses the builtin versions
# of CLHEP, ZLIB, Expat and USolids after calling find_package via the variables
#
#  Geant4_builtin_clhep_FOUND   (TRUE if Geant4 built with internal CLHEP)
#  Geant4_builtin_expat_FOUND   (TRUE if Geant4 built with internal Expat)
#  Geant4_builtin_usolids_FOUND (TRUE if Geant4 built with internal USolids)
#  Geant4_builtin_zlib_FOUND    (TRUE if Geant4 built with internal Zlib)
#
# These are not used via components as they do not, in general, affect
# the use of Geant4 in an application unless you yourself make direct
# calls to these APIs. As the builtin libraries only contain the code
# required directly by the Geant4 toolkit, you may wish to perform a
# configure time check in these cases that the builtin libraries contain
# the calls required. In both cases, the Geant4_INCLUDE_DIRS and
# Geant4_LIBRARIES variables will be populated to use the builtin or
# system APIs as required, and you should use these to ensure you compile
# and link against the same API version.
#
# Environment variables for, and directory paths to, physics datasets
# used by some Geant4 physics processes may be determined from the
# variables
#
#  Geant4_DATASETS               (List of dataset names known to Geant4)
#  Geant4_DATASET_<NAME>_ENVVAR  (Name of environment variable used by
#                                 Geant4 to obtain path to dataset
#                                 <NAME>)
#  Geant4_DATASET_<NAME>_PATH    (Path to dataset <NAME>. NB this may
#                                 point to a non-existent path if Geant4
#                                 was configured not to install data)
#
#-----------------------------------------------------------------------
# Variables used by this module which can change the default behaviour of
# this module. They need to be set prior to the call to find_package
#
#  Geant4_CONFIG_DEBUG    If set, enable extra messaging output which can
#                         be helpful in debugging and identifying problems
#                         with the configuration.
#
#-----------------------------------------------------------------------

#-----------------------------------------------------------------------
# DEBUG : print out the variables passed via find_package arguments
#
if(Geant4_CONFIG_DEBUG)
  message(STATUS "G4CFG_DEBUG : Geant4_VERSION         = ${Geant4_VERSION}")
  message(STATUS "G4CFG_DEBUG : Geant4_FIND_VERSION    = ${Geant4_FIND_VERSION}")
  message(STATUS "G4CFG_DEBUG : Geant4_FIND_REQUIRED   = ${Geant4_FIND_REQUIRED}")
  message(STATUS "G4CFG_DEBUG : Geant4_FIND_COMPONENTS = ${Geant4_FIND_COMPONENTS}")

  foreach(_cpt ${Geant4_FIND_COMPONENTS})
    message(STATUS "G4CFG_DEBUG : Geant4_FIND_REQUIRED_${_cpt} = ${Geant4_FIND_REQUIRED_${_cpt}}")
  endforeach()

  message(STATUS "G4CFG_DEBUG : Geant4_LIBDEPS_LOADED = ${Geant4_LIBDEPS_LOADED}")
endif()

#-----------------------------------------------------------------------
# Locate ourselves, since all other config files should have been
# installed alongside us...
#
get_filename_component(_thisdir "${CMAKE_CURRENT_LIST_FILE}" PATH)

#-----------------------------------------------------------------------
# Provide *recommended* compiler flags used by this build of Geant4
# Don't mess with the actual CMAKE_CXX_FLAGS!!!
# It's up to the user what to do with these
#
set(Geant4_CXX_FLAGS " -W -Wall -pedantic -Wno-non-virtual-dtor -Wno-long-long -Wwrite-strings -Wpointer-arith -Woverloaded-virtual -Wno-variadic-macros -Wshadow -pipe -pthread -ftls-model=initial-exec -std=c++98")
set(Geant4_EXE_LINKER_FLAGS " ")
set(Geant4_CXX_FLAGS_DEBUG "-g -DG4FPE_DEBUG")
set(Geant4_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG")
set(Geant4_CXX_FLAGS_RELEASE "-O2 -DNDEBUG")
set(Geant4_CXX_FLAGS_RELWITHDEBINFO "-O2 -g")

# - Provide variable indicating C++ Standard we were compiled against
set(Geant4_CXXSTD "c++98")

#-----------------------------------------------------------------------
# Set the base compile definitions required to use Geant4 if the variable
# does not exist (we do this to ensure multiple calls to find_package
# don't overwrite previous invocations)
# Components may append to this
# We set VIS/UI_USE directly here, because for now they are, unfortunately,
# always needed for the Examples.
# However, they ARE NOT required to use Geant4 itself.
#
if(NOT Geant4_DEFINITIONS)
  set(Geant4_DEFINITIONS -DG4_STORE_TRAJECTORY;-DG4VERBOSE)
endif()

# We set VIS/UI_USE directly here, because for now they are, unfortunately,
# always needed for the Examples.
# However, they ARE NOT required to use Geant4 itself.
#
if(NOT G4UI_NONE)
  list(APPEND Geant4_DEFINITIONS -DG4UI_USE)
endif()

if(NOT G4VIS_NONE)
  list(APPEND Geant4_DEFINITIONS -DG4VIS_USE)
endif()

#-----------------------------------------------------------------------
# Configure the path to the Geant4 headers, using a relative path if
# possible. This is only known at CMake time, so we expand a CMake
# supplied variable.
#

# Geant4 configured for the install with relative paths, so use these
get_filename_component(Geant4_INCLUDE_DIR "${_thisdir}/../../include/Geant4" ABSOLUTE)
  



#-----------------------------------------------------------------------
# Configure the path(s) to third party headers.
# This is not a perfect solution to recording dependencies on external
# libraries, but it does ensure that users of THIS Geant4 will pick up
# those it was built against.
# Library dependencies are generally handled through the
# Geant4LibraryDepends file listed below (apart from one exception!)
#
set(Geant4_THIRD_PARTY_INCLUDE_DIRS /usr/local/include)

#-----------------------------------------------------------------------
# Construct overall include path for using Geant4
#
set(Geant4_INCLUDE_DIRS
    ${Geant4_INCLUDE_DIR}
    ${Geant4_THIRD_PARTY_INCLUDE_DIRS})

#-----------------------------------------------------------------------
# If we have used imported targets for any third party packages, reimport
# them here, BEFORE we try and import the Geant4 targets which are
# linked against them.
# Generally, we try and use a standard find_package, but try and force it
# to find the actual package we were built against.
# THIS IS NOT PERFECT, AS IT CANNOT GUARANTEE A BINARY COMPATIBLE
# PACKAGE IS FOUND.


#-----------------------------------------------------------------------
# Include the file listing all the imported targets.
# (Not needed if used in the same Geant4 project, or if we have run before)
# This is always installed in the same location as us...
#
if(NOT CMAKE_PROJECT_NAME STREQUAL Geant4)
  if(NOT Geant4_LIBDEPS_LOADED)
    include("${_thisdir}/Geant4LibraryDepends.cmake")
    set(Geant4_LIBDEPS_LOADED 1)
  endif()
endif()

#-----------------------------------------------------------------------
# Data Resources
# NB: Because data paths can be "forward declared" these offer no
# guarantee of data existence. They only provide a hint.
#
set(Geant4_DATASET_DESCRIPTIONS "G4NDL|G4NEUTRONHPDATA|/geant4/share/Geant4-10.1.1/data/G4NDL4.5|G4NDL.4.5.tar.gz|fd29c45fe2de432f1f67232707b654c0;G4EMLOW|G4LEDATA|/geant4/share/Geant4-10.1.1/data/G4EMLOW6.41|G4EMLOW.6.41.tar.gz|b9b2e455d08375ca9cc5201236db6d7d;PhotonEvaporation|G4LEVELGAMMADATA|/geant4/share/Geant4-10.1.1/data/PhotonEvaporation3.1|G4PhotonEvaporation.3.1.tar.gz|e7870c5ef18ba702e68c22b62233cbb8;RadioactiveDecay|G4RADIOACTIVEDATA|/geant4/share/Geant4-10.1.1/data/RadioactiveDecay4.2|G4RadioactiveDecay.4.2.tar.gz|2eade8116387ef67d4cd6f14b9cb1512;G4NEUTRONXS|G4NEUTRONXSDATA|/geant4/share/Geant4-10.1.1/data/G4NEUTRONXS1.4|G4NEUTRONXS.1.4.tar.gz|665a12771267e3b31a08c622ba1238a7;G4PII|G4PIIDATA|/geant4/share/Geant4-10.1.1/data/G4PII1.3|G4PII.1.3.tar.gz|05f2471dbcdf1a2b17cbff84e8e83b37;RealSurface|G4REALSURFACEDATA|/geant4/share/Geant4-10.1.1/data/RealSurface1.0|RealSurface.1.0.tar.gz|0dde95e00fcd3bcd745804f870bb6884;G4SAIDDATA|G4SAIDXSDATA|/geant4/share/Geant4-10.1.1/data/G4SAIDDATA1.1|G4SAIDDATA.1.1.tar.gz|d88a31218fdf28455e5c5a3609f7216f;G4ABLA|G4ABLADATA|/geant4/share/Geant4-10.1.1/data/G4ABLA3.0|G4ABLA.3.0.tar.gz|d7049166ef74a592cb97df0ed4b757bd")

foreach(_g4dataset_tuple ${Geant4_DATASET_DESCRIPTIONS})
  # Format is NAME|ENVVAR|PATH
  string(REPLACE "|" ";" _g4dataset_tuple "${_g4dataset_tuple}")
  list(GET _g4dataset_tuple 0 _g4dataset_name)
  list(APPEND Geant4_DATASETS ${_g4dataset_name})
  list(GET _g4dataset_tuple 1 Geant4_DATASET_${_g4dataset_name}_ENVVAR)
  list(GET _g4dataset_tuple 2 Geant4_DATASET_${_g4dataset_name}_PATH)
endforeach()
unset(Geant4_DATASET_DESCRIPTIONS)

#-----------------------------------------------------------------------
# Setup components.
# THIS SECTION IS VERY ROUGH AND VERY MUCH CUT AND PASTE.
# TODO: INVESTIGATE TIDY UP WITH LESS PROCESSING.
#-----------------------------------------------------------------------
# Many components are simply present as parts of libraries or always built
# but require additional compile definitions.
#
# Builtin/External packages
set(Geant4_builtin_clhep_FOUND TRUE)
set(Geant4_builtin_expat_FOUND )
set(Geant4_builtin_zlib_FOUND TRUE)
set(Geant4_builtin_usolids_FOUND TRUE)

# - Usolids replacement
set(Geant4_usolids_FOUND OFF)
if(Geant4_usolids_FOUND)
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS usolids)
endif()

# - Multithreading
set(Geant4_multithreaded_FOUND 1)
if(Geant4_multithreaded_FOUND)
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS multithreaded)
  list(APPEND Geant4_DEFINITIONS -DG4MULTITHREADED)

  # - Define variable to indicate TLS model used
  set(Geant4_TLS_MODEL "initial-exec")
endif()

# - GDML
set(Geant4_gdml_FOUND ON)
if(Geant4_gdml_FOUND)
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS gdml)
endif()

# - G3toG4
set(Geant4_g3tog4_FOUND OFF)
if(Geant4_g3tog4_FOUND)
  if(Geant4_FIND_REQUIRED_g3tog4)
    set(_geant4_use_g3tog4_library ON)
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS g3tog4)
endif()

# - UI : TCSH
set(Geant4_ui_tcsh_FOUND 1)
if(Geant4_ui_tcsh_FOUND)
  if(Geant4_FIND_REQUIRED_ui_tcsh OR Geant4_FIND_REQUIRED_ui_all)
    list(APPEND Geant4_DEFINITIONS -DG4UI_USE_TCSH)
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS ui_tcsh)
endif()

# - UI : win32
set(Geant4_ui_win32_FOUND )
if(Geant4_ui_win32_FOUND)
  if(Geant4_FIND_REQUIRED_ui_win32 OR Geant4_FIND_REQUIRED_ui_all)
    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_WIN32
      -DG4UI_USE_WIN32
      )
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS ui_win32)
endif()

# - Visualization : Network DAWN
set(Geant4_vis_dawn_network_FOUND )
if(Geant4_vis_dawn_network_FOUND)
  if(Geant4_FIND_REQUIRED_vis_dawn_network OR Geant4_FIND_REQUIRED_vis_all)
    list(APPEND Geant4_DEFINITIONS -DG4VIS_USE_DAWN)
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS vis_dawn_network)
endif()

# - Visualization : Network VRML
set(Geant4_vis_vrml_network_FOUND )
if(Geant4_vis_vrml_network_FOUND)
  if(Geant4_FIND_REQUIRED_vis_vrml_network OR Geant4_FIND_REQUIRED_vis_all)
    list(APPEND Geant4_DEFINITIONS -DG4VIS_USE_VRML)
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS vis_vrml_network)
endif()

#-----------------------------------------------------------------------
# Components which requires slightly more complex setup
#
# - Visualization : RayTracerX
set(Geant4_vis_raytracer_x11_FOUND OFF)
if(Geant4_vis_raytracer_x11_FOUND)
  if(Geant4_FIND_REQUIRED_vis_raytracer_x11 OR Geant4_FIND_REQUIRED_vis_all)
    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_XT
      -DG4VIS_USE_RAYTRACERX
      )
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS vis_raytracer_x11)
endif()

# - Qt (UI and Vis!)
set(Geant4_qt_FOUND OFF)
set(Geant4_USES_QT5 )
if(Geant4_qt_FOUND)
  if(Geant4_FIND_REQUIRED_qt OR Geant4_FIND_REQUIRED_ui_all OR
      Geant4_FIND_REQUIRED_vis_all)
    # If we have Qt5, we need to refind the components because they use
    # imported targets, so linking will not work unless we recreate
    # them
    if(Geant4_USES_QT5)
      find_package(Qt5Core REQUIRED PATHS "")
      find_package(Qt5Gui REQUIRED PATHS "")
      find_package(Qt5Widgets REQUIRED PATHS "")
      find_package(Qt5OpenGL REQUIRED PATHS "")
      find_package(Qt5PrintSupport REQUIRED PATHS "")
    endif()

    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_QT
      -DG4UI_USE_QT
      -DG4VIS_USE_OPENGLQT
      )
    set(_geant4_use_opengl_library ON)
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS qt)
endif()

# - Wt (UI and Vis!)
set(Geant4_wt_FOUND OFF)
if(Geant4_wt_FOUND)
  if(Geant4_FIND_REQUIRED_wt OR Geant4_FIND_REQUIRED_ui_all OR
      Geant4_FIND_REQUIRED_vis_all)
    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_WT
      -DG4UI_USE_WT
      -DG4VIS_USE_OPENGLWT
      )
    set(_geant4_use_opengl_library ON)
  endif()
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS wt)
endif()

# - Motif (UI and Vis!)
set(Geant4_motif_FOUND OFF)
if(Geant4_motif_FOUND)
  if(Geant4_FIND_REQUIRED_motif OR Geant4_FIND_REQUIRED_ui_all OR
      Geant4_FIND_REQUIRED_vis_all)
    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_XT
      -DG4UI_USE_XM
      -DG4VIS_USE_OPENGLXM
      )
    set(_geant4_use_opengl_library ON)
  endif()

  list(REMOVE_ITEM Geant4_FIND_COMPONENTS motif)
endif()

# - OpenGL X11
set(Geant4_vis_opengl_x11_FOUND OFF)
if(Geant4_vis_opengl_x11_FOUND)
  if(Geant4_FIND_REQUIRED_vis_opengl_x11 OR Geant4_FIND_REQUIRED_vis_all)
    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_XT
      -DG4VIS_USE_OPENGLX
      )
    set(_geant4_use_opengl_library ON)
  endif()

  list(REMOVE_ITEM Geant4_FIND_COMPONENTS vis_opengl_x11)
endif()

# - OpenGL Win32
set(Geant4_vis_opengl_win32_FOUND )
if(Geant4_vis_opengl_win32_FOUND)
  if(Geant4_FIND_REQUIRED_vis_opengl_win32 OR Geant4_FIND_REQUIRED_vis_all)
    list(APPEND
      Geant4_DEFINITIONS
      -DG4INTY_USE_WIN32
      -DG4VIS_USE_OPENGLWIN32
      )
    set(_geant4_use_opengl_library ON)
  endif()

  list(REMOVE_ITEM Geant4_FIND_COMPONENTS vis_opengl_win32)
endif()

# - OpenInventor
set(Geant4_vis_openinventor_FOUND OFF)
if(Geant4_vis_openinventor_FOUND)
  if(Geant4_FIND_REQUIRED_vis_openinventor OR Geant4_FIND_REQUIRED_vis_all)
    if(UNIX AND NOT WIN32)
      list(APPEND Geant4_DEFINITIONS
        -DG4INTY_USE_XT
        -DG4VIS_USE_OI
        -DG4VIS_USE_OIX
        )
    elseif(WIN32)
      list(APPEND Geant4_DEFINITIONS
        -G4INTY_USE_WIN32
        -DG4VIS_USE_OI
        -DG4VIS_USE_OIWIN32
        )
    endif()

    set(_geant4_use_inventor_library ON)
  endif()

  list(REMOVE_ITEM Geant4_FIND_COMPONENTS vis_openinventor)
endif()


#-----------------------------------------------------------------------
# Now perform final configuration of libraries...
# We provide FOUND variables for presence of shared and static
# User can supply "static" component to force use of static libraries, if
# available.
set(Geant4_shared_FOUND ON)
set(Geant4_static_FOUND OFF)

# - Default setting : shared if available, static otherwise
if(Geant4_shared_FOUND)
  set(_geant4_lib_use_suffix "")
else()
  set(_geant4_lib_use_suffix "-static")
endif()

if(Geant4_FIND_REQUIRED_static AND Geant4_static_FOUND)
  set(_geant4_lib_use_suffix "-static")
  list(REMOVE_ITEM Geant4_FIND_COMPONENTS static)
endif()

# The list of libraries probably should be autogenerated, but we hard code
# for now. We don't have to divide the list of shared libraries, but we
# do so for consistency with the way we'll need to do it for static.
# - Always on Vis Components
set(_geant4_internal_libraries
  G4Tree${_geant4_lib_use_suffix}
  G4FR${_geant4_lib_use_suffix}
  G4GMocren${_geant4_lib_use_suffix}
  G4visHepRep${_geant4_lib_use_suffix}
  G4RayTracer${_geant4_lib_use_suffix}
  G4VRML${_geant4_lib_use_suffix}
  )

# - G4OpenGL if it's requested.
if(_geant4_use_opengl_library)
  list(APPEND _geant4_internal_libraries
    G4OpenGL${_geant4_lib_use_suffix}
    G4gl2ps${_geant4_lib_use_suffix}
    )
  list(APPEND Geant4_DEFINITIONS -DG4VIS_USE_OPENGL)
endif()

# - G4OpenInventor if it's requested.
if(_geant4_use_inventor_library)
  list(APPEND _geant4_internal_libraries
    G4OpenInventor${_geant4_lib_use_suffix}
    )
endif()

# - G3toG4 if it's requested
if(_geant4_use_g3tog4_library)
  set(_geant4_g3tog4_library G3toG4${_geant4_lib_use_suffix})
endif()

# - Factory registration mechanism in physics_lists requires whole
# archive to be linked when using static libs, so requires wrapping
# with suitable compiler dependent flags
set(_geant4_physicslists_library G4physicslists${_geant4_lib_use_suffix})
if(_geant4_lib_use_suffix STREQUAL "-static")
  # - Use CMAKE_CXX_COMPILER_ID, which should be reliable enough...
  # Though the GNU/Clang/Intel compilers/linkers *should* use identical
  # flags,keep their sections separate until behaviour confirmed
  #
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    set(_geant4_physicslists_library -Wl,--whole-archive G4physicslists${_geant4_lib_use_suffix} -Wl,--no-whole-archive)
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(_geant4_physicslists_library -Wl,-force_load G4physicslists${_geant4_lib_use_suffix})
  elseif(CMAKE_CXX_COMPILER_ID MATCHES "Intel")
    set(_geant4_physicslists_library -Wl,--whole-archive G4physicslists${_geant4_lib_use_suffix} -Wl,--no-whole-archive)
  else()
    # Needs determination of other compiler options.
    # NB: MSVC has /OPT:NOREF, but may apply globally...
    set(_geant4_physicslists_library G4physicslists${_geant4_lib_use_suffix})
  endif()
endif()

# - 'Kernel' libraries
list(APPEND _geant4_internal_libraries
  G4vis_management${_geant4_lib_use_suffix}
  G4modeling${_geant4_lib_use_suffix}
  G4interfaces${_geant4_lib_use_suffix}
  G4persistency${_geant4_lib_use_suffix}
  ${_geant4_g3tog4_library}
  G4analysis${_geant4_lib_use_suffix}
  G4error_propagation${_geant4_lib_use_suffix}
  G4readout${_geant4_lib_use_suffix}
  ${_geant4_physicslists_library}
  G4run${_geant4_lib_use_suffix}
  G4event${_geant4_lib_use_suffix}
  G4tracking${_geant4_lib_use_suffix}
  G4parmodels${_geant4_lib_use_suffix}
  G4processes${_geant4_lib_use_suffix}
  G4digits_hits${_geant4_lib_use_suffix}
  G4track${_geant4_lib_use_suffix}
  G4particles${_geant4_lib_use_suffix}
  G4geometry${_geant4_lib_use_suffix}
  G4materials${_geant4_lib_use_suffix}
  G4graphics_reps${_geant4_lib_use_suffix}
  G4intercoms${_geant4_lib_use_suffix}
  G4global${_geant4_lib_use_suffix}
  )

# - Any externals built by Geant4
foreach(_extlib G4clhep;G4zlib;G4geomUSolids)
  list(APPEND
    _geant4_internal_libraries
    ${_extlib}${_geant4_lib_use_suffix}
    )
endforeach()

# - Now set them to Geant4_LIBRARIES
set(Geant4_LIBRARIES ${_geant4_internal_libraries})

#-----------------------------------------------------------------------
# Remove any duplicates from the Geant4_{DEFINITIONS,INCLUDE_DIRS,LIBRARIES}
# variables so that multiple passes append things correctly
#
list(REMOVE_DUPLICATES Geant4_DEFINITIONS)
list(REMOVE_DUPLICATES Geant4_INCLUDE_DIRS)
list(REMOVE_DUPLICATES Geant4_LIBRARIES)

#-----------------------------------------------------------------------
# Point the user to the UseGeant4.cmake file which they may wish to include
# to help them with setting up Geant4
#
set(Geant4_USE_FILE ${_thisdir}/UseGeant4.cmake)

#-----------------------------------------------------------------------
# Finally, handle any remaining components.
# We should have dealt with all available components above, except for
# ui_all and vis_all, and removed them from the list of FIND_COMPONENTS
# so any left  we either didn't find or don't know about. Emit a warning
# if REQUIRED isn't set, or FATAL_ERROR otherwise
#
list(REMOVE_DUPLICATES Geant4_FIND_COMPONENTS)
list(REMOVE_ITEM Geant4_FIND_COMPONENTS ui_all vis_all)

foreach(_remaining ${Geant4_FIND_COMPONENTS})
  if(Geant4_FIND_REQUIRED)
    message(FATAL_ERROR "Geant4 component ${_remaining} not found")
  elseif(NOT Geant4_FIND_QUIETLY)
    message(WARNING " Geant4 component ${_remaining} not found")
  endif()
  unset(Geant4_FIND_REQUIRED_${_remaining})
endforeach()

# And we should be done...

