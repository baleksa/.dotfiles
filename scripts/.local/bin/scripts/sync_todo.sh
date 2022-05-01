#!/bin/sh
rclone bisync gdrive_void_hpi5:todo /home/baleksa/Documents/todo --exclude "todo.txt.bak" --exclude "report.txt" "$@"
