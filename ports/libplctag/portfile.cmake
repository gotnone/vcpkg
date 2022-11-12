vcpkg_from_github(
  OUT_SOURCE_PATH SOURCE_PATH
  REPO libplctag/libplctag
  REF 8918efdaded41ca549ec33ba6503a989590d9838
  SHA512 ece6f07d0819f3e946605813c096ca96b808d4d621f26d9836b1174dfe2106333eda3e771b422fec2c48fb9160daef47a2d8f30ad638cd48807214ca674fe9a6
  HEAD_REF release
  PATCHES cmake.patch
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DBUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_fixup_pkgconfig()

# Handle copyright
file(READ "${SOURCE_PATH}/LICENSE-1.MPL" mpl)
file(READ "${SOURCE_PATH}/LICENSE-2.LGPL" lgpl)
file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
"${PORT} is released under a dual MPL / LGPL license.

---

${mpl}

---

${lgpl}
")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
