This module creates the yaml based pipelines to execute the ci/cd for the IaC setting the stage for 3 environments (dev, test & prod)  We will isolate by resource groups here, but realistically you would isolate by subscription.

You may need to made additions to the IaC to facilitate things like deployment service principals or key vault key value pairs.  Do what you need to do.