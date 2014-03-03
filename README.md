# ganglia-cookbook

A simple chef cookbook for installing and configuring ganglia. It does not support installing `gmetad` or the ganglia web interface currently.

- Install and configure ganglia from source (Issues with ganglia on ubuntu 13.04)
- Install and configure `gmond`
- Locate other `gmond` instances tagged as receivers in the same chef environment
- Trigger uploading of metrics to a Graphite host every minute (discovered by chef search)
