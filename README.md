# MuseumHeatMap

This repository is the technical resources and documentation of the Museum Heat Map project between Nanna Holdgaard and Intermedia Lab.

The project has two main parts.

1. A camera module set up to take photos at given intervals. This runs on a Raspberry Pi using a camera and pre installed software.

2. A data analysis software used for analyzing the datasets of omages produced by the camera module. This runs on the Processing programming platform.


SETUP INSTRUCTIONS

Raspberry Pi
Model:

Install Motion software
Link:

Setup
Installing NOOB on a MS-DOS formatted sd card

Mooving the cronfiles folder to new installation

installing Motion_ sudo apt-get install motion

Walking through the Motion config file and making same changes as in the old one

Setting cronjob up: crontab -e
- then copy pasting commands from file from old installation

correcting the permissions for all files in cronfiles folder, execute right was set to nobody, i changed it to anyone
