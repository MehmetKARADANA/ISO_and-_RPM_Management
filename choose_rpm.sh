#! /bin/bash

mount_iso() {

    iso_file=$1
    mount_dir=$2

    # Mount islemi
    sudo mount -o loop "$iso_file" "$mount_dir"
    if [ $? -eq 0 ]; then
        echo "The ISO file was successfully mounted: $iso_file -> $mount_dir"
    else
        echo "Error: ISO file could not be unmounted."
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
        echo "Error: ISO file could not be unmounted."
        return 1
    fi
}

list_rpm() {

    mount_dir=$1
    
    rpm_files=($(find "$mount_dir" -type f -name '*.rpm' | head -n 30))
    
    echo "0-30 RPM files:"
    
    for i in "${!rpm_files[@]}"; do
        echo "$((i+1)). ${rpm_files[i]}"
    done
    
    echo "Enter the rpm file number:"
    read $index
 
    rpm_file=${rpm_files["$index1"-1]}
    
    output=$(rpm -qip "$rpm_file")
    
    echo -e "$rpm_file \n$output"
 
}

find_rpm() {
  
    searched_rpm=$1 
    
    mount_dir=$2  
   
  
     rpm_files=($(find "$mount_dir" -type f -name "*.rpm" | grep "$searched_rpm" | head -n 0))
    
    
    
    if [ -n "$rpm_files" ]; then  
    
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

help() {

  echo "Usage:"
    echo "  ./script_name.sh <command> [arguments]"
    echo
    echo "Commands:"
    echo "  mount_iso <iso_file> <mount_dir>      Mount the specified ISO file to the specified directory."
    echo "  umount_iso <mount_dir>                Unmount the ISO file from the specified directory."
    echo "  list_rpm <mount_dir>                  List the first 30 RPM files in the specified mount directory and display information about a selected RPM file."
    echo "  find_rpm <term> <mount_dir>           Find the first 30 RPM files in the specified mount directory that contain the specified term."
    echo "  search_rpm <file> <mount_dir>         Search for RPM files listed in the specified file within the specified mount directory."
    echo "  help                                  Display this help message."  

}

# Check if a command is provided
if [ $# -lt 1 ]; then
    help
    exit 1
fi

# main script
if [ "$1" == "--mount" ]
 then
    mount_iso "$2" "$3"
elif [ "$1" == "--umount" ]
 then
    umount_iso "$2"
elif [ "$1" == "--find" ]
 then
    find_rpm "$2" "$3"   
elif [ "$1" == "--list" ]
 then
    list_rpm "$2"
elif [ "$1" == "--search" ]
 then
    search_rpm "$2" "$3"
elif [ "$1" == "--help"]
 then
  help     
else
  help
    exit 1
fi