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
  
9. Set git pull rebase as default

  `git config --global pull.rebase true`
  
10. Configuring Reused Recorded Resolution 
    it will record all the fixes to merge conflicts
    reuses them automatically if the same conficts occur

   `git config --global rerere.enabled true`

11. Git status -s -- have beautiful output
    
   `git status -s`

   `git config --global alias.s "status -s"`

12. Nice git log output

   `git config --global alias.lg "log --oneline --decorate --all --graph"` 

=

**Amend -- add new files to the last commit**

`git commit --amend -m "overwrite last commit"`

=

**Show all remote branches and status**

`git remote show origin`

=

**To clean up deleted remote branches**

`git remote prune origin`

=

**Git Tag**

1. list all tags

   `git tag`

2. add tag

   `git tag -a v0.0.3 -m "add tag version 0.0.3"`
   
3. push new tag

   `git push --tags`
