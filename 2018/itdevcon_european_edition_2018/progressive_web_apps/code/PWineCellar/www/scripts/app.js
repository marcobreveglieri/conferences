(function () {
  'use strict';

  // Contiene informazioni chiave per l'applicazione.
  var app = {
    isLoading: true,
    spinner: document.querySelector('.loader'),
    cardTemplate: document.querySelector('.cardTemplate'),
    container: document.querySelector('.main'),
    visibleCards: {},
    lastWines: []
  };

  app.bindWineCard = function (data) {

    var wine = {
      id: data.id, // 2
      name: data.name, // "LAN RIOJA CRIANZA"
      year: data.year, // "2006"
      grapes: data.grapes, // "Tempranillo"
      country: data.country, // "Spain"
      region: data.region, // "Rioja"
      description: data.description, // "A resurgence of interest in boutique vineyards..."
      picture: data.picture ? data.picture : "generic.jpg" // "url.jpg"
    };

    var card = app.visibleCards[wine.id];

    if (!card) {
      card = app.cardTemplate.cloneNode(true);
      card.classList.remove('cardTemplate');
      card.querySelector('.grapes').textContent = wine.grapes;
      card.querySelector('.name').textContent = wine.name;
      card.querySelector('.year').textContent = wine.year;
      card.querySelector('.profile').textContent = wine.description;
      card.querySelector('.country').textContent = wine.country;
      card.querySelector('.region').textContent = wine.region;
      card.querySelector('.details .icon').style.backgroundImage = `url(images/pics/${wine.picture})`;
      card.removeAttribute('hidden');
      app.container.appendChild(card);
      app.visibleCards[wine.id] = card;
    }

    if (app.isLoading) {
      app.spinner.setAttribute('hidden', true);
      app.container.removeAttribute('hidden');
      app.isLoading = false;
    }

  };

  app.bindWines = function (wines) {
    if (!wines)
      return;
    wines.forEach(function (wine) {
      app.bindWineCard(wine);
    });
    app.saveWines(wines);
  };


  /*****************************************************************************
   *
   * Event listeners for UI elements
   *
   ****************************************************************************/

  document.getElementById('btnRefresh').addEventListener('click', function () {
    app.loadWines();
  });



  app.loadWines = function () {
    var url = "/wines";

    if ('caches' in window) {
      caches.match(url).then(function (response) {
        if (response) {
          response.json().then(function updateFromCache(json) {
            var results = json.query.results;
            app.bindWines(results);
          });
        }
      });
    }

    // Fetch the latest data.
    var request = new XMLHttpRequest();
    request.onreadystatechange = function () {
      if (request.readyState === XMLHttpRequest.DONE) {
        if (request.status === 200) {
          var results = JSON.parse(request.response);
          app.bindWines(results);
        }
      } else {
        app.bindWines(app.lastWines);
      }
    };
    request.open('GET', url);
    request.send();
  };

  app.saveWines = function (wines) {
    localStorage.lastWines = JSON.stringify(wines);
  };

  app.lastWines = localStorage.lastWines;
  if (app.lastWines) {
    app.lastWines = JSON.parse(app.lastWines);
    app.bindWines(app.lastWines);
  } else {
    app.loadWines();
  }

  if ('serviceWorker' in navigator) {
    navigator.serviceWorker
      .register('./service-worker.js')
      .then(function () { console.log('Service Worker Registered'); });
  }
})();
