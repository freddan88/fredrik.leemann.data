#!/usr/bin/env bash

# https://github.com/MatMoul/g810-led

if [ "$(command -v g810-led)" ]; then
  g810-led -a 00DCFF
fi
