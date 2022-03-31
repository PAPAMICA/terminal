#compdef cheat
local instances
_oss_completions()
{
  instances=("${(f)$(openstack server list --column Name --format value)}")
  _describe -t instances 'instances' instances
}


compdef _oss_completions oss