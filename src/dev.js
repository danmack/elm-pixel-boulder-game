'use strict';

require('./static/style.css');
const Elm = require('./elm/Main.elm');

let app = Elm.Main.fullscreen({
  scene: [
    "#########################################",
    "#.......................................#",
    "#.......................................#",
    "#|||||||||..........P...................#",
    "#|**| O  O..............................#",
    "#|**| || |..............................#",
    "#|**| || |..............................#",
    "#|**| || |..............................#",
    "#|**| ||=|..............................#",
    "#|**| ||||..............................#",
    "#|**| ||*|..............................#",
    "#|**|E||*|..............................#",
    "#|||||||||..............................#",
    "#.......................................#",
    "#.......................................#",
    "#.......................................#",
    "#.......................................#",
    "#.......................................#",
    "#########################################"
  ]
});
