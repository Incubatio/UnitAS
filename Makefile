build: clean
	amxmlc -debug=true -static-link-runtime-shared-libraries=true -source-path+=./src/ -output=./build/Test.swf ./src/Main.as
	adl Unit-tests.xml

clean: 
	/bin/rm -rf build

deploy: 
	git push -f origin HEAD:gh-pages
