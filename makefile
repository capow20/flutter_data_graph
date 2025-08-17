build_js:
	cd data_graph && npm run build

update_js:
	cd data_graph && npm run build;
	cp ./lib/src/js/index.html ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.html;
	cp ./lib/src/js/index.css ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.css;
	cp ./lib/src/js/index.js ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.js;
	cp ./lib/src/js/index.js.map ./example/build/flutter_assets/packages/flutter_data_graph/lib/src/js/index.js.map;

pub_get:
	cd flutter_data_graph && flutter pub get && cd ..;
	cd example && flutter pub get;

clean:
	cd example && flutter clean && flutter pub get && cd .. && make update_js;