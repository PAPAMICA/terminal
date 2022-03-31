#compdef cheat
local commandes
_debian_completions()
{
  commandes=(stop snap list rollback delete temp)
  _describe -t commandes 'commandes' commandes
}


compdef _debian_completions debian