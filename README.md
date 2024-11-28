# **archive and transfer tool.**

**This script allows you to compress or transfer files or directories locally or remotely.**

## **Usage:**

1. Run the script directly.
2. A menu will appear, giving you the option to compress or transfer files or directories.
3. After selecting your desired action, the script will prompt you for the required inputs, such as the source path, destination, and other relevant details.
4. The script will then process your request, whether it is to compress or transfer your file or directory locally or remotely.

### **Notes:**

1. The compression format used is `.tar.gz`.
2. File transfer utilizes the `rsync` command, with the SSH protocol employed for remote transfers.
3. You can use the `~` symbol when entering file paths.
