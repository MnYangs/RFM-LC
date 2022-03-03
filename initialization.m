%初始化，启动vlfeat工具箱
addpath('.\vlfeat-0.9.21');

old = cd;

cd .\vlfeat-0.9.21\toolbox
vl_setup;
cd(old);
