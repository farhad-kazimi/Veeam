# Get VM Details script
# Copy the Job list from the above output and make it in the "","" format such as "JOB_NAME_1","JOB_NAME_2","JOB_NAME_3"
# $vm_list = "a"."b"

# Run 
Get_vm_details $vm_list

# Gets a list of all created jobs
$a = Get-VBRJob use the blue line only.

$a.name it will print all the name of the jobs for you.

## Copy the Job list from above output and make it in the "","" format such as "JOB_NAME_1","JOB_NAME_2","JOB_NAME_3"

# Assigned the jobs name as an array to $job_list
$job_list = "JOB_NAME_1","JOB_NAME_2","JOB_NAME_3" 

#Given the job list to schedule jobs by default it will schedule 2 by two, if you want more you can specify after $job_list 

# It will schedule the given job names chaining 2 at a time 
schedule_jobs $job_list
