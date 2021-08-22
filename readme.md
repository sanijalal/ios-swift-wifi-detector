### Description

This is a sample application to retrieve the SSID from current connected wi-fi. It uses the Model-View-Presenter pattern. This application also has location permission implemented because in order to retrieve the SSID information, the application needs to have location permissions enabled. More info can be read [here](https://developer.apple.com/documentation/systemconfiguration/1614126-cncopycurrentnetworkinfo).

### Discussion

For the views, I was trying out creating different xibs for different states. Verdict: will not do it again. If the structure of the view is the same for different states, it's better to use the view controller to change the values retrieved from the presenter. If the views are radically different, then this approach would be ok.

