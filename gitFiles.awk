#Author:  scircle
#Date:    Arp 7, 2014
#Purpose: To get one specified or all file name(s) either in
#         working or stage mode of GIT.
#         This is handy and powerful when using together with 
#         other commands, such as edit, diff, co and etc.

function getFileList()
{
    #Do NOT use /PAT/ as it's regexp constant(i.e. a string of
    #characters between slashes). Instead we use dynamic regexp.
    #if ($1 ~ /PAT/)

    if ($1 ~ PAT)
        {
        #print "match one"
        #use global variable instead of local. Otherwise, the index will
        #be overrided if next record matches
        arr[numIdx] = $2
        numIdx++
        }
}

BEGIN {
    FS=":"

    #initialize PAT to "modified"(searching for working sets)
    #if pattern not specified
    if (length(PAT) == 0)
        {
        PAT = "modified"
        }

    #initialize FILEIDX to -1 to return ALL possbile records(fileNames)
    #if not specified
    if (length(FILEIDX) == 0)
        {
        FILEIDX = -1
        }

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
        #print $0 
        getFileList()
    }

}

END {
    if (length(arr) > 1)
        numIdx--

    # all if FILEIDX not specified
    if (FILEIDX == -1)
        {
        #for (x in arr)
        #for (x in arr) doesn't select the indexes in numberic order.
        numFiles = length(arr)
        for (i = 1; i <= numFiles; i++)
            print arr[i]
        }
    #designated one
    else if (FILEIDX in arr)
        print arr[FILEIDX]
    #last one
    else if (FILEIDX == "n")
        print arr[numIdx]
    #last but one
    else if (FILEIDX == "-1")
        {
        print arr[--numIdx]
        }
    else
        exit 1
}
