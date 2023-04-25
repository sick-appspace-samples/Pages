## Pages

Introduction to creating application specific user interfaces

### Description

This sample includes a specific user interface for its application. The application itself has an integer variable which is incremented by a timer periodically.
The user interface presents the incrementing variable, allows to reset it via a button and controlling if the timer is on or off. It is build with the UI-builder integrated in AppStudio. The UI-builder can be opened by clicking on the html file under page component -> pages -> pages01 -> main.html. When there is not yet a UI present in the App, the UI component and the UI files have to be created via the context menu in the working directory before the UI-builder can be used.
There are different UI elements and mechanisms for UI communication (bindings) shown in this sample.

**ValueDisplay**
1. Retrieve counter value through polling a function every 1000ms. Crown-binding from value property to served get function with auto-update 1000
2. Retrieve counter value by listening to an event raised in the script when the counter changes. Crown-edpws-binding from value property to served event.

**NumericField**
1. Set counter value by calling a set function. Crown-binding from change event to served set function.

**Button**
1. Submit button click to reset counter. Crown-binding from submit event to served function.

**ToggleSwitch**
1. Change state of timer by calling a set function. Crown-binding from change event to served function.
2. Get initial state of timer on page reload by calling get function. Crown-binding from checked property to served function with update-on-resume.
3. Synchronize state change between UI elements locally in the UI. Local-binding from change event to ui-internal topic. (internal-binding currently only supported in UI-builder code view)

**ValueDisplay**
1. Get initial state of timer on page reload by calling get function with conversion. Crown-binding from value property to served function with a typescript converter function in place to convert the boolean values to readable strings with update-on-resume. The converter is defined in the converter.ts file and referenced in the binding.
2. Get UI-internal timerState to be in sync with the toggle button with conversion. Local-binding from value property to ui-internal topic with  with a typescript converter function in place to convert the boolean values to readable strings. The converter is defined in the converter.ts file and referenced in the binding.. (internal-binding currently only supported in UI-builder code view)

**Collapse**
1. Collapse/expand with the state change of the Timer toggle switch via UI-internal binding. Local-binding between open property and ui-internal topic. (internal-binding currently only supported in UI-builder code view)
2. Get initial state of timer for collapse/expand on page reload by calling get function. Crown-binding from open property to served function with update-on-resume.

**ValueDisplay**
1. Retrieve value from sopas parameter. Sopas-binding to parameter variable defined in .cid.xml file.
**Slider**
1. Retrieve value from sopas parameter on page reload. Sopas-binding from value property to parameter defined in .cid.xml file with update-on-resume.
2. Change value of sopas parameter after moving the slider. Sopas-binding from change event to parameter parameter defined in .cid.xml.

### How To Run

This sample can be run on the Emulator or on a device. After starting, the user interface can be seen at the DevicePage in AppStudio or by using a web browser.
Input number in input field sets the value.
The reset-button to set the value to 0.
The toggle-button turns the increment timer on/off.
The slider sets the period of the increment timer.

### More Information

See Tutorials for User Interface creation

### Topics

system, user-interface, getting-started, sample, sick-appspace