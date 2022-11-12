vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO AravisProject/aravis
  REF 7a18ea64d86f00af5662720b0074783ba10d20f8
  SHA512 47c446184cf9aafb6ddfa0c0e14047f4c764463b9d806ffddd06e973af201027c766cb178c80178f865fa1e46249c90b022dfb841c992106ce4aeb0aff552d7d
  HEAD_REF main
)

set(enable_viewer "disabled")
if("viewer" IN_LIST FEATURES)
  set(enable_viewer "enabled")
endif()

set(enable_gst_plugin "disabled")
if("gst-plugin" IN_LIST FEATURES)
  set(enable_gst_plugin "enabled")
endif()

set(enable_usb "disabled")
if("usb" IN_LIST FEATURES)
  set(enable_usb "enabled")
endif()

vcpkg_configure_meson(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -Dviewer=${enable_viewer}
        -Dgst-plugin=${enable_gst_plugin}
        -Dpacket-socket=disabled
        -Dusb=${enable_usb}
        -Dfast-heartbeat=false
        -Ddocumentation=disabled
        -Dintrospection=disabled
    ADDITIONAL_BINARIES glib-mkenums='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-mkenums'
                        glib-compile-resources='${CURRENT_HOST_INSTALLED_DIR}/tools/glib/glib-compile-resources${VCPKG_HOST_EXECUTABLE_SUFFIX}'
)

vcpkg_install_meson()

vcpkg_fixup_pkgconfig()

file(INSTALL "${SOURCE_PATH}/COPYING" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
endif()
