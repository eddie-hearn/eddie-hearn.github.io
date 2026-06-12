import sys

log_file = open("basic-py.log", "w")
sys.stdout = log_file

print("")
print("************************************")
print("** File-Name:	basic.py          **")
print("** Author:		Eddie Hearn       **")
print("** Purpose:		Seminar           **")
print("** Program:		python3           **")
print("** OS:			Debian GNU/Linux  **")
print("************************************")
print("")                                       

# Create a list of juices 
juice = ["apple", "orange", "grape"] 

# Run loop over each type of juice
for i in juice:
    print(i, "juice") 

# Close the log 
log_file.close()
