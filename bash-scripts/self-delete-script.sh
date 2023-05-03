#this scritp excuted and delete itself 
echo "testing"
#here the commnad to delete itself "shred -u script name"
# here $0 means script name
shred -u "$0"
