# Project 1 - *Flixster*

**Flixster** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **15** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.
- [x] User can tap a cell to see a detail view (+5pts)
- [x] User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView (+5pts)
- [x] Movie feed view AutoLayout (+3pt)
- [x] Detail view AutoLayout (+2pt)

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [x] Movies are displayed using a CollectionView instead of a TableView.
- [ ] User can search for a movie.
- [ ] All images fade in as they are loading.
- [ ] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [ ] Customize the selection effect of the cell.
- [x] Customize the UI.
- [x] User can tap a poster in the collection view to see a detail screen of that movie (+3pts)
- [x] In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer (+3pts)
- [x] Customize the navigation bar (+1pt)
- [ ] List in any optionals you didn't finish from last week (+1-3pts)
- [ ] Dynamic Height Cells (+1)
- [ ] Collection View AutoLayout (+2)

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Any noticable differnces between Swift 3 and Swift 4
2. How others implemented the alert for a network error

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/H5c73Tx.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://i.imgur.com/7Oxe12e.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

Trying to get the alert to display **without** using a button of some sort 😕

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [PKHUD](https://github.com/pkluz/PKHUD) - A Swift based reimplementation of the Apple HUD

## License

Copyright [2019] Chavane Minto

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
