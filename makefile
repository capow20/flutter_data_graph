build_js:
	cd data_graph && npm run build

update_js:
	cd data_graph && npm run build;
	cp ./lib/src/js/index.html ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.html;
	cp ./lib/src/js/index.css ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.css;
	cp ./lib/src/js/index.js ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.js;
	cp ./lib/src/js/index.js.map ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.js.map;

pub_get:
	flutter pub get;
	cd example && flutter pub get;