vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO cktan/tomlcpp
  REF 4212f1fccf530e276a2e1b63d3f99fbfb84e86a4
  SHA512 25783e13f35e7993d6ce900ffffb1316eda6d09762cf9a2c63d7b8695566ae18cc25df6d085670832ef511594b80693018a36f3b939f9626d1794d5afcc3e01c
  HEAD_REF main
  PATCHES cmake.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)
vcpkg_cmake_install()

vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-tomlcpp CONFIG_PATH share/unofficial-${PORT})
# Handle copyright
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
