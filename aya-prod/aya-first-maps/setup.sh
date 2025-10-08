git clone --no-checkout --depth 1 https://github.com/littlejo/aya-examples
cd aya-examples
git sparse-checkout init --cone
git sparse-checkout set tracepoint-binary
git checkout
mv tracepoint-binary ../project
cd ..
rm -rf aya-examples

docker pull littlejo/aya:1.0.2
