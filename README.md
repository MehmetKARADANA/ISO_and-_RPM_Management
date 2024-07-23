ISO and RPM Management Script
This script allows you to manage ISO files and RPM packages. It includes functions to mount and umount ISO files, list RPM files within a mounted directory, and search for specific RPM files. Below are the details for each function and usage instructions.

Commands
mount: Mount an ISO file to a specified directory.

iso_file: The path to the ISO file to be mounted.
mount_dir: The directory where the ISO file will be mounted.
Function Description: This function mounts an ISO file to a specified directory using the mount command with the -o loop option. It verifies if the mount operation is successful and provides appropriate feedback.
umount: Umount an ISO file from a specified directory.

mount_dir: The directory where the ISO file is mounted.
Function Description: This function umounts an ISO file from a specified directory using the umount command. It checks if the umount operation is successful and provides appropriate feedback.
list: List the first 30 RPM files within the mounted ISO directory.

mount_dir: The directory where the ISO file is mounted.
Function Description: This function searches for RPM files in the mounted directory and lists the first 30 found files. It displays the files with their index numbers for easy selection.
find: Search for RPM files within the mounted ISO directory that match a specified term.

searched_rpm: The term to search for within the RPM file names.
Function Description: This function searches for RPM files in the mounted directory that contain the specified term in their names. It lists the matching files with their index numbers for easy selection.
search: Search for RPM files listed in a specified file within the mounted ISO directory.

searched_rpm_file: The file containing the list of RPM file names to search for.
mount_dir: The directory where the ISO file is mounted.
Function Description: This function reads a file containing a list of RPM file names and searches for these files in the mounted directory. It checks each file name and reports whether it is found or not.
Usage Instructions
Run the script with the appropriate command and required arguments. Ensure you have the necessary permissions to mount and umount ISO files, typically requiring sudo privileges.

Türkçe :

SO ve RPM Yönetim Scripti
Bu script, ISO dosyalarını ve RPM paketlerini yönetmenize olanak tanır. ISO dosyalarını bağlamak ve çıkarmak, bağlı dizinde bulunan RPM dosyalarını listelemek ve belirli RPM dosyalarını aramak için işlevler içerir. Aşağıda her işlevin ayrıntıları ve kullanım talimatları verilmiştir.

Komutlar
mount: Bir ISO dosyasını belirtilen bir dizine bağlayın.

iso_file: Bağlanacak ISO dosyasının yolu.
mount_dir: ISO dosyasının bağlanacağı dizin.
Fonksiyon Açıklaması: Bu fonksiyon, -o loop seçeneğiyle mount komutunu kullanarak bir ISO dosyasını belirtilen bir dizine bağlar. Bağlama işleminin başarılı olup olmadığını doğrular ve uygun geri bildirim sağlar.
umount: Bir ISO dosyasını belirtilen bir dizinden çıkarın.

mount_dir: ISO dosyasının bağlı olduğu dizin.
Fonksiyon Açıklaması: Bu fonksiyon, umount komutunu kullanarak bir ISO dosyasını belirtilen bir dizinden çıkarır. Çıkarma işleminin başarılı olup olmadığını kontrol eder ve uygun geri bildirim sağlar.
list: Bağlı ISO dizinindeki ilk 30 RPM dosyasını listeleyin.

mount_dir: ISO dosyasının bağlı olduğu dizin.
Fonksiyon Açıklaması: Bu fonksiyon, bağlı dizinde RPM dosyalarını arar ve bulunan ilk 30 dosyayı listeler. Dosyaları kolay seçim için indeks numaralarıyla gösterir.
find: Bağlı ISO dizininde belirli bir terimi içeren RPM dosyalarını arayın.

searched_rpm: RPM dosya adlarında aranacak terim.
Fonksiyon Açıklaması: Bu fonksiyon, bağlı dizinde adında belirtilen terimi içeren RPM dosyalarını arar. Eşleşen dosyaları kolay seçim için indeks numaralarıyla listeler.
search: Belirli bir dosyada listelenen RPM dosyalarını bağlı ISO dizininde arayın.

searched_rpm_file: Aranacak RPM dosya adlarının listesini içeren dosya.
mount_dir: ISO dosyasının bağlı olduğu dizin.
Fonksiyon Açıklaması: Bu fonksiyon, bir dosyada listelenen RPM dosya adlarını okur ve bu dosyaları bağlı dizinde arar. Her dosya adını kontrol eder ve bulunup bulunmadığını bildirir.
Kullanım Talimatları
Script'i uygun komut ve gerekli argümanlarla çalıştırın. ISO dosyalarını bağlamak ve çıkarmak için gerekli izinlere sahip olduğunuzdan emin olun, genellikle sudo ayrıcalıkları gerektirir.
