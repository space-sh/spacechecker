#!/usr/bin/env sh

GENERATE_VARIABLES=0 GENERATE_TOC=0 space -f ../space/tools/spacedoc/Spacefile.yaml /module/ -- Spacefile.sh && \
    mv Spacefile.sh_README README.md && printf "README.md has been overwritten\n"

