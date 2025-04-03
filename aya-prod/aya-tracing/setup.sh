dir=tracepoint-binary-tail-calls
project_dir=project
git clone --no-checkout --depth 1 https://github.com/littlejo/aya-examples
cd aya-examples
git sparse-checkout init --cone
git sparse-checkout set $dir
git checkout
mv $dir ../$project_dir
cd ..
rm -rf aya-examples

echo 'pub const EXCLUDE_LIST: [&str; 2] = ["/usr/bin/git", "/opt/theia/node"];' > $project_dir/tracepoint-binary/src/constant.rs
