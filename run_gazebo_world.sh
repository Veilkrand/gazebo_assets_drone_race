#!/bin/sh

# Source Gazebo model path to include this package models
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$(pwd)/models

roslaunch gazebo_assets_drone_race test_track.launch
