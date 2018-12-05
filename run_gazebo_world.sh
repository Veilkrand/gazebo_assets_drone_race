#!/bin/sh

# Source Gazebo model path to include this package models
. $(pwd)/gazebo_assets_setup.sh

roslaunch gazebo_assets_drone_race test_track.launch
