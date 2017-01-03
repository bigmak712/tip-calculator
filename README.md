# Pre-work - *Tip Calculator*

**Tip Calculator** is a tip calculator application for iOS.

Submitted by: **Timothy Mak**

Time spent: 30 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:
* [X] Saving the default tip percentage across app restarts
* [X] Changing the tip percentages and remembering them across app restarts.
* [X] Added a rounded tip/total option that will show the tip/total rounded to the nearest dollar.
* [X] Added a split check option that will calculate the total split between people.
* [X] Added color themes


## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/IbEqJiu.gif' title='Tip Calculator Walkthrough' width='' alt='Tip Calculator Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Describe any challenges encountered while building the app.

The first challenge that I encountered was actually with the basic tutorial video that was provided. Near the end of the video, we were supposed to connect the tipSegmentControl to the calculateTip function whenever its value changed. However, the Swift version in the video was outdated so when I tried following the video, it didn't work (the function didn't get highlighted when I tried to connect it). So, I had to come up with an alternative way for the tip to be recalculated whenever the tipSegmentControl value was changed. What I ended up doing was creating a valueChanged function for the tipSegmentControl and in that function, I called the calculateTip function.
    
The next big challenge that I had was getting used to UserDefaults and being able to save and load values. Since I have never worked with this before, I was totally lost. However, after I researched how to use it and how it worked, I thought of it as being similar to a hashmap data structure where you could set values and retrieve them by using some type of key. Once I made that connection, I was able to understand it and that led me to having the idea of having the user being able to change the tip percentages.

Another challenge was using GitHub and uploading the .gif walkthrough. I already had past experience connecting my terminal to my GitHub account but I had never connected my XCode projects to GitHub before, so I had to spend a lot of time researching online to figure out how to do it. Also, I've never created a .gif before so making a walkthrough and putting a link to it in my README was also very time-consuming since I had to once again look online for help. 

## License

    Copyright [2017] [Timothy Mak]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
