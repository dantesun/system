if ! [ -d cpp_src ]; then
  tar jxf cpp_src.tar.bz2
fi
ack -a -f $PWD/cpp_src | ctags --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -o stl.tags -L -
