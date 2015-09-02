### Configurations

**Three Levels -- global, local and system**

1. Set email

  `git config --local user.email abc@test.com`
  
2. Set text color for all users

  `git config --system color.ui true`
  
3. Check global user name

  `git config --global user.name`
  
4. List all global configurations

  `git config --global --list`
  
  OR
  
  `cat ~/.gitconfig`

5. List all local configurations

  `git config --local --list`
  
  OR
  
  `cat .git/config`
  
6. Line Ending on Windows OS

  Mac/Linux
  `git config --global core.autocrlf input`
  
  Windows
  `git config --global core.autocrlf true`

7. Before git version 2.0, set default push repo, this will allow users can only push current branch

  `git confing --global push.default simple`

8. Git pull (rebase) 

  `git pull` => `git fetch` + `git merge`
  
  `git pull --rebase` => `git fetch` + `git rebase`
  
  
