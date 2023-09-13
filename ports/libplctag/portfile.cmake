vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO libplctag/libplctag
  REF "v${VERSION}"
  SHA512 f540780642112483bd199995b327342bd2df2ec4a4d44c2356886ab94879aeb2da3e420760da2f00b5aee0d1278fc582f73cba8227b276787d21b18fa12a3add
  HEAD_REF release
  PATCHES
	cmake.patch
	sanitizer.patch
	pkgconfig.patch
	fix_static.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    DISABLE_PARALLEL_CONFIGURE
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DUSE_SANITIZERS=OFF
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()
vcpkg_copy_pdbs()

# Handle copyright
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE-1.MPL" "${SOURCE_PATH}/LICENSE-2.LGPL" COMMENT "LIBPLCTAG is released under a dual MPL / LGPL license")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)