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
    
    mount_dir="/root/mktest/iso_folder/iso"  
   
    rpm_files=($(find "$mount_dir" -type f -name "*$searched_rpm*.rpm" | head -n 30))
    
    echo "RPM files in the ISO containing the term \"$searched_rpm\":"
  
    for i in "${!rpm_files[@]}"; do
        echo "$((i+1)). ${rpm_files[i]}"
    done
    
    echo "Enter the number of the RPM file you want to view details for:"
    read index 
    
    rpm_file=${rpm_files[$index-1]} 
    output=$(rpm -qip "$rpm_file")
 
    echo -e "$rpm_file \n$output"
}


search_rpm() {
    searched_rpm_file=$1
    mount_dir=$2

    while IFS= read -r line; do
        # skip empty lines
        if [ -z "$line" ]; then
            continue
        fi

        trimmed_line=$(echo "$line" | tr -d '[:space:]')
    #    echo "trimmed_line: $trimmed_string"
        
       
        rpm_file=$(find "$mount_dir" -type f -name "$trimmed_line")

        if [ -n "$rpm_file" ]; then
            echo "found rpm file: $rpm_file"
        else
            echo "not found: $line"
        fi
    done < "$searched_rpm_file"
    
}


# main script
if [ "$1" == "mount" ]
 then
    mount_iso "$2" "$3"
elif [ "$1" == "umount" ]
 then
    umount_iso "$2"
elif [ "$1" == "find" ]
 then
    find_rpm "$2"    
elif [ "$1" == "list" ]
 then
    list_rpm "$2"
elif [ "$1" == "search" ]
 then
    search_rpm "$2" "$3"
else
    echo "Usage: $0 [mount iso_file mount_dir |umount mount_dir|list mount_dir|search rpm_file mount_dir]"
    exit 1
fi
