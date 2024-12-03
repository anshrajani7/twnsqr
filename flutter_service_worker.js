'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "f393d3c16b631f36852323de8e583132",
"main.dart.js": "6699a4e1dad320ba68b40be11ca4007a",
"assets/FontManifest.json": "85d86ee1de9cc2609401f513506f6efa",
"assets/AssetManifest.bin": "5206bc18f5c309a3caf3c6a2b5a22794",
"assets/fonts/MaterialIcons-Regular.otf": "7d09f1f67b66f9b939a9c1f075ee9c22",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/assets/fonts/SFPRODISPLAYMEDIUM.otf": "51fd7406327f2b1dbc8e708e6a9da9a5",
"assets/assets/fonts/SFPRODISPLAYTHINITALIC.otf": "9d5ed420ac3a432eb716c670ce00b662",
"assets/assets/fonts/SFPRODISPLAYLIGHTITALIC.otf": "bee8986f3bf3e269e81e7b64996e423c",
"assets/assets/fonts/SFPRODISPLAYULTRALIGHTITALIC.otf": "fa570fc4ded697c72608eae4e3675959",
"assets/assets/fonts/SFPRODISPLAYSEMIBOLDITALIC.otf": "fce0a93d0980a16d75a2f71173c80838",
"assets/assets/fonts/SFPRODISPLAYBOLD.otf": "644563f48ab5fe8e9082b64b2729b068",
"assets/assets/fonts/SFPRODISPLAYHEAVYITALIC.otf": "d70a8b7adbe065dd69b16459ffab4231",
"assets/assets/fonts/SFPRODISPLAYBLACKITALIC.otf": "647ad7b734271f858d61a94283fd0502",
"assets/assets/fonts/SFPRODISPLAYREGULAR.otf": "aaeac71d99a345145a126a8c9dd2615f",
"assets/assets/svg/search.svg": "5713ee6fb10ef5058e93546cab3b815e",
"assets/assets/svg/calendar.svg": "15ee74bd5a9f191a537fdab1412520ac",
"assets/assets/svg/users.svg": "6428935ce16a39580c94e2cd1507acc3",
"assets/assets/svg/map-pin.svg": "5383e623ee2b8903703608d0a2ef7373",
"assets/assets/svg/bell.svg": "08b31db6ddefae63c1b6bc1034297dbc",
"assets/assets/svg/sliders.svg": "9875bf1d4d675ade3ee9fb2f665af4de",
"assets/assets/svg/plus-2.svg": "2e8a440fd5e763aec722cdcb3bf447da",
"assets/assets/svg/user.svg": "bf03dcdd8aed0618ed48b494d5bca11f",
"assets/assets/svg/map.svg": "06ec55d7a50af24c9f8ff7d7a043ed14",
"assets/assets/svg/plus.svg": "6b7a0855dcc1f69d9cf1ee01b6ed3caf",
"assets/assets/svg/star.svg": "42ea739fe734ef1ff4b8b1fef8ce79ed",
"assets/assets/svg/event.svg": "ebf7e1bb095c1d8d00ad14911e8dd5a0",
"assets/assets/svg/arrow-right-circle.svg": "47fd21d360b146c4297eac57bf819444",
"assets/assets/png/Profiles.png": "eb07ad621ea6ff616bfbd345c9845220",
"assets/assets/png/arrow-right-circle.png": "5b55e4251794a44b075c0aef976386a9",
"assets/assets/png/event.png": "37f7cb8cf2cadb4a314476ed394d2c0b",
"assets/assets/png/user.png": "712f5dcaa0322fc5bcfec948fddd99c5",
"assets/NOTICES": "bdace54201e910102def30681edc317c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "069b14509e004f7757d0dbae377a28a9",
"assets/AssetManifest.bin.json": "8fb30ea64dd429866d0b34407730c05d",
"index.html": "90100e85076b696bbbd37b7f1a799792",
"/": "90100e85076b696bbbd37b7f1a799792",
"manifest.json": "b71d7dc3c9d5072c5913ddadbfa96bb8",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "b2a68bc3d79c1c5d695cccd55bc4b403",
"flutter_bootstrap.js": "3747d2b59c7d3fc4cc4bdd034cdc293c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
