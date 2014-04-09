var path = require('path');
var fs = require('fs');

var app = require(path.resolve('app.js'));
var db = app.dataSources.db;

// share options so that db.discoverSchemas can store visited models there
var opts = { relations: true };
var models = {};

db.discoverModelDefinitions(
  {
    schema: db.connector.settings.database
  },
  function(err, tables) {
    if (err) throw err;
    // console.log('Tables: ', tables);

    tables.forEach(function(t) {
      db.discoverSchemas(t.name, { relations: true }, function(err, schemas) {
        for (var mk in schemas) {
          var def = schemas[mk];
          var name = def.name;
          if (name in models) continue;

          models[name] = def;
          delete def.name;
          def.dataSource = 'db';

          console.log('%s (%s/%s)', name,
            Object.keys(models).length, tables.length);
        }

        if (Object.keys(models).length == tables.length) saveAndExit();
      });
    });
  });

function saveAndExit() {
  var outfile = path.resolve('./models.json');
  fs.writeFileSync(outfile, JSON.stringify(models, null, 2), 'utf-8');
  console.log('Discovered %s models, definition was written to %s',
    Object.keys(models).length, outfile);
  process.exit();
}
