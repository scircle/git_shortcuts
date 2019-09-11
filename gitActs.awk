#Author:    scircle@pku.org.cn
#Copyright: https://github.com/scircle/git_shortcuts
#Date:      Arp 13, 2014
#
#Purpose:   To get all commits in current repo
#
#Version:   0.2 in Sep, 2019
#           . Change both numIdx and numAct from 1 to 0
#	        . remove gawk extension warning by turning on gawk --lint
#
#Note:      You must change the PAT(around line 57) to your project name.
#           Here, we assume it's MESOS (your JIRA ticket would be
#           MESOS-3661)

function getAllActs()
{
    #use global variable instead of local. Otherwise, the index will
    #be overrided if next record matches
    #if ($3 ~ PAT)
    #use substr() instead of $3 because there would be such record:
    #deliver.scircle_ml2.20120626.192881 [XXX-3021]
    if (substr($3,0,10) ~ PAT)
    {
        actArr[numIdx++] = $0
    }

}

function getActFiles()
{
    for (i = 0; i < numIdx; i++)
        {
        split(actArr[i],curActArr)
        if (curActArr[3] ~ ACT)
            {
            #use gsub() to remove space
            gsub(/ /,"",curActArr[1])
            fileArr[numAct++] = curActArr[1]
            }
        }
}

BEGIN {
    #if FS not specified, i.e. DEFAULT
    if (FS == " ")
        {
        FS=":"
        }

    IGNORECASE=1

    #if pattern not specified
    if (length(PAT) == 0)
        {
        #use two \\ because string constant is scanned twice if special
	#character in pattern
        PAT = "MESOS"
        }

    #if not specified
    if (length(ACT) == 0)
        {
        ACT = -1
        }

    numIdx = 0
    numAct = 0
}

#BODY
{
    #filter
    if (NF < 3)
    {
        next
    }
    else
    {
        getAllActs()
    }
}

END {

    if (ACT == -1)
        {
        #for (x in arr) doesn't select the indexes in numberic order.
        for (i = 0; i < numIdx; i++)
            print actArr[i]
        }
    else
        {
        getActFiles()
        for (i = 0; i < numAct; i++)
            print fileArr[i]
        }
}
