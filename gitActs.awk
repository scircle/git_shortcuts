#Author:  scircle 
#Date:    Arp 13, 2014
#Purpose: To get all commits in current repo 
#Note:    You need to update the PAT around 51. In my case, we assume 
#         the Jira ticket is prefixed by ALEXA. e.g. ALEXA-12345.

function getAllActs()
{
    #use global variable instead of local. Otherwise, the index will
    #be overrided if next record matches
    #if ($3 ~ PAT)
    #use substr() instead of $3 because there would be such record:
    #deliver.xxx_32.20120721.196841 [ALEXA-12345]
    if (substr($3,0,10) ~ PAT)
    {
        actArr[numIdx] = $0
        numIdx++
    }

}

function getActFiles()
{
    tmpActArrLen = length(actArr)
    for (i = 1; i <= tmpActArrLen; i++)
        {
        split(actArr[i],curActArr)
        if (curActArr[3] ~ ACT)
            {
            #use gsub() to remove space
            gsub(/ /,"",curActArr[1])
            fileArr[numAct] = curActArr[1]
            numAct++
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
        # You need to update the PAT here.
        PAT = "ALEXA"
        }

    #if not specified
    if (length(ACT) == 0)
        {
        ACT = -1
        }

    numIdx = 1
    numAct = 1
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
        numActArr = length(actArr)
        for (i = 1; i <= numActArr; i++)
            print actArr[i]
        }
    else
        {
        getActFiles()
        numFileArr = length(fileArr)
        if (numFileArr >= 1)
            {
            for (i = 1; i <= numFileArr; i++)
                print fileArr[i]
            }
        else
            {
            exit 1
            }
        }
}
