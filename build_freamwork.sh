# 当前项目名字
PROJECT_NAME='ABC'

# 编译工程
BINARY_NAME="${PROJECT_NAME}FreamWork"

cd Example

INSTALL_DIR=$PWD/../Pod/Products
WRK_DIR=build

BUILD_PATH=${WRK_DIR}

# .framework
DEVICE_DIR=${BUILD_PATH}/Release-iphoneos/${BINARY_NAME}.framework
SIMULATOR_DIR=${BUILD_PATH}/Release-iphonesimulator/${BINARY_NAME}.framework

RE_OS="Release-iphoneos"
RE_SIMULATOR="Release-iphonesimulator"

xcodebuild VALID_ARCHS='armv7 armv7s arm64' ARCHS='armv7 armv7s arm64' -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphoneos clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_OS}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_OS}"
xcodebuild VALID_ARCHS='i386 x86_64' ARCHS='i386 x86_64' ONLY_ACTIVE_ARCH=NO -configuration "Release" -workspace "${PROJECT_NAME}.xcworkspace" -scheme "${BINARY_NAME}" -sdk iphonesimulator clean build CONFIGURATION_BUILD_DIR="${WRK_DIR}/${RE_SIMULATOR}" LIBRARY_SEARCH_PATHS="./Pods/build/${RE_SIMULATOR}"

if [ -d "${INSTALL_DIR}" ]
then
rm -rf "${INSTALL_DIR}"
fi
mkdir -p "${INSTALL_DIR}"

cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"

# Objective-C framework 中, 使用 lipo 合成 iphoneos 和 iphonesimulator 可执行文件后, .framework 即可正常工作, 不过在合成 Swift framework 后, 使用 .framework 会出现错误:
# 'SomeClass' is unavailable: cannot find Swift declaration for this class
# 这是因为 Swift framework 内包含有 .swiftmodule 文件, 其定义了 framework 所支持的 architecture, 所以对于 Swift framework, 我们除了将 .exec 文件合并外, 还需要将 .framework/Module/.swiftmodule 文件夹内的所有描述文件移动到一起:
#cp -R "${SIMULATOR_DIR}/Modules/${PROJECT_NAME}.swiftmodule/." "${INSTALL_DIR}/Modules/${PROJECT_NAME}.swiftmodule/"

lipo -create "${DEVICE_DIR}/${BINARY_NAME}" "${SIMULATOR_DIR}/${BINARY_NAME}" -output "${INSTALL_DIR}/${BINARY_NAME}"
rm -r "${WRK_DIR}"
