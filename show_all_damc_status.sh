#!/bin/bash
#---------------------------------------------------------------------------------------#
# Script: show_sensor_fan_fenced_stats
# Author: Walied Arulandu
# Created on: Thu 07 Apr 2022 08:20:16 SAST
# Description: Collect various stats and status of components using proprietary teradata comamnds.
# Modified on: Thu 07 Apr 2022 08:20:16 SAST
#--------------------------------------------------------------------------------------#
#
#
mapped_names_of_controllers='39.80.8.3   DAMC001-3
39.80.8.7   DAMC001-7
39.80.8.11  DAMC001-11
39.80.8.19  DAMC001-19
39.80.8.23  DAMC001-23
39.80.16.7  DAMC002-7
39.80.16.11 DAMC002-11
39.80.16.19 DAMC002-19
39.80.24.3  DAMC003-3
39.80.24.7  DAMC003-7
39.80.24.11 DAMC003-11'

list_of_controllers='39.80.8.3   
39.80.8.7   
39.80.8.11  
39.80.8.19  
39.80.8.23  
39.80.16.7  
39.80.16.11 
39.80.16.19 
39.80.24.3  
39.80.24.7  
39.80.24.11'

timestamp=$(date "+%Y%m%d_%H%M%S")
log_path=/var/opt/teradata/packages/patches/damc_env_logs

cd $log_path

echo -e "\n\nJob $timestamp starting\n" 

for controller in $list_of_controllers
do
  echo Checking health for disk array controller $controller now...
  log_file_name=damc-$controller-health_status-$timestamp.log
  log_file_location=$log_path/$log_file_name
  touch $log_file_location
  echo -e "Writing to $log_file_location now...\n"
  cd $log_path
  ./show_a_damc.sh $controller >> $log_file_location
done

echo -e "\nCompressing all log files...\n"

tar cvjf damc-all-health_status_logs-$timestamp.tar.bz2 damc-*-health_status-$timestamp.log

echo -e "\nMoving log files to $log_path/old...\n"
mv -v $log_path/damc-*-health_status-$timestamp.log $log_path/old/

echo -e "\nCleanig up log files\n"
rm -v $log_path/old/damc-*-health_status-$timestamp.log

echo -e "\nThe $timestamp job has completed...\n\n"
