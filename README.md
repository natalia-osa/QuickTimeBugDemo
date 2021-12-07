## BACKGROUND:
With iOS 15 there are changes to keyboard handling. Besides usual overriding of `keyCommands` a programmer has to assign own commands higher priority than system commands by using `wantsPriorityOverSystemBehavior` flag. Otherwise, custom actions on key presses won't work.

## WHAT IS THE ISSUE:
If we use `QLPreviewController` we cannot override keyboard presses in iOS 15 when we set `wantsPriorityOverSystemBehavior` to `true`. The registered key commands are not working. This functionality was working perfectly before the flag was introduced. It works properly if we use `UIViewController`, so it seems `QLPreviewController` was not updated to handle the new iOS flag.
Please see the [VIDEO](https://www.dropbox.com/s/7ohkzeurh8kcpiw/Bug_presentation.mov?dl=0) I recorded for you (it includes my audio description, so turn on the volume) for more details. During watching, keep in mind, that `PreviewViewController` is a subclass of `QLPreviewController` with overridden `keyCommands` property (as you can see in the attached demo project).

### WHAT RESULTS ARE EXPECTED:
The overridden keyboard presses should work with `QLPreviewController` in the same way as they do with `UIViewController`.

### WHAT RESULTS YOU ACTUALLY SAW:
The overridden keyboard presses were ignored by `QLPreviewController`, but they work fine with `UIViewController`.

## WHAT IS MY SUSPICION OF THE ROOT OF THE ISSUE:
When I clicked on `Debug View Hierarchy`, I noticed on the top of my `PreviewViewController` (which is a subclass of `QLPreviewController` with overriding `keyCommands` only) there is `UINavigationController` with `QLRemotePreviewCollection`. Maybe that last one is capturing `keyCommands` and since it treats them as top priority, it doesn't pass that information to my instance. The issue is that I do not have access to that `QLRemotePreviewCollection` to override `keyCommands` there.

## MORE:
I've submitted it also in:

* [https://developer.apple.com/forums/thread/696128](https://developer.apple.com/forums/thread/696128)
* [https://stackoverflow.com/questions/70250053/uikeycommand-in-qlpreviewcontroller-in-ios-15](https://developer.apple.com/forums/thread/696128)

Please make sure you check it out at any of the links there. It contains manual repro steps. But you can also download & run the code in this repository. It's as short as possible to show the issue.

## REPRODUCTION STEPS:
Please open attached simple demo project to be able to reproduce the issue (you have to build it with iOS 15 SDK). Please follow the red text on the top of the simulator. Reproduction steps are also written in the linked thread (at the end of this bug report description) if you don't want to open the demo project.