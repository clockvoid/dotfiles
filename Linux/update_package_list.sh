#!/bin/sh

yay -Qe | awk '{print $1}' > $(pwd)/installed_packages
