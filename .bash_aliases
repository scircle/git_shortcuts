# Author:    scircle@pku.org.cn
# Copyright: https://github.com/scircle/git_shortcuts
# Date:      Apr,2014
# Version:   0.2 in Sep, 2019
#            .Use git status -s to run quickly
#            .Support untracked files

# PATH of gitFiles.awk. use absolute PATH. Neither ~ nor ${HOME} works.
export AWKFILE='/home/scircle/scripts/gitFiles.awk'
export AWKACTFILE='/home/scircle/scripts/gitActs.awk'
export AWKCMD='gawk -f '
#use difftool is you want to use git GUI tool (e.g. meld)
#export DIFFCMD='git difftool '
export DIFFCMD='git diff '

# Section 1: Files related operation
# favoriate editor
export MYEDITOR=vi

# use alias here as they could be used in command line
alias gds='git diff --cached'
alias gdc='git diff HEAD^^ HEAD '
alias gdw='git diff '
alias gc='git clean -dxf'

# u means untracked files
export GDU='git diff --no-index /dev/null'

# It takes extra work to find untracked files in the filesystem, especially
# in large working tree when -u option is not used. Use no to have git
# status return more quickly without showing untracked files.
export GITMOD='git status -s -uno '
export GITADD='git status -s '

#modifier files
#use default PAT in awk script if it's not specified in command line
alias v1='${MYEDITOR} `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=1`'
alias v2='${MYEDITOR} `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=2`'
alias v3='${MYEDITOR} `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=3`'
alias v-1='${MYEDITOR} `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=n-1`'
alias vn='${MYEDITOR} `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=n`'
# am: all modified files
# convert multiple line string into one line.
# use xargs or tr '\n' ' '
# Add -o option for xargs if editor is vi. Otherwise, it's safe to remove it.
alias vam='${GITMOD} | ${AWKCMD} ${AWKFILE} | xargs -n1 -o ${MYEDITOR}'

alias gd1='gdw `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=1`'
alias gd2='gdw `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=2`'
alias gd3='gdw `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=3`'
alias gd-1='gdw `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=n-1`'
alias gdn='gdw `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=n`'
alias gdma='gdw `${GITMOD}  | ${AWKCMD} ${AWKFILE} | xargs`'
alias gc1='git checkout -- `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=1`'
alias gc2='git checkout -- `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=2`'
alias gc3='git checkout -- `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=3`'
alias gc-1='git checkout -- `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=n-1`'
alias gcn='git checkout -- `${GITMOD} | ${AWKCMD} ${AWKFILE} -v FILEIDX=n`'
# a means all files
alias gca='git checkout -- `${GITMOD} | ${AWKCMD} ${AWKFILE} | xargs`'
alias gam='git add `${GITMOD} | ${AWKCMD} ${AWKFILE} | xargs`'

#untracked files. The middle a means add.
alias va1='${MYEDITOR} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=1`'
alias va2='${MYEDITOR} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=2`'
alias va3='${MYEDITOR} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=3`'
alias va-1='${MYEDITOR} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=n-1`'
alias van='${MYEDITOR} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=n`'
# aa: all Add files
alias vaa='${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD | xargs -n1 -o ${MYEDITOR}'

alias gda1='${GDU} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=1`'
alias gda2='${GDU} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=2`'
alias gda3='${GDU} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=3`'
alias gda-1='${GDU} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=n-1`'
alias gdan='${GDU} `${GITADD} | ${AWKCMD} ${AWKFILE} -v PAT=ADD FILEIDX=n`'
alias gdaa='${GITADD}  | ${AWKCMD} ${AWKFILE} -v PAT=ADD | xargs -n1 ${GDU}'
#no checkout alias for untracked files
alias gaa='git add `${GITADD}  | ${AWKCMD} ${AWKFILE} -v PAT=ADD`'

# Section 2: GIT activity (JIRA number)
alias gacts='git log --pretty=format:"%h : %an : %s" | ${AWKCMD} ${AWKACTFILE}'
alias gmyacts='git log --pretty=format:"%h : %an : %s" --author="`git config user.name`"| ${AWKCMD} ${AWKACTFILE}'
alias gmylact='gmyacts | head -1'
#\!:1 is applicable in csh only. We have to use function in bash.
#alias gact='git log --pretty=format:"%h : %an : %s" | ${AWKCMD} ${AWKACTFILE} -v ACT=\!:1'
alias gact='_() { git log --pretty=format:"%h : %an : %s" | ${AWKCMD} ${AWKACTFILE} -v ACT=$1;};_'
# Synonym for gact but with more clear name
alias gSHAact='_() { gact $1;};_'
alias gSHAmylact='gmylact | cut -d':' -f1'
#list of changed files in one ticket (could contain multiple delivery)
alias gact_f='_() { git show --pretty="format:" --name-only `gSHAact $1`;};_'
#list of changed files in latest delivery
alias glact_f='git show --pretty="format:" --name-only `gSHAmylact`'
alias gxdact='_() { echo `gSHAact $1` | xargs -n 1 | xargs -I {} ${DIFFCMD} "{}^" {} ;};_'
