### Description

This is a sample application to retrieve the SSID from current connected wi-fi. It uses the Model-View-Presenter pattern. This application also has location permission implemented because in order to retrieve the SSID information, the application needs to have location permissions enabled. More info can be read [here](https://developer.apple.com/documentation/systemconfiguration/1614126-cncopycurrentnetworkinfo).

> <img width="767" alt="Screenshot 2021-08-22 at 3 24 39 PM" src="https://user-images.githubusercontent.com/43534043/130346322-9669815c-2964-4a24-a45d-bcc1c3436b47.png" border=1>

### Discussion

For the views, I was trying out creating different xibs for different states. Verdict: will not do it again. If the structure of the view is the same for different states, it's better to use the view controller to change the values retrieved from the presenter. If the views are radically different, then this approach would be ok.

