# Disable a given job schedule
# Prepared by Farhad Kazimi
function disable_job($job_name){
    $job = Get-VBRJob -Name $job_name
    if ($job){
        Disable-VBRJobSchedule -Job $job
    }else {
        echo "Unable to find $job_name"
    }
}

# Enable a given job schedule
function enable_job($job_name){
    $job = Get-VBRJob -Name $job_name
    if ($job){
        Enable-VBRJobSchedule -Job $job
    }else {
        echo "Unable to find $job_name"
    }
}

# Reset a given job schedule to its default
function reset_job($job_name){
    $job = Get-VBRJob -Name $job_name
    if ($job){
        Reset-VBRJobScheduleOptions -Job $job
    }else {
        echo "Unable to find $job_name"
    }
}

# Given an array containing jobs name, it will iterate through and disable all of them
function disable_all_jobs($job_list){
    foreach ( $job_name in $job_list ){
        disable_job($job_name)
    }
}

# Given an array containing jobs name, it will iterate through and reset all of them
function reset_all_jobs($job_list){
    foreach ( $job_name in $job_list ){
        reset_job($job_name)
    }
}

# Given an array containing job names, it will iterate through and shedule all of them
# according to the specified offset. If no offset is specified default will be 2
function schedule_jobs($job_list, $off_set=2){
    $cnt = 0
    $index = 0
    foreach ( $job_name in $job_list ){
		echo "---"
        $job = Get-VBRJob -Name $job_name
        echo "cnt: $cnt - off_set: $off_set - index: $index - jobname: $job_name"
        if ($job){
            if ($cnt -lt $off_set){
                $cnt = $cnt + 1
                reset_job($job_name)
                disable_job($job_name)
                continue
            }
            $index = $cnt - $off_set
            $after_job = $job_list[$index]
            Set-VBRJobSchedule -Job $job -After -AfterJob $after_job
            enable_job($job_name)
        }else {
            echo "Unable to find $job_name"
        }
        $cnt = $cnt + 1
    }
}

# Preview how given jobs will look like after scheduling
function preview_schedule_jobs($job_list){
    $cnt = -1
    $off_set = 2
    $index = 0
    foreach ( $job_name in $job_list ){
        $cnt = $cnt + 1
        if ($cnt -lt $off_set){
            echo "index: $cnt - job: $job_name"
            echo "----"
            continue
        }
        $index = $cnt - $off_set
        $after_job = $job_list[$index]

        echo "index: $cnt - job: $job_name - after - $after_job - index: $index"
        echo "----"

    }
}
