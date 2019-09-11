# Purpose:
  How to edit the files that are not staged for commit? The straight way is to
copy one specific filename, launch one editor (e.g. vi) followed by pasting
this filename. This involves three steps (copy, vi ans paste). Is there any way
to speed this?

  Moreover, how to list all my own commits in one repo? How to list all the
files in one commit? How to diff them one by one? etc.

  Here is the recipe.
  
  ![git shortcuts overview](https://github.com/scircle/git_shortcuts/blob/master/gh1.jpg)
  
# Files and usage:
  * two AWK files (gitFiles.awk, gitActs.awk)
  * one alias file
  
  * usage
    * Add these two awk files into your one of $PATH directory 
	* copy the content of alias file into your own alias file. 
  
# Prerequisite:
    * gawk is available both on Solaris and Linux.
	
# Example:
  * Files related
  
  1) Open the first file in working area,use the "v1" alias. Open the sencond,
  use "v2". "v3" for third. "v-1" for the next to last and "vn" for the last.
   BTW: You can specify the last file without counting the number of last file.
   
  2) Open all files in one window at the same time, use "va"
  BTw: ":bn" and ":bp" to open next and previous file in vim.
    
  3) To diff the first one file in working area, use "gd1". "gd2", "gd3", 
  "gd-1" and "gdn" to diff second, third, the next to last and the last, 
  respectively.
  
  4) To diff all files, use "gda"
  
  5) You can combine this technique with git commands for other purpose, e.g.
  checkout and add.
   
   * commits related
   1) list all commits (including the commits made by others) in one repository
   use "gacts"
   
   Note: It depends on one implict rule when committing. My employer requires
   every employee to add the Jira ticket number in commit message. e.g.
   $git commit -m "ALEXA-12345"
   Thus, you need to update the PAT in gitActs.awk (around line 51). e.g
   PAT = "ALEXA"
   
   2) list my own commits in one repo, use "gmyacts". "gmylact" for my last 
   commit
   
   3) Show the brief SHA-1 of one commit, use "gact". e.g.
   $gact 12345
   
   4) Show the change-set in one ticket, use "gact_f". e.g.
   $gact_f 12345

   5) Diff the change-set one by one in one ticket (there could be multiple
   commits), use "gxdact". e.g.
   $gxdact 12345
