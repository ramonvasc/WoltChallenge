# WoltChallenge
A user is walking around Helsinki city centre looking for a place to eat. Done in Swift 5, using MVVM.

Task:
Build an app that displays a list of venues for the current location of user. The list should contain a maximum of ​15​ venues. If the server response has more then use the first ​15​.
Current location is taken from the input list and changes every ​10​ seconds (your app should refresh the list automatically).
Each venue also has “Favorite” action next to it. “Favorite” works as a toggle (true/false) and changes the icon depending on the state. Your app should remember these states and reapply them to venues that come from the server again.