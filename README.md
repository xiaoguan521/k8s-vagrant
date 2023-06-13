# k8s-vagrant
本地通过vagrant 搭建k8s 环境

# 设置时间同步
在 Ubuntu 中设置时区和对时可以按照以下步骤进行：

设置时区：

打开终端。
运行命令 sudo dpkg-reconfigure tzdata。
在弹出的窗口中，选择您所在的地理区域。
然后选择您所在地区的城市。
完成时区设置。
设置时间同步：

在终端中运行以下命令以安装 NTP（Network Time Protocol）工具：sudo apt update && sudo apt install ntp。
安装完成后，NTP 服务将自动启动并开始同步时间。
如果您使用的是桌面版 Ubuntu，系统会自动与时间服务器同步。您可以在 "设置" -> "日期和时间" 中进行相关设置。
手动同步时间（可选）：

如果您希望手动同步时间，可以运行以下命令：sudo ntpdate -s time.nist.gov。
这将使用 NTP 协议从 time.nist.gov 服务器同步时间。
注意，您可以替换 time.nist.gov 为其他可靠的时间服务器。
请注意，以上步骤中的某些操作可能需要管理员权限（使用 sudo 命令）。确保在执行敏感操作时小心谨慎。

完成上述步骤后，您的 Ubuntu 系统应该已经设置了正确的时区并开始同步时间。
# 安装docker

https://www.jianshu.com/p/c49fd0c19162

 sudo apt install docker-ce=5:20.10.17~3-0~ubuntu-focal docker-ce-cli=5:20.10.17~3-0~ubuntu-focal containerd.io

注意这里第6 步的坑，要用 podSubnet: 10.1.0.0/16  # 增加指定pod的网段

# 配置镜像加速器
针对Docker客户端版本大于 1.10.0 的用户

您可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://x1rbuu9p.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

