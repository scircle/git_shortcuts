#Author:    scircle@pku.org.cn
#Copyright: https://github.com/scircle/git_shortcuts
#Date:      Arp 7, 2014
#
#Purpose:   To get one specified or all file name(s) either in
#           working or stage mode of GIT.
#           This is handy and powerful when using together with
#           other commands, such as edit, diff, co and etc.
#
#Version:   0.2 made in Sep, 2019
#           . Minor update FS and PAT in BEGIN block to adapt the usage
#             of "git status -s"
#           . Add support added files

function getFileList()
{
    #Do NOT use /PAT/ as it's regexp constant(i.e. a string of
    #characters between slashes). Instead we use dynamic regexp.
    #if ($1 ~ /PAT/)

    if ($1 ~ PAT)
        {
        #use global variable instead of local. Otherwise, the index will
        #be overrided if next record matches
        arr[numIdx++] = $2
        }
}

BEGIN {
    #FS=":" if "-s" is NOT specified in "git status". Otherwise, use one space
    FS=" "

    #initialize PAT to "modified"(searching for working sets)
    #if pattern not specified
    if (length(PAT) == 0)
        {
	#use "modified" as default pattern if "-s" is NOT specified in
	#"git status". Otherwise, use M (meaning modifier, see git help status)
	#PAT = "modified"

	#if "git status -s" used
        PAT = "M"
        }
    else if (PAT == "ADD")
        {
	# must use double back slash
        PAT = "\\?\\?"
        }

    #initialize FILEIDX to -1 to return ALL possbile records(fileNames)
    #if not specified
    if (length(FILEIDX) == 0)
        {
        FILEIDX = -1
        }

    #base is 1
    numIdx = 1
}

#BODY
{
    #filter
    if (NF != 2)
    {
        next
    }
    else
    {
        getFileList()
    }

}

END {
    if (length(arr) > 1)
        numIdx--

    # all if FILEIDX not specified
    if (FILEIDX == -1)
        {
        #for (x in arr) doesn't select the indexes in numberic order.
        for (i = 1; i <= numIdx; i++)
            print arr[i]
        }
    #designated one
    else if (FILEIDX in arr)
        print arr[FILEIDX]
    #last one
    else if (FILEIDX == "n")
        print arr[numIdx]
    #last but one
    else if (FILEIDX == "n-1")
        {
        print arr[--numIdx]
        }
    else
        exit 1
}
