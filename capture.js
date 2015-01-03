var page = require('webpage').create();
page.viewportSize = { width: 1024, height: 800 };
page.open('http://localhost:8000', function() {
    page.clipRect = {top: 0, left: 0, width: 1024, height: 800};
    page.render('shot.png');
    phantom.exit();
});
