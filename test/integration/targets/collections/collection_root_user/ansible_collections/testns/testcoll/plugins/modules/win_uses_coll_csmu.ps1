#!powershell

# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

#AnsibleRequires -CSharpUtil Ansible.Basic
#AnsibleRequires -CSharpUtil AnsibleCollections.testns.testcoll.MyCSMU

$spec = @{
    options = @{
        data = @{ type = "str"; default = "called from $([AnsibleCollections.testns.testcoll.MyCSMU.CustomThing]::HelloWorld())" }
    }
    supports_check_mode = $true
}
$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)
$data = $module.Params.data

if ($data -eq "crash") {
    throw "boom"
}

$module.Result.ping = $data
$module.Result.source = "user"
$module.ExitJson()