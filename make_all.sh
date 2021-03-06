#!/bin/sh
# Copyright (c) 2012 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# This script builds all ports in all possible configurations.
# If you want to be sure your change won't break anythign this is
# a good place to start.

set -x
set -e

TARGETS="$*"
TARGETS=${TARGETS:-all}
BUILD_FLAGS=--ignore-disabled

export BUILD_FLAGS

# x86_64 NaCl
NACL_ARCH=x86_64     TOOLCHAIN=clang-newlib make ${TARGETS}
NACL_ARCH=x86_64     TOOLCHAIN=glibc        make ${TARGETS}

# i686 NaCl
NACL_ARCH=i686       TOOLCHAIN=clang-newlib make ${TARGETS}
NACL_ARCH=i686       TOOLCHAIN=glibc        make ${TARGETS}

# ARM NaCl
NACL_ARCH=arm        TOOLCHAIN=clang-newlib make ${TARGETS}
NACL_ARCH=arm        TOOLCHAIN=glibc        make ${TARGETS}

# PNaCl
NACL_ARCH=le32      TOOLCHAIN=pnacl        make ${TARGETS}

# Emscripten
if [ -n "${EMSCRIPTEN:-}" ]; then
  NACL_ARCH=emscripten TOOLCHAIN=emscripten   make ${TARGETS}
fi
