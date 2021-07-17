# Automation_Project

There is script file named automation which basically install apache service and checks if its not running then makes the tar of access.log and error.log from /var/log/apache2/ folder and sends it to the configured s3 bucket named upgrad-yashraj.

Added a cron job and a inventory list which display the list of log type, log date, file type, file size and runs the automation script for every day at 12:00 AM.

Note: Here table.sh is add to create/modify the inventory.txt or inventory list to a html format and send it to /var/www/html folder to check the details via (IP/inventory.html)
