%% 利用像素得到数据
%% 输入imshow('pressure.png')读入图像
%% 输入ginput选择像素点
%% 生成像素点如下
xiangsu=[ 138.0000  463.0000
  138.0000   46.0000
  668.0000  463.0000
  154.0000  383.0000
  152.0000  373.0000
  156.0000  342.0000
  161.0000  316.0000
  169.0000  274.0000
  172.0000  254.0000
  175.0000  232.0000
  185.0000  205.0000
  194.0000  173.0000
  197.0000  158.0000
  205.0000  136.0000
  211.0000  111.0000
  224.0000   84.0000
  241.0000  101.0000
  249.0000  123.0000
  253.0000  142.0000
  263.0000  176.0000
  267.0000  209.0000
  273.0000  230.0000
  274.0000  245.0000
  280.0000  266.0000
  288.0000  281.0000
  301.0000  259.0000
  305.0000  251.0000
  319.0000  237.0000
  330.0000  246.0000
  339.0000  257.0000
  352.0000  246.0000
  357.0000  233.0000
  367.0000  219.0000
  382.0000  236.0000
  390.0000  256.0000
  395.0000  273.0000
  404.0000  290.0000
  418.0000  298.0000
  435.0000  301.0000
  454.0000  302.0000
  470.0000  309.0000
  486.0000  326.0000
  505.0000  340.0000
  527.0000  354.0000
  546.0000  361.0000
  570.0000  378.0000
  589.0000  392.0000
  607.0000  413.0000
  627.0000  424.0000
  657.0000  433.0000
  667.0000  431.0000
]
%% 下面进行缩放得到实际数据点
for i=1:51
    ai=xiangsu(:,2) %像素点纵坐标
    bi=xiangsu(:,1) %像素点横坐标
    ci=80+(45)/(-417)*(ai-463) %实际数据纵坐标
    di=1/(668-138)*(bi-138)    %实际数据横坐标
    m=[di,ci]
end
%% 删除前三个坐标顶点的数据
t=m(4:51,1:2)
x=t(:,1)
y=t(:,2)
%% 利用得到的数据，使用cftool命令进行拟合