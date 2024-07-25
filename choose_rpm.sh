#! /bin/bash

mount_iso() {

    iso_file=$1
    mount_dir=$2

    # Mount islemi
    sudo mount -o loop "$iso_file" "$mount_dir"
    if [ $? -eq 0 ]; then
        echo "The ISO file was successfully mounted: $iso_file -> $mount_dir"
    else
        echo "Error: ISO file could not be mounted."
        return 1
    fi
}

umount_iso() {
   
    mount_dir=$1

    # Unmount islemi
    sudo umount "$mount_dir"
    if [ $? -eq 0 ]; then
        echo "The ISO file was successfully unmounted: $mount_dir"
    else
        echo "Error: ISO file could not be umounted."
        return 1
    fi
}


find_rpm() {
  
    searched_rpm=$1 
    
    mount_dir=$2  
   
  
     rpm_files=($(find "$mount_dir" -type f -name "*.rpm" | grep "$searched_rpm" | head -n 100))
    
    
    
    if [ ${#rpm_files[@]} -gt 0 ]; then  
    
    echo "RPM files containing the term \"$searched_rpm\" were found in the ISO:"
    echo ""
      
    for i in "${!rpm_files[@]}"; do
        echo "$((i+1)). ${rpm_files[i]}"
    done
    
    else
        echo "No RPM files in the ISO containing the term \"$searched_rpm\" were found."
    fi    
   
}


search_rpm() {
    searched_rpm_file=$1
    mount_dir=$2

    while IFS= read -r line; do

        trimmed_line=$(echo "$line" | tr -d '[:space:]')
        #echo "trimmed_line: $trimmed_string"
        
        # skip empty lines
        if [ -z "$trimmed_line" ]; then
            continue
        fi
       
        rpm_file=$(find "$mount_dir" -type f -name "$trimmed_line")

        if [ -n "$rpm_file" ]; then
            echo "found rpm file: $rpm_file"
        else
            echo "not found: $line"
        fi
    done < "$searched_rpm_file"
    
}

find_latest_iso() {
    directory_path="$1"

    if [ -z "$directory_path" ]; then
        echo "Usage: $0 <directory_path>"
        return 1
    fi

    if [ ! -d "$directory_path" ]; then
        echo "Error: Directory '$directory_path' not found."
        return 1
    fi

    # Find the most recent .iso file in the specified directory
    latest_iso=$(ls -lt "$directory_path"/*.iso 2>/dev/null | head -n 1 | awk '{print $NF}')

    if [ -z "$latest_iso" ]; then
        echo "No .iso files found in the directory."
    else
        echo "The most recent .iso file is: $latest_iso"
    fi
}        

help() {
    echo "Usage:"
    echo "  ./script_name.sh <command> [arguments]"
    echo
    echo "Commands:"
    echo "  --mount ISO_FILE MOUNT_DIR          Mount the specified ISO file to the specified directory."
    echo "  --umount MOUNT_DIR                  Unmount the ISO file from the specified directory."
    echo "  --find TERM MOUNT_DIR               Find the first 30 RPM files in the specified mount directory that contain the specified term."
    echo "  --search FILE MOUNT_DIR             Search for RPM files listed in the specified file within the specified mount directory."
    echo "  --help                              Display this help message."
    echo "  --find_iso DIRECTORY_PATH           Find the most recent .iso file in the specified directory."
}


# main script
if [ "$#" -eq 0 ]; then
    help
    exit 1
fi

if [ "$1" == "--mount" ]; then
    if [ "$#" -ne 3 ]; then
        help
        exit 1
    fi
    mount_iso "$2" "$3"

elif [ "$1" == "--umount" ]; then
    if [ "$#" -ne 2 ]; then
        help
        exit 1
    fi
    umount_iso "$2"

elif [ "$1" == "--find" ]; then
    if [ "$#" -ne 3 ]; then
        help
        exit 1
    fi
    find_rpm "$2" "$3"

elif [ "$1" == "--search" ]; then
    if [ "$#" -ne 3 ]; then
        help
        exit 1
    fi
    search_rpm "$2" "$3"

elif [ "$1" == "--find_iso" ]; then
    if [ "$#" -ne 2 ]; then
        help
        exit 1
    fi
    find_latest_iso "$2"

elif [ "$1" == "--help" ]; then
    help

else
    echo "Invalid option: $1"
    help
    exit 1
fi