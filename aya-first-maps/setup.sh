git clone --no-checkout --depth 1 https://github.com/littlejo/aya-examples
mv aya-examples/tracepoint-binary .
rm -rf aya-examples
docker pull littlejo/aya:slim
