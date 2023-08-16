# Collect VMs details
# Prepared by Farhad Kazimi
function get_vm_details($vm_list){
    # Get runtime date
    $date = Get-Date -format yyyMMdd_HHmmss

    # Output File
    $file_name = 'veeam_vm_details_' + $date + '.txt'

    # List of VMs in quotes separated by commas (e.g.: "server1","server2")
    if (-Not $vm_list){
        Write-Host "You must specify an array with VMs name which you want to collect details"
        Write-Host "E.g.:"
        Write-Host '    get_vm_details "vm_name1","vm_name2","vm_name3"'
        Write-Host "or"
        Write-Host '    get_vm_details $vm_list'
        return
    }

    # Create initial output file with header
    "VM Name,VM Status,VM State,VM UUID,VM Hostname,VM Path,VM Provisioned Size(Bytes),VM Used Size(Bytes),VM Provisioned Size(GB),VM Used Size(GB),VM Report File">> $file_name

    # Create Replication Job
    foreach ( $vm in $vm_list ){
        $vms_detail = Find-VBRViEntity -Name $vm

        if (-Not $vms_detail){
            $status = "VM Not Found"

            # Write output to file
            $vm + "," + $status >> $file_name
        }else {
            foreach ( $vm_detail in $vms_detail ) {
                $status = 'VM Found'
                $path = $vm_detail.path
                $hostname = $vm_detail.vmhostname
                $uuid = $vm_detail.uuid
                $state = $vm_detail.powerstate
                $provisioned_size = $vm_detail.provisionedsize
                $used_size = $vm_detail.usedsize
                $provisioned_size_gb = $provisioned_size/1024/1024/1024
                $provisioned_size_gb = "{0:N2}" -f $provisioned_size_gb -replace ",", ""
                $used_size_gb = $used_size/1024/1024/1024
                $used_size_gb = "{0:N2}" -f $used_size_gb -replace ",", ""

                # Write output to file
                $vm + "," + $status + "," + $state + "," + $uuid + "," + $hostname + "," + $path + "," + $provisioned_size + "," + $used_size + "," + $provisioned_size_gb + "," + $used_size_gb + "," + $file_name >> $file_name
            }
        }
    }
}
