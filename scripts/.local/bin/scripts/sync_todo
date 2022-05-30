#!/bin/sh
echo "Preview of what bisync will do:"
rclone bisync --verbose --dry-run gdrive_void_hpi5:todo /home/baleksa/Documents/todo --exclude "todo.txt.bak" --exclude "report.txt"
printf "Do the bisync? (y/n) : "
read -r ans
if [ "$ans" = "y" ]; then
    rclone bisync --verbose gdrive_void_hpi5:todo /home/baleksa/Documents/todo --exclude "todo.txt.bak" --exclude "report.txt" "$@"
    echo "Done!"
else
    echo "Skipped!"
fi
