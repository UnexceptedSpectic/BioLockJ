
The BioLockJ program is launched through the `biolockj` script. See [`biolockj --help`](GENERATED/biolockj-help.md).

Support programs can access information about BioLockJ modules and properties through [`biolockj-api`](GENERATED/BioLockJ-Api.md). 

There are also several helper scripts for small specific tasks, these are all found under $BLJ/script and added to the `$PATH` after the basic installation:


| Command | Description |
| :-- | :-- |
| **[last-pipeline](https://github.com/BioLockJ-Dev-Team/BioLockJ/blob/master/script/last-pipeline)** | Get the path to the most recent pipeline. |
| **cd-blj** | Go to most recent pipeline & list contents. |
| **[blj_log](https://github.com/BioLockJ-Dev-Team/BioLockJ/blob/master/script/blj_log)** | Tail last 1K lines from current or most recent pipeline log file. |
| **[blj_summary](https://github.com/BioLockJ-Dev-Team/BioLockJ/blob/master/script/blj_summary)** | Print current or most recent pipeline summary. |
| **[blj_complete](https://github.com/BioLockJ-Dev-Team/BioLockJ/blob/master/script/blj_complete)** | Manually completes the current module and pipeline status. |
| **[blj_reset](https://github.com/BioLockJ-Dev-Team/BioLockJ/blob/master/script/blj_reset)** | Reset pipeline status to incomplete.<br>If restarted, execution will start with the current module.  |
| **[blj_downlaod](https://github.com/BioLockJ-Dev-Team/BioLockJ/blob/master/script/blj_download)** | If on cluster, print command syntax to download current or most recent pipeline results to your local workstation directory: *pipeline.downloadDir*. |
