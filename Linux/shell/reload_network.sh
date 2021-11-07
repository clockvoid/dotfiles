#!/bin/bash

modprobe -r iwlmvm && modprobe -r iwlwifi && modprobe iwlwifi
rmmod btusb && modprobe btusb
