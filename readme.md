## Pages
Introduction to creating application specific user interfaces 
### Description
This sample includes a specific user interface for its application. The application
itself has just an integer variable which is incremented by a timer periodically.
The user interface presents the incrementing variable and allows to reset it via
the reset button.
There are 2 different connections used for updating the variable on the page:
1: request (get) mechanism (updated every 1000ms through polling). Can only be used uni-directional.
2: WebSocket push/get (each time variable changes). Can be used bi-directional.  How to demo this script:
Connect a web-browser to the AppEngine (localhost address "127.0.0.1") and you will
see the webpage of this sample. Use the reset-button to set the value to 0.
Use the toggle-button to turn the increment-timer on/off. In off-state the value can
be changed via the up/down buttons.  The UI itself is created using the UI builder. 
It can be found by clicking the "Pages.msdd". In the dropdown menu at the upper right "sample" can be selected.
## More Information:
See Tutorials for User Interface creation

### Topics
System, User-Interface, Getting-Started, Sample, SICK-AppSpace