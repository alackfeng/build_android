#! /bin/bash

build_libjpeg_turbo(){
    
    SYSROOT=${NDK_PATH}/platforms/android-${ANDROID_VERSION}/arch-$1
    
    if [ $1 = "arm" ]; then
        HOST=arm-linux-androideabi
        ANDROID_ABI=armeabi-v7a
        ANDROID_ARM_MODE=arm
        TOOLCHAIN=${NDK_PATH}/toolchains/llvm/prebuilt/${BUILD_PLATFORM}
        ANDROID_ASM_FLAGS="--target=arm-linux-androideabi${ANDROID_VERSION}"
        TARGET=arm
    elif [ $1 = "arm64" ]; then
        HOST=aarch64-linux-android
        ANDROID_ABI=arm64-v8a
        ANDROID_ARM_MODE=arm
        TOOLCHAIN=${NDK_PATH}/toolchains/llvm/prebuilt/${BUILD_PLATFORM}
        ANDROID_ASM_FLAGS="--target=arm-linux-android${ANDROID_VERSION}"
        TARGET=aarch64
    elif [ $1 = "x86" ]; then
        HOST=i686-linux-android
        ANDROID_ABI=x86
        ANDROID_ARM_MODE=
        TOOLCHAIN=${NDK_PATH}/toolchains/llvm/prebuilt/${BUILD_PLATFORM}
        ANDROID_ASM_FLAGS=""
        TARGET=x86
    elif [ $1 = "x86_64" ]; then
        HOST=x86_64-linux-android
        ANDROID_ABI=x86_64
        ANDROID_ARM_MODE=
        TOOLCHAIN=${NDK_PATH}/toolchains/llvm/prebuilt/${BUILD_PLATFORM}
        ANDROID_ASM_FLAGS=""
        TARGET=x86_64
    fi


    OLD_PWD=`pwd`

    INSTALL_PATH="${INSTALL_PREFIX}/${PROGRAM_NAME}/${ANDROID_ABI}"
    mkdir -p "${INSTALL_PATH}"

    BUILD_PATH="${ROOT_PATH}/${PROGRAM_NAME}/build/$1"
    mkdir -p "${BUILD_PATH}"

    cd "${BUILD_PATH}"
    # make clean
    meson ../../ --cross-file=../../package/crossfiles/${TARGET}-android.meson \
        --default-library=static \
        --buildtype release \
        --prefix "${INSTALL_PATH}" \
        
    ninja
    meson install
    cd ${OLD_PWD}
}

usage(){
    echo "usage: sh build_android.sh arm/arm64/x86/x86_64/all"
    exit 1
}

#### mac.
NDK_PATH=/Users/tokenfun/Library/Android/sdk/ndk-bundle
BUILD_PLATFORM=darwin-x86_64
ROOT_PATH=/Users/tokenfun/taurus/bitdisk/gitlab/bytezero/thirdpartys/
INSTALL_PREFIX=/Users/tokenfun/taurus/bitdisk/gitlab/bytezero/thirdpartys/android
PROGRAM_NAME=dav1d

TOOLCHAIN_VERSION=4.9
ANDROID_VERSION=21
export PATH=$PATH:/Users/tokenfun/Library/Android/sdk/ndk-bundle/toolchains/llvm/prebuilt/darwin-x86_64/bin/
#### linux.
#NDK_PATH=$NDK_PATH
#BUILD_PLATFORM=linux-x86_64

if [ -z $NDK_PATH ] || [ ! -d $NDK_PATH ] || [ ! -f "$NDK_PATH/ndk-build" ]; then
    echo "\$NDK_PATH is not correct!"
    exit 1
fi

if [ $# -lt 1 ]; then
    usage
fi

if [ $1 = "copy" ] || [ $1 = "cp" ]; then
    LIB_NAME=libdav1d.a
    CPTO_PATH="${ROOT_PATH}/libheif/java/libheif_android/app/"
    echo "copy ${LIB_NAME} to program ${CPTO_PATH}"
    cp ${PROGRAM_NAME}/arm64-v8a/lib/${LIB_NAME} ${CPTO_PATH}/libs/arm64-v8a/
    cp ${PROGRAM_NAME}/armeabi-v7a/lib/${LIB_NAME} ${CPTO_PATH}/libs/armeabi-v7a/
    cp ${PROGRAM_NAME}/x86/lib/${LIB_NAME} ${CPTO_PATH}/libs/x86/
    cp ${PROGRAM_NAME}/x86_64/lib/${LIB_NAME} ${CPTO_PATH}/libs/x86_64/
    echo "copy success, ${LIB_NAME} to ${CPTO_PATH}"

elif [ $1 = "arm" ] || [ $1 = "arm64" ] || [ $1 = "x86" ] || [ $1 = "x86_64" ]; then
    build_libjpeg_turbo $1
    echo "build success, output dir is out/$1"
elif [ $1 = "all" ]; then
    build_libjpeg_turbo "arm"
    build_libjpeg_turbo "arm64"
    build_libjpeg_turbo "x86"
    build_libjpeg_turbo "x86_64"
    echo "build success, output dir is out"
else
    usage
fi



