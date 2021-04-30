# Build avx2 version
CXXFLAGS="-mavx2 -mf16c" CPPFLAGS="-DUSE_CPU" ./configure --without-cuda
make -j $CPU_COUNT
make -C python _swigfaiss_avx2.so
make clean

# Build vanilla version (no avx)
CPPFLAGS="-DUSE_CPU" ./configure --without-cuda
make -j $CPU_COUNT
make -C python _swigfaiss.so

make -C python build

cd python

$PYTHON setup.py install --single-version-externally-managed --record=record.txt
