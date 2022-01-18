#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libde265" for configuration ""
set_property(TARGET libde265 APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(libde265 PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "CXX"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/liblibde265.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS libde265 )
list(APPEND _IMPORT_CHECK_FILES_FOR_libde265 "${_IMPORT_PREFIX}/lib/liblibde265.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
