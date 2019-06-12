var cacheName = 'wine-cellar-v1';
var dataCacheName = 'wine-cellar-data-v1';

var filesToCache = [
  '/',
  '/index.html',
  '/scripts/app.js',
  '/styles/inline.css',
  '/images/pics/block_nine.jpg',
  '/images/pics/bodega_lurton.jpg',
  '/images/pics/bouscat.jpg',
  '/images/pics/domaine_serene.jpg',
  '/images/pics/ex_umbris.jpg',
  '/images/pics/generic.jpg',
  '/images/pics/lan_rioja.jpg',
  '/images/pics/le_doyenne.jpg',
  '/images/pics/lurton-pinot-gris.jpg',
  '/images/pics/margerum.jpg',
  '/images/pics/morizottes.jpg',
  '/images/pics/rex_hill.jpg',
  '/images/pics/saint_cosme.jpg',
  '/images/pics/viticcio.jpg',
  '/images/ic_refresh_white_24px.svg'
];

self.addEventListener('install', function (e) {
  console.log('[ServiceWorker] Install');
  e.waitUntil(
    caches.open(cacheName).then(function (cache) {
      console.log('[ServiceWorker] Caching app shell');
      return cache.addAll(filesToCache);
    })
  );
});

self.addEventListener('activate', function (e) {
  console.log('[ServiceWorker] Activate');
  e.waitUntil(
    caches.keys().then(function (keyList) {
      return Promise.all(keyList.map(function (key) {
        if (key !== cacheName && key !== dataCacheName) {
          console.log('[ServiceWorker] Removing old cache', key);
          return caches.delete(key);
        }
      }));
    })
  );
  /*
   * Fixes a corner case in which the app wasn't returning the latest data.
   * You can reproduce the corner case by commenting out the line below and
   * then doing the following steps: 1) load app for first time so that the
   * initial data is shown 2) press the refresh button on the app 3) go
   * offline 4) reload the app. You expect to see the newer data, but you
   * actually see the initial data. This happens because the
   * service worker is not yet activated. The code below essentially lets
   * you activate the service worker faster.
   */
  return self.clients.claim();
});

self.addEventListener('fetch', function (e) {
  console.log('[ServiceWorker] Fetch', e.request.url);
  var dataUrl = '/wines';
  if (e.request.url.indexOf(dataUrl) > -1) {
    /*
     * When the request URL contains dataUrl, the app is asking for fresh
     * weather data. In this case, the service worker always goes to the
     * network and then caches the response. This is called the "Cache then
     * network" strategy:
     * https://jakearchibald.com/2014/offline-cookbook/#cache-then-network
     */
    e.respondWith(
      caches.open(dataCacheName).then(function (cache) {
        return fetch(e.request).then(function (response) {
          cache.put(e.request.url, response.clone());
          return response;
        });
      })
    );
  } else {
    /*
     * The app is asking for app shell files. In this scenario the app uses the
     * "Cache, falling back to the network" offline strategy:
     * https://jakearchibald.com/2014/offline-cookbook/#cache-falling-back-to-network
     */
    e.respondWith(
      caches.match(e.request).then(function(response) {
        return response || fetch(e.request);
      })
    );
  }
});
