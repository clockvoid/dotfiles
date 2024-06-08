#!/bin/sh

yay -Qe | awk '{print $1}' > $(pwd)/Linux/installed_packages
