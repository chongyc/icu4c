#!/bin/bash

perl Build distclean

perl Build.PL --config cc=arm-926ejs-linux-gcc --config ld=arm-926ejs-linux-gcc

perl Build


